From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
Date: Fri, 6 Sep 2019 19:55:40 +0200
Message-ID: <17A56ADB-2217-41CC-BE0B-C3899815F10F@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com> <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com> <20190906154732.GC52127@atomide.com> <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com> <20190906172403.GG52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906172403.GG52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-OMAP <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 06.09.2019 um 19:24 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [190906 17:09]:
> 
>> BTW there is also some code that does special SoC detection based on
>> soc_device_match(), mainly in omapdrm/dss.
>> 
>> If we were to use this mechanism in the ti-cpufreq driver we could
>> match it to ti,omap3 and could avoid all these changes.
>> 
>> But make it less maintainable and code more complex.
> 
> Hmm right, yeah using soc_device_match() would remove this issue.
> It might be worth doing as these SoC variants do not change
> much and the code should not need updating. Up to you to
> decide.

I have looked through the structure of the ti-cpufreq driver but
it assumes that each set of register offsets and bit masks
has its own compatible so that it can just switch descriptor
tables.

There is no provision to run soc_device_match() instead.

So let's forget this idea...

BR,
Nikolaus
