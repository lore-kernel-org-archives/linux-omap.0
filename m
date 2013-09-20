From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: rename functions to dev_pm_opp*
Date: Fri, 20 Sep 2013 22:21:05 +0530
Message-ID: <CAKohpoktS4ZSQAeKvu3hdVsKkzcbKFvHvR2=wCA3qeB6moPphA@mail.gmail.com>
References: <1379624632-17356-1-git-send-email-nm@ti.com>
	<1379624632-17356-2-git-send-email-nm@ti.com>
	<CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>
	<20130920123808.GA22176@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20130920123808.GA22176@kahuna>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Rob Landley <rob@landley.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 20 September 2013 18:08, Nishanth Menon <nm@ti.com> wrote:

> I am open to suggestions if any one feels we can improve this better.

I didn't really had one.. I thought of pm_opp** instead of dev_pm_opp**
though..

> I believe that change was from Patch #2[1]

Yeah.. I just replied on a single patch :)

> yes, you are right, I had squashed this patch in to squelch checkpatch
> warnings:

I see..

> I had added a comment:
> " Minor checkpatch warning fixes as a result of this change was fixed as
> well."

I really missed that..

> Would you suggest I split the change off to a separate patch or improve
>  the comment a little more?

don't really know, maybe leave those as is and let checkpatch warn you..
