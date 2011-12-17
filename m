From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Sat, 17 Dec 2011 16:08:14 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A805FE52@DBDE01.ent.ti.com>
References: <1324037006-31984-1-git-send-email-hvaibhav@ti.com>
 <20111217012730.GD6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39775 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab1LQQIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Dec 2011 11:08:20 -0500
In-Reply-To: <20111217012730.GD6464@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, December 17, 2011 6:58 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin
> Subject: Re: [PATCH-V2] arm:omap: cleanup & split omap2/3/4_check_revision
> function
> 
> * Vaibhav Hiremath <hvaibhav@ti.com> [111216 03:32]:
> > This patch doesn't change functionality or behavior of the code
> > execution; it barely cleans up the code and splits into SoC
> > specific implementation for Rev ID and feature detection.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > Changes from V1:
> > 	- Incorporated suggessions from Tony to split the function
> 
> Thanks for working on this, the end result looks much better.
> 
> Can you please split it into two or more patches as this patch
> is pretty much unreadable unfortunately?
> 
> Maybe add empty check_revision functions first or something
> like that so the diff stays readable?
> 
> Also..
> 
> > +static void __init omap3_cpuinfo(const char *cpu_rev)
> > +{
> > +	const char *cpu_name;
> 
> ..the _cpuinfo functions can now be void as the cpu_rev
> is already set globally?
> 
Thanks Tony,

I will incorporate all the changes (split the patch) and submit the patch series now.

Thanks,
Vaibhav

> Regards,
> 
> Tony
