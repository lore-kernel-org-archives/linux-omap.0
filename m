From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Ftrace Timer on OMAP3
Date: Mon, 28 May 2012 06:56:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA38110@DBDE01.ent.ti.com>
References: <4FBFA2EB.708@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38612 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab2E1G4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 May 2012 02:56:32 -0400
In-Reply-To: <4FBFA2EB.708@uni-dortmund.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Klute <thomas2.klute@uni-dortmund.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Carsten Vogel <carsten.vogel@rub.de>

On Fri, May 25, 2012 at 20:49:07, Thomas Klute wrote:
> Hi everyone,
> 
> we're having some trouble getting useful results from Ftrace on OMAP3
> (Gumstix Overo). As you can see in the example output below, function
> duration can't be displayed with a precision higher than about 30.5 us,
> which matches the frequency of the 32 kHz platform timer. For OMAP1,
> using OMAP_MPU_TIMER instead of CONFIG_OMAP_32K_TIMER should provide
> better results [1], but I couldn't find anything similar for OMAP3. Just
> setting CONFIG_OMAP_32K_TIMER=N didn't change the results. Did I miss
> anything, or isn't there any more precise timer?
> 

I believe you are using mainline kernel here, if yes, you should be enabling 
the dmtimer using commandline argument, "clocksource="gp_timer".

Thanks,
Vaibhav

