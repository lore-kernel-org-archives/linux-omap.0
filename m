From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 12 Apr 2012 17:21:36 +0530
Message-ID: <CAMrsUdLb-KUqa1ydCF3KweqHzJDftEnNF+5U67SLi=GyE-NfPg@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
 <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com>
 <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
 <87zkalc75h.fsf@ti.com> <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com>
 <874nssde5h.fsf@ti.com> <CAMrsUd+SLko-L=B9gfqSpdcYQrqmAgXa0yFVWrR2YXuW9FBLmQ@mail.gmail.com>
 <87fwcb5urr.fsf@ti.com> <CAMrsUd+-5_6dFxcj=BCt+gHwnzA7zBev0t_nQ3dQAGZzWq8X0w@mail.gmail.com>
 <alpine.DEB.2.00.1204111323210.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:56861 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932776Ab2DLLv5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 07:51:57 -0400
Received: by obbtb18 with SMTP id tb18so3378402obb.5
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 04:51:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204111323210.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org

On Thu, Apr 12, 2012 at 1:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> a few brief comments based on a quick scan:
>
> On Wed, 11 Apr 2012, Raja, Govindraj wrote:
>
>> Here is the patch [1] to do the same.
>
> - I don't see where it affects I/O wakeups for the UART. =A0If I/O wa=
keups
> are still set on the UART pads, won't that still wake the chip up fro=
m
> suspend, even if module-level wakeups are disabled?

pdata->enable_wakeup =3D> omap_uart_enable_wakeup
was disabling both module level and pad wakeup.

omap_uart_enable_wakeup =3D> has enabling/disabling both
module level and pad wakeup together.

>
> - The UART driver and integration code should not be reading from or
> writing to registers outside the UART IP block. =A0PRM register reads=
 and
> writes belong in the PRM code, which should then export a higher-leve=
l
> interface to the calling code. =A0This is because, aside from making =
the
> code easier to read and debug, we're trying to move the PRM and CM co=
de to
> drivers/.

okay.

>
> - The code to change the PM_WKEN* and test the PM_WKST* bits should
> probably be called from omap_hwmod_{enable,disable}_wakeup(), not the=
 UART
> code directly. =A0The UART code shouldn't need to care about the hard=
ware
> details; it should just ask the integration layer to enable or disabl=
e
> module-level wakeups.

To implement this I plan to extend the omap_hwmod_omap2_prcm structure
like this:

(unaligned tmp code snippet)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8070145..5c7711b 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -343,6 +343,8 @@ struct omap_hwmod_class_sysconfig {
  * @idlest_reg_id: IDLEST register ID (e.g., 3 for CM_IDLEST3)
  * @idlest_idle_bit: register bit shift for CM_IDLEST slave idle bit
  * @idlest_stdby_bit: register bit shift for CM_IDLEST master standby =
bit
+ * @module_wakeup_offs: PRCM register offset for PM_WKEN
+ * @module_wakeup_bit: regiter bit mask for PM_WKEN
  *
  * @prcm_reg_id and @module_bit are specific to the AUTOIDLE, WKST,
  * WKEN, GRPSEL registers.  In an ideal world, no extra information
@@ -357,6 +359,8 @@ struct omap_hwmod_omap2_prcm {
        u8 idlest_reg_id;
        u8 idlest_idle_bit;
        u8 idlest_stdby_bit;
+       s16 module_wakeup_offs;
+       u32 module_wakeup_bit;
 };

>
> As you work on these changes, please split them up into several diffe=
rent
> topic series - one for the PRM changes, one for hwmod code/data chang=
es,
> and one for the UART driver/integration changes. =A0Just note the
> dependencies in the series description E-mails. =A0That way, we can a=
void
> merge conflicts.
>

Yes fine. Since most changes will be on /mach-omap2/omap_hwmod*.c
Do you prefer the patches to be on any particular tree/branch where hwm=
od fixes
are already queued.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
