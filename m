From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: OMPA4: 3.0-rc1: Unhandled fault during insmod 'ohci-hcd.ko'
Date: Tue, 14 Jun 2011 18:59:48 +0800
Message-ID: <BANLkTi=TPNWMe9_gb7SY2J62SC0L8EoRcw@mail.gmail.com>
References: <BANLkTinYcxJqUM4G2ERew3okUTdf0LOLGA@mail.gmail.com>
	<BANLkTin=7aEaPDf=2Aa9SApdGetyvdz50g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61502 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab1FNK7u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 06:59:50 -0400
Received: by wya21 with SMTP id 21so3796038wya.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 03:59:49 -0700 (PDT)
In-Reply-To: <BANLkTin=7aEaPDf=2Aa9SApdGetyvdz50g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>, keshava_mgowda@ti.com, sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

2011/6/5 Todd Poynor <toddpoynor@google.com>:
> In general, the imprecise external abort usually means an access was =
made to
> registers of a module whose clock is gated. =A0The calls to clk_enabl=
e()
> within=A0usbhs_enable() probably aren't following the proper sequence=
 of
> ensuring the CD_L3_INIT clock domain is on (CM_L3INIT_CLKSTCTRL.CLKTR=
CTRL =3D
> 0x2 SW_WKUP) and then the associated module slaves woken up
> (CM_L3INIT_HSUSBHOST_CLKCTRL.MODULEMODE =3D 0x2 Enabled, similar
> for=A0CM_L3INIT_HSUSBTLL_CLKCTRL). =A0Probably needs calls to the OMA=
P device
> layer to set those up, but I dunno the details of this device or why =
it
> broke.
>

No doubt, it is caused by gated clock, ehci will be OK if revert the
commit below:

commit 7e6502d577106fb5b202bbaac64c5f1b065e6daa
Author: Keshava Munegowda <Keshava_mgowda@ti.com>
Date:   Sun May 22 22:51:26 2011 +0200

    mfd: Add omap-usbhs runtime PM support

    The usbhs core driver does not enable/disable the interface and
    functional clocks; These clocks are handled by hwmod and runtime pm=
,
    hence insted of the clock enable/disable, the runtime pm APIS are
    used. however,the port clocks and tll clocks are handled
    by the usbhs core.

    Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>


--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
