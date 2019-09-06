From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap36xx
Date: Fri, 6 Sep 2019 10:24:03 -0700
Message-ID: <20190906172403.GG52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
 <20190905142734.GV52127@atomide.com>
 <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com>
 <20190906154732.GC52127@atomide.com>
 <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-OMAP <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190906 17:09]:
> for i in 3430 34xx 3630 36xx; do echo $i $(fgrep '"'ti,omap$i'"' arch/arm/boot/dts/*.dts* | wc -l); done
> 
> 3430 12
> 34xx 28
> 3630 3
> 36xx 23
> 
> which would indicate that 34xx and 36xx are more common.

Right, but the xx variants are against the device tree naming and
that's why we should get rid of them in the dts. The compatible
should be named after the first instance like "ti,omap3430" and
similar devices can just use that.

> BTW there is also some code that does special SoC detection based on
> soc_device_match(), mainly in omapdrm/dss.
> 
> If we were to use this mechanism in the ti-cpufreq driver we could
> match it to ti,omap3 and could avoid all these changes.
> 
> But make it less maintainable and code more complex.

Hmm right, yeah using soc_device_match() would remove this issue.
It might be worth doing as these SoC variants do not change
much and the code should not need updating. Up to you to
decide.

> I'll also take a look at omap.txt bindings since that likely needs
> an update as well to better describe what the official ones are
> and which are legacy.

OK. Just limit the compatible changes to the ones that
need to be modified for this series, the rest can be
done with a separate patches.

Regards,

Tony
