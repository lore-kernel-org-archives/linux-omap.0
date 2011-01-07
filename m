From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest regressions
Date: Fri, 7 Jan 2011 14:57:54 +0000
Message-ID: <20110107145754.GP1198@n2100.arm.linux.org.uk>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk> <20110107144123.GA28049@n2100.arm.linux.org.uk> <041d2be25d29537d75bea1d949249176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57228 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab1AGO6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:58:02 -0500
Content-Disposition: inline
In-Reply-To: <041d2be25d29537d75bea1d949249176@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 07, 2011 at 08:24:26PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> > Sent: Friday, January 07, 2011 8:11 PM
> > To: linux-omap@vger.kernel.org
> > Subject: Re: Latest regressions
> >
> > While trying to build the latest kernel for the SDP4430 board:
> >
> > arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82_enable_hws=
up=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:251: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c:254: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82_disable_hw=
sup=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:277: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c:280: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82omap2_clkdm=
_sleep=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:744: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c: In function =E2=94=82omap2_clkdm=
_wakeup=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:789: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c: In function
> > =E2=94=82omap2_clkdm_clk_enable=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:922: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c:926: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c: In function
> > =E2=94=82omap2_clkdm_clk_disable=E2=94=82:
> > arch/arm/mach-omap2/clockdomain.c:994: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> > arch/arm/mach-omap2/clockdomain.c:998: error: =E2=94=82struct clock=
domain=E2=94=82
> > has no member named =E2=94=82clktrctrl_mask=E2=94=82
> >
> > Linus' tree prior to the OMAP merge is buildable for the same
> > config.
> :)  This one is also fixed with the series but would get merged in rc=
1
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html

It's something that should be queued up to also go in during the merge
window IMHO.  Let's try to make rc1 a little less problematical than it
currently is.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
