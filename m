From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 0/2] ARM: OMAP3+: support cpufreq-cpu0 for device tree
 boot
Date: Wed, 3 Apr 2013 13:22:24 -0500
Message-ID: <20130403182224.GA3410@kahuna>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
 <87y5czzetg.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y5czzetg.fsf@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 10:47-20130403, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
[...]
> > Test coverage:
> > 	test script: http://pastebin.com/zrr8ptge
> > Platforms verified:
> > 	beaglebone(rev A6a) - AM33xx compatible - http://pastebin.com/GVP2wDVr
> > 	beagleboard (rev C1D) - OMAP3430 compatible
> > 		- DT enabled boot: http://pastebin.com/2AY1F5Qa
> > 		- No DT enabled boot: http://pastebin.com/hDk0gbpU
> > 	omap3-beagle-xm -OMAP3630 compatible - http://pastebin.com/5tHAQcLZ
> > 	Pandaboard -(OMAP4430 ES2.2) - http://pastebin.com/6D9aDPXT
> > 	Pandaboard-ES -(OMAP4460 ES1.1) - http://pastebin.com/ExrBEczr
> 
> And thanks also for the broad testing.
> 
> One nit about the test report/coverage is I don't see any
> test/verification that the voltage is still being scaled based on the DT
> based OPPs.  It's easy to verify at least from the regulator PoV that
> the voltage is scaled also.
I had probed and verified voltage on beagle and beagle XM. OMAP4
obviously wont scale (as mentioned) due to the fact that vc-vp regulator
is needed.

> 
> My dumb DVFS test script (below) should work on any busybox rootfs 
thanks for the script. yep - I can use this as well, but given that probe
did verify voltage scale on TWL5030 inductors, it might be redundant.

Ref:
https://plus.google.com/photos/112464029509057661457/albums/5715034179943520193/5854221132322035042
I can take it again and show the same snap along with the log with the
mentioned script later today.

-- 
Regards,
Nishanth Menon
