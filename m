From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Fri, 23 Nov 2012 12:44:16 +0200
Message-ID: <20121123104416.GD29585@arwen.pp.htv.fi>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
 <50ACFC5D.1090406@ti.com>
 <20121121195436.GF14290@arwen.pp.htv.fi>
 <50AD7C2C.7000608@linaro.org>
 <20121122121845.GB18022@arwen.pp.htv.fi>
 <50AE2D51.5060001@linaro.org>
 <20121122135603.GA20066@arwen.pp.htv.fi>
 <50AE3E1D.9000607@ti.com>
 <20121122161228.GB20665@arwen.pp.htv.fi>
 <50AF4EB8.9010800@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50AF4EB8.9010800-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 12:23:52PM +0200, Roger Quadros wrote:
> On 11/22/2012 06:12 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Nov 22, 2012 at 05:00:45PM +0200, Roger Quadros wrote:
> >> On 11/22/2012 03:56 PM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Thu, Nov 22, 2012 at 09:49:05PM +0800, Andy Green wrote:
> >>>>> Again it sounds like something that should be done at the hub driver
> >>>>> level. I mean using the GPIO (for reset) and Power Regulator.
> >>>>>
> >>>>> not implementing the regulator part itself, but using it.
> >>>>
> >>>> If you mean change the regulator managing code from living in
> >>>> omap-hsusb to ehci-hcd, it sounds like a good idea.
> >>>
> >>> I mean that drivers/usb/core/hub.c should manage it, since that's what
> >>> actually manages the HUB entity.
> >>
> >> Yes. I agree that powering up the on-board hubs should be done
> >> generically and not in ehci-omap.c. I'm not sure how it can be done in
> >> hub.c.
> >>
> >> I'm assuming that such problem is limited to root hub ports where syst=
em
> >=20
> > an external LAN95xx HUB is not the roothub. LAN95xx is connected to the
> > roothub.
> >=20
>=20
> I didn't say LAN95xx is the root hub. It is connected to the root hub.
> So it is in theory, the root hub port's responsibility to power the LAN95=
xx.

no, it's LAN95xx's responsibility to power itself up. What if you had
multiple tiers of LAN95xx ?

> >> designers have the flexibility to provide power to the peripherals
> >> outside the USB Hub specification.
> >>
> >> I can think of two solutions
> >>
> >> 1) Associate the regulators with the root hub _ports_ and enable them =
as
> >> part of port's power-up routine.
> >=20
> > doesn't make sense. We need to figure out a way to attach the regulator
> > to the ports which actually have them. In this case it's the external
> > LAN95xx, right ?
>=20
> I think you are confused here. The LAN95xx's ports are compatible with
> USB hub specification and they work using the in-band set_port_feature
> mechanism already. We have a problem powering the LAN95xx itself which
> ideally should have been powered with set_port_feature on the root hub.
> (or ehci_port_power() in this case).

I don't set_port_feature() has anything to do with the problem here.
It's not working because the controller's supply isn't turned on. How
can any port be turned on if the supply isn't turned on ?

I still think, however, the hub needs to know how to power itself up.

> > The patch below is *CLEARLY WRONG* it's just to illustrate how this
> > could be started:
> >=20
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 1af04bd..662d4cf 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/freezer.h>
> >  #include <linux/random.h>
> > +#include <linux/regulator/consumer.h>
> > =20
> >  #include <asm/uaccess.h>
> >  #include <asm/byteorder.h>
> > @@ -44,6 +45,7 @@ struct usb_port {
> >  	struct device dev;
> >  	struct dev_state *port_owner;
> >  	enum usb_port_connect_type connect_type;
> > +	struct regulator *port_regulator;
> >  };
> > =20
> >  struct usb_hub {
> > @@ -847,8 +849,41 @@ static unsigned hub_power_on(struct usb_hub *hub, =
bool do_delay)
> >  	else
> >  		dev_dbg(hub->intfdev, "trying to enable port power on "
> >  				"non-switchable hub\n");
> > -	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++)
> > +	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++) {
> > +		regulator_enable(hub->ports[port1]->port_regulator);
> >  		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> > +	}
> > +
> > +	/* Wait at least 100 msec for power to become stable */
> > +	delay =3D max(pgood_delay, (unsigned) 100);
> > +	if (do_delay)
> > +		msleep(delay);
> > +	return delay;
> > +}
> > +
> > +static unsigned hub_power_off(struct usb_hub *hub, bool do_delay)
> > +{
> > +	int port1;
> > +	unsigned pgood_delay =3D hub->descriptor->bPwrOn2PwrGood * 2;
> > +	unsigned delay;
> > +	u16 wHubCharacteristics =3D
> > +			le16_to_cpu(hub->descriptor->wHubCharacteristics);
> > +
> > +	/* Disable power on each port.  Some hubs have reserved values
> > +	 * of LPSM (> 2) in their descriptors, even though they are
> > +	 * USB 2.0 hubs.  Some hubs do not implement port-power switching
> > +	 * but only emulate it.  In all cases, the ports won't work
> > +	 * unless we send these messages to the hub.
> > +	 */
> > +	if ((wHubCharacteristics & HUB_CHAR_LPSM) < 2)
> > +		dev_dbg(hub->intfdev, "disabling power on all ports\n");
> > +	else
> > +		dev_dbg(hub->intfdev, "trying to disable port power on "
> > +				"non-switchable hub\n");
> > +	for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1++) {
> > +		regulator_disable(hub->ports[port1]->port_regulator);
> > +		clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> > +	}
> > =20
> >  	/* Wait at least 100 msec for power to become stable */
> >  	delay =3D max(pgood_delay, (unsigned) 100);
> > @@ -1336,6 +1371,9 @@ static int hub_configure(struct usb_hub *hub,
> >  		goto fail;
> >  	}
> > =20
> > +	if (hub->has_external_port_regulator) /* maybe implement with a quirk=
 flag ??? */
