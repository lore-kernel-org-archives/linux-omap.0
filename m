From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: linux-omap pm branch
Date: Tue, 12 May 2009 02:51:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D77FB192@dbde02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A873958F6A4@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbZEKVVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 17:21:38 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4BLLWJj008456
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 16:21:38 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4BLLVTj011690
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 02:51:32 +0530 (IST)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A873958F6A4@dlee01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hunter, Jon
> Sent: Tuesday, May 12, 2009 2:45 AM
> To: linux-omap@vger.kernel.org
> Subject: linux-omap pm branch 
> 
> Hi All,
> 
> I want to run some tests using the linux-omap pm branch on 
> the omap3430 and had a couple questions...
> 
> 1). What omap3430 board(s) are being using to validate the pm 
> branch functionality?

[sp] I believe most common are omap3evm and beagle.

> 
> 2). Is there a list of pm features are currently 
> supported/functional for omap3430? For example, cpuidle, 
> cpufreq, retention, off-mode, smart-reflex, suspend/restore, etc. 

[sp] All of above - though all drivers may not support power
     management. Hence you may see some failures scenarios
     esp. with off mode.

> 
> 3). Are there any userspace tools (such as powertop) that are 
> recommended for monitoring power states?

[sp] You can definitely use powertop.

Best regards,
Sanjeev

> 
> Cheers
> Jon
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 