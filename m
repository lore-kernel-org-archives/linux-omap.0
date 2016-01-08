From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Fri, 8 Jan 2016 20:31:40 +0100
Message-ID: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
References: <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com> <568C5451.8070709@ti.com> <20160106010011.GG12777@atomide.com> <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com> <20160106164136.GI12777@atomide.com> <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com> <20160106170925.GK12777@atomide.com> <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com> <20160108181551.GX12777@atomide.com> <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com> <20160108190457.GY12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160108190457.GY12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org


Am 08.01.2016 um 20:04 schrieb Tony Lindgren <tony@atomide.com>:

> * H. Nikolaus Schaller <hns@goldelico.com> [160108 10:33]:
>> Am 08.01.2016 um 19:15 schrieb Tony Lindgren <tony@atomide.com>:
>>> * H. Nikolaus Schaller <hns@goldelico.com> [160108 09:50]:
>>> 
>>>> So I think it is something which is unstable in 4.4-rc8 that is (probably) fixed in
>>>> linux-next and unrelated to this DT patch.
>>>> 
>>>> But I have no hint or idea what it is.
>>> 
>>> Or something hangs the RTC? And the back-up battery has to drain to
>>> reset the RTC somehow?
>> 
>> Indeed it could be something like this. I already suspected that it depends
>> on boot order of some components.
>> 
>> But you get the /dev/rtc and /sys/class/rtc nodes? This is what this patch
>> should enable (and not fix potential driver issues).
> 
> Yes no problems with $subject patch. It's just the we also need
> to figure out why RTC does not work :)

Yes indeed. I can not focus on that at the moment but as soon as we have
the new Pyra handheld devices (with OMAP5+Palmas) running, there will
be more developers to look at it.

BR,
Nikolaus