> > +		regulator_get(hub_dev, "hub_port_supply\n");
> > +
> >  	wHubCharacteristics =3D le16_to_cpu(hub->descriptor->wHubCharacterist=
ics);
> > =20
> >  	/* FIXME for USB 3.0, skip for now */
> > @@ -4205,8 +4243,10 @@ static void hub_port_connect_change(struct usb_h=
ub *hub, int port1,
> > =20
> >  		/* maybe switch power back on (e.g. root hub was reset) */
> >  		if ((wHubCharacteristics & HUB_CHAR_LPSM) < 2
> > -				&& !port_is_power_on(hub, portstatus))
> > +				&& !port_is_power_on(hub, portstatus)) {
> > +			regulator_enable(hub->ports[port1]->port_regulator);
> >  			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
> > +		}
> > =20
> >  		if (portstatus & USB_PORT_STAT_ENABLE)
> >    			goto done;
> >=20
> > Note that if we have a single regulator, than all ports' regulators
> > should point to the same struct regulator so that regulator_get() and
> > regulator_put() can do proper reference counting.
> >=20
> > This is just an idea though.
> >=20
>=20
> Thanks for the example. The only problem is, how do we associate a
> regulator to a specific port in the system.

heh, that's the 1 million dollar question, isn't it ? :-)

that's what we need to figure out now. Luckily we have Alan Stern
helping us out ;-)

--=20
balbi

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr1OAAAoJEIaOsuA1yqREnz4QAJ1ygnQxBW6ULHtszeusRuoU
S4SLR1zVM/a7A17i9dfO+LrAi6YqyGx2XecHA6O8EhCbKb76lecx84DPmxhIZlS/
QQ8xcKoPgVLtRZM+Bn6me9p2hZi+rRDqQ1Gx3FWOhHI/N3D3msASBO4FBdDUIgvB
+qXAdZh9MnAgqz35dGNeZUuAJEIgY9ibOD0t9PDYIQzAEuAtMvu53OryGHXp3Tvm
02WlfwzQtKS/jXaiV6s/Q9vpyRhx8Lfr9J6gL4WzsOZrIp2lDKsKkOnySeaO8wmx
2sX5S0eNXv9WBRfTahRrKp2Tyeq6tcscA3R1e2mZ/s5Lyq+hdxTs+RfHOkDNzjEj
Uxnz3ponn4Q947jVJm4k0v6jZEDV/eok6e3PpqBMmuU2hMQwaq60O9f+L2AVOTTS
oU2ndbt+wvn+lgElo6tuofAow6XJ1UVVVJJK/soCib5TrlxWyV2oWvhBU1OXM1Z2
JpcBUfWHN/7tUjzlMYdcmrEBQQp/2ds0TxtOvyie/mH0dpEJZ1l9NQhl9+uPp5Av
sQ0t0hPN2JAUYTo5zic4DgdlQfqysJ4BwJotXsZzbBOMdby1YcbYnLf1JWL9mk4x
riZPbodk61vYGINyI7N+AXFxk7eqRF9Q/3irbDu9RolAzm3eWveOGRVSD9NfGxQo
2MFH54pAKmv3u8t9rKIs
=ao6J
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
