From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: 3.5-rc3: vdd_mpu_iva warnings
Date: Wed, 27 Jun 2012 16:22:02 +0100
Message-ID: <WC20120627152202.8001A3@terrafix.co.uk>
References: <WC20120618103957.6103F2@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:60580 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932089Ab2F0PWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 11:22:55 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q5RFMQC6031015
	for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 16:22:50 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.6)
	with ESMTP id md50002242905.msg
	for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 16:22:03 +0100
In-Reply-To: <WC20120618103957.6103F2@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org

Not wanting to be a pest, but I've just tried 3.5-rc4 and the same warnings exist.

I didn't get any response, so am I really the only person seeing this?

Cheers,
Joe Woodward

-----Original Message-----
From: "Joe Woodward" <jw@terrafix.co.uk>
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Mon, 18 Jun 2012 11:39:57 +0100
Subject: 3.5-rc3: vdd_mpu_iva warnings

> I have a GUMSTIX Overo AirSTORM module (AM3703-based).
> 
> When booting the kernel the following features are listed:
> OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
> 
> After booting I get the following (repeating every few seconds):
> 
> [   81.122558] voltdm_scale: No voltage scale API registered for
> vdd_mpu_iva
> [   81.130340] platform mpu.0: omap_target: unable to scale voltage up.
> 
> I have SmartReflex enabled, and the same defconfig used to work on 3.4.
> CONFIG_OMAP_SMARTREFLEX=y
> CONFIG_OMAP_SMARTREFLEX_CLASS3=y
> 
> I'm assuming this is because of changes to twl-common.c to add the
> "IVA" voltage 
> domain, but on the OMAP I have there is no IVA - hence the warnings?
> 
> Is there a known fix for this (disabling SmartReflex seems to make no
> difference)?
> 
> Cheers,
> Joe Woodward
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


