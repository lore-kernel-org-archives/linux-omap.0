From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC
 addresses for eth0 and wlan0
Date: Fri, 25 Mar 2011 16:13:05 -0400
Message-ID: <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
	<20110324212737.14936.21228.stgit@otae.warmcat.com>
	<78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54021 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1CYUNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:13:08 -0400
Received: by qwk3 with SMTP id 3so841915qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 13:13:06 -0700 (PDT)
In-Reply-To: <78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>
Cc: Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, arnd@arndb.de, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

On Fri, Mar 25, 2011 at 3:39 AM, Hema Kalliguddi <hemahk@ti.com> wrote:
> Hi,
>
> one Minor comment.
>
>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org
>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andy Green
>>Sent: Friday, March 25, 2011 2:58 AM
>>To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
>>Cc: patches@linaro.org; nicolas.pitre@linaro.org;
>>arnd@arndb.de; x0132446@ti.com; s-jan@ti.com;
>>tony@atomide.com; Alan Cox; Andy Green
>>Subject: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or
>>missing MAC addresses for eth0 and wlan0
>>
>>This patch registers a network device notifier callback to set the ma=
c
>>addresses for the onboard network assets of Panda correctly,
>>despite the
>>drivers involved have used a random or all-zeros MAC address.
>>
>>The technique was suggested by Alan Cox on lkml.
>>
>>It works by device path so it corrects the MAC addresses even if the
>>drivers are in modules loaded in an order that changes their interfac=
e
>>name from usual (eg, the onboard module might be "wlan1" if there is =
a
>>USB wireless stick plugged in and its module is inserted first.)
>>
>>Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>Signed-off-by: Andy Green <andy.green@linaro.org>

I very much like this approach.  I believed the ability to use the die
ID to get a unique code was reasonable approach and that is why I
didn't get an EEPROM put onto the BeagleBoard, though Gerald is
looking at adding one on a future revision because the lack of one
wasn't well received.  Minor questions below.

>>---
>>
>> arch/arm/mach-omap2/board-omap4panda.c | =A0 91
>>++++++++++++++++++++++++++++++++
>> 1 files changed, 91 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>>b/arch/arm/mach-omap2/board-omap4panda.c
>>index 80b8860..0b92873 100644
>>--- a/arch/arm/mach-omap2/board-omap4panda.c
>>+++ b/arch/arm/mach-omap2/board-omap4panda.c
>>@@ -28,9 +28,12 @@
>> #include <linux/regulator/machine.h>
>> #include <linux/regulator/fixed.h>
>> #include <linux/wl12xx.h>
>>+#include <linux/netdevice.h>
>>+#include <linux/if_ether.h>
>>
>> #include <mach/hardware.h>
>> #include <mach/omap4-common.h>
>>+#include <mach/id.h>
>> #include <asm/mach-types.h>
>> #include <asm/mach/arch.h>
>> #include <asm/mach/map.h>
>>@@ -506,6 +509,92 @@ static inline void board_serial_init(void)
>> }
>> #endif
>>
>>+/*
>>+ * These device paths represent the onboard USB <-> Ethernet
>>bridge, and
>>+ * the WLAN module on Panda, both of which need their random
>>or all-zeros
>>+ * mac address replacing with a per-cpu stable generated one
>>+ */
>>+
>>+static const char * const panda_fixup_mac_device_paths[] =3D {
>>+ =A0 =A0 =A0"usb1/1-1/1-1.1/1-1.1:1.0",
>>+ =A0 =A0 =A0"mmc1:0001:2",
>>+};
>>+
>>+static int panda_device_path_need_mac(struct device *dev)
>>+{
>>+ =A0 =A0 =A0const char **try =3D panda_fixup_mac_device_paths;
>>+ =A0 =A0 =A0const char *path;
>>+ =A0 =A0 =A0int count =3D ARRAY_SIZE(panda_fixup_mac_device_paths);
>>+ =A0 =A0 =A0const char *p;
>>+ =A0 =A0 =A0int len;
>>+ =A0 =A0 =A0struct device *devn;
>>+
>>+ =A0 =A0 =A0while (count--) {
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D *try + strlen(*try);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D dev;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0while (devn) {
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0path =3D dev_name(devn);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D strlen(path);
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((p - *try) < len) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D=
 NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue=
;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p -=3D len;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strncmp(path, p, len=
)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D=
 NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue=
;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D devn->parent;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p =3D=3D *try)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return c=
ount;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (devn !=3D NULL && (p=
 - *try) < 2)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D=
 NULL;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p--;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (devn !=3D NULL && *p=
 !=3D '/')
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devn =3D=
 NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0try++;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0return -ENOENT;
>>+}
>>+
>>+static int omap_panda_netdev_event(struct notifier_block *this,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long

The use of the OMAP die id below makes this OMAP specific and the list
referenced below of the devices to be referenced makes it Panda
specific.  Is there a way to make the list board specific, but to make
these functions that will be used across many OMAP platforms reusable?
 I believe that this current code will result in a lot of
cut-and-paste.  My preference is that this is accepted and that we
make this more general when we add this to other OMAP platforms, but
it'd be great to capture your suggestions on how to do so before those
cut-and-paste patch sets start coming in.

>>event, void *ptr)
>>+{
>>+ =A0 =A0 =A0struct net_device *dev =3D ptr;
>>+ =A0 =A0 =A0struct sockaddr sa;
>>+ =A0 =A0 =A0int n;
>>+
>>+ =A0 =A0 =A0if (event !=3D NETDEV_REGISTER)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return NOTIFY_DONE;
>>+
>>+ =A0 =A0 =A0n =3D panda_device_path_need_mac(dev->dev.parent);
>>+ =A0 =A0 =A0if (n >=3D 0) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_family =3D dev->type;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_die_id_to_ethernet_mac(sa.sa_data,=
 n);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->netdev_ops->ndo_set_mac_address(dev=
, &sa);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0return NOTIFY_DONE;
>>+}
>>+
>>+static struct notifier_block omap_panda_netdev_notifier =3D {
>>+ =A0 =A0 =A0.notifier_call =3D omap_panda_netdev_event,
>>+ =A0 =A0 =A0.priority =3D 1,
>>+};
>>+
>>+
>
> One extra blank line not needed.
>
> Regards,
> Hema
>
>> static void __init omap4_panda_init(void)
>> {
>> =A0 =A0 =A0 int package =3D OMAP_PACKAGE_CBS;
>>@@ -517,6 +606,8 @@ static void __init omap4_panda_init(void)
>> =A0 =A0 =A0 if (wl12xx_set_platform_data(&omap_panda_wlan_data))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error setting wl12xx data\n");
>>
>>+ =A0 =A0 =A0register_netdevice_notifier(&omap_panda_netdev_notifier)=
;
>>+

I just want to make sure I understand how this works.  When a new
network device is added, if the device name matches one of the above
listed device paths, then the die id based MAC id is applied.  This
must be done via a device registration notifier as the registration is
triggered when the device is detected.

>> =A0 =A0 =A0 omap4_panda_i2c_init();
>> =A0 =A0 =A0 platform_add_devices(panda_devices, ARRAY_SIZE(panda_dev=
ices));
>> =A0 =A0 =A0 platform_device_register(&omap_vwlan_device);
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe
>>linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
