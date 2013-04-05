From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 17:23:24 -0500
Message-ID: <20130405222324.GA8732@kahuna>
References: <20130405163254.GA7259@kahuna>
 <20130405170527.GC10155@atomide.com>
 <20130405171750.GA7398@kahuna>
 <20130405192829.GE10155@atomide.com>
 <20130405200201.GA7804@kahuna>
 <20130405211003.GK6182@atomide.com>
 <20130405213250.GA8534@kahuna>
 <20130405214051.GG10155@atomide.com>
 <20130405221041.GA8648@kahuna>
 <20130405221755.GI10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35534 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162867Ab3DEWX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Apr 2013 18:23:27 -0400
Content-Disposition: inline
In-Reply-To: <20130405221755.GI10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

On 15:17-20130405, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [130405 15:15]:
> > Option b) leave a dummy node registered
> > static inline void omap_init_cpufreq(void)
> > {
> > 	struct platform_device_info devinfo = { };
> > 
> > 	if (!of_have_populated_dt())
> > 		devinfo.name = "omap-cpufreq";
> > 	else
> > 		devinfo.name = "cpufreq-cpu0"
> > 	
> > 	platform_device_register_full(&devinfo);
> > }
> > 
> > If there are no objections to (b), I dont mind it either.
> 
> To me option (b) looks better as it's if else :)
Alrity.. Going once...twice...sold! All Nay-sayers will now be branded with
if-else braces ;)

I will now wait for conclusion of  https://lkml.org/lkml/2013/4/2/84
-- 
Regards,
Nishanth Menon
