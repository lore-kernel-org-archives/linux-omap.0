From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 18:12:28 +0200
Message-ID: <20121122161228.GB20665@arwen.pp.htv.fi>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
 <50ACFC5D.1090406@ti.com>
 <20121121195436.GF14290@arwen.pp.htv.fi>
 <50AD7C2C.7000608@linaro.org>
 <20121122121845.GB18022@arwen.pp.htv.fi>
 <50AE2D51.5060001@linaro.org>
 <20121122135603.GA20066@arwen.pp.htv.fi>
 <50AE3E1D.9000607@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50AE3E1D.9000607-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 05:00:45PM +0200, Roger Quadros wrote:
> On 11/22/2012 03:56 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Nov 22, 2012 at 09:49:05PM +0800, Andy Green wrote:
> >>> Again it sounds like something that should be done at the hub driver
> >>> level. I mean using the GPIO (for reset) and Power Regulator.
> >>>
> >>> not implementing the regulator part itself, but using it.
> >>
> >> If you mean change the regulator managing code from living in
> >> omap-hsusb to ehci-hcd, it sounds like a good idea.
> >=20
> > I mean that drivers/usb/core/hub.c should manage it, since that's what
> > actually manages the HUB entity.
>=20
> Yes. I agree that powering up the on-board hubs should be done
> generically and not in ehci-omap.c. I'm not sure how it can be done in
> hub.c.
>=20
> I'm assuming that such problem is limited to root hub ports where system

an external LAN95xx HUB is not the roothub. LAN95xx is connected to the
roothub.

> designers have the flexibility to provide power to the peripherals
> outside the USB Hub specification.
>=20
> I can think of two solutions
>=20
> 1) Associate the regulators with the root hub _ports_ and enable them as
> part of port's power-up routine.

doesn't make sense. We need to figure out a way to attach the regulator
to the ports which actually have them. In this case it's the external
LAN95xx, right ?

> 2) Have a global list of regulators that are registered by platform code
> and enabled them all at once on hcd init.

also wrong as it might cause increased power consumption even when only
a single USB port is currently in use.

The patch below is *CLEARLY WRONG* it's just to illustrate how this
could be started:

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1af04bd..662d4cf 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/freezer.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
=20
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -44,6 +45,7 @@ struct usb_port {
 	struct device dev;
 	struct dev_state *port_owner;
 	enum usb_port_connect_type connect_type;
+	struct regulator *port_regulator;
 };
=20
 struct usb_hub {
@@ -847,8 +849,41 @@ static unsigned hub_power_on(struct usb_hub *hub, bool=
 do_delay)
 	else
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
-	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++)
+	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++) {
+		regulator_enable(hub->ports[port1]->port_regulator);
 		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+	}
+
+	/* Wait at least 100 msec for power to become stable */
+	delay =3D max(pgood_delay, (unsigned) 100);
+	if (do_delay)
+		msleep(delay);
+	return delay;
+}
+
+static unsigned hub_power_off(struct usb_hub *hub, bool do_delay)
+{
+	int port1;
+	unsigned pgood_delay =3D hub->descriptor->bPwrOn2PwrGood * 2;
+	unsigned delay;
+	u16 wHubCharacteristics =3D
+			le16_to_cpu(hub->descriptor->wHubCharacteristics);
+
+	/* Disable power on each port.  Some hubs have reserved values
+	 * of LPSM (> 2) in their descriptors, even though they are
+	 * USB 2.0 hubs.  Some hubs do not implement port-power switching
+	 * but only emulate it.  In all cases, the ports won't work
+	 * unless we send these messages to the hub.
+	 */
+	if ((wHubCharacteristics & HUB_CHAR_LPSM) < 2)
+		dev_dbg(hub->intfdev, "disabling power on all ports\n");
+	else
+		dev_dbg(hub->intfdev, "trying to disable port power on "
+				"non-switchable hub\n");
+	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++) {
+		regulator_disable(hub->ports[port1]->port_regulator);
+		clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+	}
=20
 	/* Wait at least 100 msec for power to become stable */
 	delay =3D max(pgood_delay, (unsigned) 100);
@@ -1336,6 +1371,9 @@ static int hub_configure(struct usb_hub *hub,
 		goto fail;
 	}
=20
+	if (hub->has_external_port_regulator) /* maybe implement with a quirk fla=
g ??? */
+		regulator_get(hub_dev, "hub_port_supply\n");
+
 	wHubCharacteristics =3D le16_to_cpu(hub->descriptor->wHubCharacteristics);
=20
 	/* FIXME for USB 3.0, skip for now */
@@ -4205,8 +4243,10 @@ static void hub_port_connect_change(struct usb_hub *=
hub, int port1,
=20
 		/* maybe switch power back on (e.g. root hub was reset) */
 		if ((wHubCharacteristics & HUB_CHAR_LPSM) < 2
-				&& !port_is_power_on(hub, portstatus))
+				&& !port_is_power_on(hub, portstatus)) {
+			regulator_enable(hub->ports[port1]->port_regulator);
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+		}
=20
 		if (portstatus & USB_PORT_STAT_ENABLE)
   			goto done;

Note that if we have a single regulator, than all ports' regulators
should point to the same struct regulator so that regulator_get() and
regulator_put() can do proper reference counting.

This is just an idea though.

--=20
balbi

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrk7sAAoJEIaOsuA1yqREmeYP/iDbsqWfyBWo/1RuLaOdZ0H7
XprCtpzOfqyrHmVZW/IYCwcPyiE+rDiv5d3qZuq9cZGU4Q4KlYMSRvkbSfH8DF8I
I59t099A2yYsP8ZJUi0gnIUPkbjDr+zrD2hR5br5Qjwn85FzM2zy6yBabmqDo+zi
wA14SBHT2vPLA8SXzAsPmR+bzwxYRGRe6pkZEQtnOLivoMdoQA9ycH9dPzGUWbQW
f8uM9LCUAKYlOGcy3eNQUEKDARAGsqxOO4k4FH6yXCJOZ5zP8H+45Lz0vUUHSobK
PrGAuLXbQCd6Z3JYY0mPP0kUjLwzXbXRIZOHPgrlhGw9Q3k+xmfH7AZqJ21xIJTm
0jXDT93wuhtuHxVreZe+0JmTgd82I78NwvZQtYrxB77cWGDkjpCr7EeCLGhJ3cnW
4juUuzTkK0sgZrDjTY/Vhy/uzrxFjyTTPHbtrJ7x0J9YZhshN1IpMXT+TCeIaXSe
ZAdj34+ISyjhJsehnbjXb/yNX3hOgwTzcjJSH44LhzRoJUucpUAlVgcMIYrbncRV
A0+4U5M3KUoQ9xNtYinDSLEfY79nSODTPSZZIs3v1nsuWoUufaHRKneY3hHpzAdT
qhCP2OBM0MTv/buDkomN66U8j7RyiGOPudsHE4493E2H0bEmxV2My9eICVcpZzlv
p4GocX4QcDmoDepa0wEp
=5TNv
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
