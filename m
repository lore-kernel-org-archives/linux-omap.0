From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP: EHCI: Fix the hub disconnect after resume
Date: Thu, 28 Jun 2012 11:59:26 +0530
Message-ID: <CAP05o4JY_tCa83agkU25=6icj8ArPhWG1mQn8=_Cm1y5JVLAXg@mail.gmail.com>
References: <1340795719-28386-1-git-send-email-keshava_mgowda@ti.com>
	<Pine.LNX.4.44L0.1206271020590.1665-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41459 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932294Ab2F1G33 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 02:29:29 -0400
Received: by lbok6 with SMTP id k6so3516049lbo.18
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 23:29:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1206271020590.1665-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

On Wed, Jun 27, 2012 at 7:54 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Wed, 27 Jun 2012, Keshava Munegowda wrote:
>
>> Its observed that in Beagle XM , during suspend/resume the OMAP
>> EHCI controller losing the register contents. this is causing the
>> hub disconnect after the resume, this is causing failure of
>> device detection after the resume.
>> to avoid the hub disconnect , The ehci config flag register is
>> configured again , reset the phy and issue the port powers during
>> resume.
>
> The idea is good, but the implementation is wrong.
>
>> +static int omap_ehci_bus_resume(struct usb_hcd *hcd)
>> +{
>> +
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 *dev =3D hcd->self.controller;
>> + =A0 =A0 struct ehci_hcd_omap_platform_data =A0 =A0 =A0*pdata =3D d=
ev->platform_data;
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *regs =3D hcd->regs;
>> +
>> + =A0 =A0 /* In case , ports are not powered and config flag not set=
 */
>> + =A0 =A0 if (~(ehci_read(regs, EHCI_CONFIGFLAG) & 0x01)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ehci_write(regs, EHCI_CONFIGFLAG, 0x1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* An undocumented "feature" in the OMAP=
3 EHCI controller,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* causes suspended ports to be taken ou=
t of suspend when
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the USBCMD.Run/Stop bit is cleared (f=
or example when
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* we do ehci_bus_suspend).
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This breaks suspend-resume if the roo=
t-hub is allowed
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to suspend. Writing 1 to this undocum=
ented register bit
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* disables this feature and restores no=
rmal behavior.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 ehci_write(regs, EHCI_INSNREG04,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EHCI_INSNREG04_DISA=
BLE_UNSUSPEND);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Soft reset the PHY using PHY reset comm=
and over ULPI */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->port_mode[0] =3D=3D OMAP_EHCI_P=
ORT_MODE_PHY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ehci_soft_phy_reset(d=
ev, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->port_mode[1] =3D=3D OMAP_EHCI_P=
ORT_MODE_PHY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ehci_soft_phy_reset(d=
ev, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* root ports should always stay powered *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 ehci_port_power(hcd_to_ehci(hcd), 1);
>> + =A0 =A0 }
>
> This needs to be done in the resume routine, not the bus_resume
> routine. =A0Since ehci-omap doesn't have any suspend or resume routin=
es,
> it's not surprising that the controller doesn't work correctly after
> the system is resumed.
>
> In a couple of days I will submit a patch that will make it a lot
> easier to add suspend and resume routines for EHCI platform drivers.
> Maybe you'd prefer to wait until then to fix this issue.
>
> Alan Stern

Thanks Alan
Ok, I will wait for your patches.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
