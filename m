From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest regressions
Date: Fri, 7 Jan 2011 14:41:23 +0000
Message-ID: <20110107144123.GA28049@n2100.arm.linux.org.uk>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60282 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1AGOl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:41:28 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PbDVN-0001kH-Fv
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 14:41:25 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PbDVM-0007Ls-AK
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 14:41:24 +0000
Content-Disposition: inline
In-Reply-To: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

While trying to build the latest kernel for the SDP4430 board:

arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0_enable_hwsup=E2=
=96=A0:
arch/arm/mach-omap2/clockdomain.c:251: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c:254: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0_disable_hwsup=E2=
=96=A0:
arch/arm/mach-omap2/clockdomain.c:277: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c:280: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0omap2_clkdm_sle=
ep=E2=96=A0:
arch/arm/mach-omap2/clockdomain.c:744: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0omap2_clkdm_wak=
eup=E2=96=A0:
arch/arm/mach-omap2/clockdomain.c:789: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0omap2_clkdm_clk=
_enable=E2=96=A0:
arch/arm/mach-omap2/clockdomain.c:922: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c:926: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c: In function =E2=96=A0omap2_clkdm_clk=
_disable=E2=96=A0:
arch/arm/mach-omap2/clockdomain.c:994: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0
arch/arm/mach-omap2/clockdomain.c:998: error: =E2=96=A0struct clockdoma=
in=E2=96=A0 has no member named =E2=96=A0clktrctrl_mask=E2=96=A0

Linus' tree prior to the OMAP merge is buildable for the same config.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
