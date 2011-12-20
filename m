From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 2/2] arm:omap: cleanup & split
 omap2/3/4_check_revision function
Date: Tue, 20 Dec 2011 04:38:47 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A80623CE@DBDE01.ent.ti.com>
References: <1324290015-12679-1-git-send-email-hvaibhav@ti.com>
 <1324290015-12679-3-git-send-email-hvaibhav@ti.com>
 <20111219235111.GX6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab1LTEiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 23:38:52 -0500
In-Reply-To: <20111219235111.GX6464@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, December 20, 2011 5:21 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin
> Subject: Re: [PATCH-V3 2/2] arm:omap: cleanup & split
> omap2/3/4_check_revision function
> 
> * Vaibhav Hiremath <hvaibhav@ti.com> [111219 01:48]:
> > This patch doesn't change functionality or behavior of the code
> > execution; it barely cleans up the code and splits into SoC
> > specific implementation for Rev ID and feature detection.
> 
> Thanks, looks good now and allows further clean-up later on.
> I'll apply these into soc-part2 branch.
> 
Thanks Tony.

Thanks,
Vaibhav


> > @@ -495,37 +498,6 @@ static void __init omap4_check_revision(void)
> >  }
> >
> >  /*
> > - * Try to detect the exact revision of the omap we're running on
> > - */
> > -void __init omap2_check_revision(void)
> > -{
> > -	/*
> > -	 * At this point we have an idea about the processor revision set
> > -	 * earlier with omap2_set_globals_tap().
> > -	 */
> > -	if (cpu_is_omap24xx()) {
> > -		omap24xx_check_revision();
> > -	} else if (cpu_is_omap34xx()) {
> > -		omap3_check_revision();
> > -
> > -		/* TI81XX doesn't have feature register */
> > -		if (!cpu_is_ti81xx())
> > -			omap3_check_features();
> > -		else
> > -			ti81xx_check_features();
> > -
> > -		omap3_cpuinfo();
> > -		return;
> > -	} else if (cpu_is_omap44xx()) {
> > -		omap4_check_revision();
> > -		omap4_check_features();
> > -		return;
> > -	} else {
> > -		pr_err("OMAP revision unknown, please fix!\n");
> > -	}
> > -}
> > -
> 
> Nice that we can get rid of this function now :)
> 
> Tony
