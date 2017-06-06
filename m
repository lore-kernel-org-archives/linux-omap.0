From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] mfd: Remove redundant i2c_device_id
Date: Tue, 6 Jun 2017 03:44:38 -0700
Message-ID: <20170606104437.GY3730@atomide.com>
References: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
 <20170605103740.g4t3veigzpdzfkxi@dell>
 <e8cbe8fb-50fd-76ef-a5e3-59a7913622c5@ti.com>
 <20170606071703.o6dnzu4vjeywpoxn@dell>
 <9017b16c-e9f3-ea05-4e71-d7920841ce57@ti.com>
 <918f5112-b200-b5ae-c4d2-c75e5e227e9a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <918f5112-b200-b5ae-c4d2-c75e5e227e9a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, milo.kim@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170606 00:52]:
> On Tuesday 06 June 2017 01:00 PM, Keerthy wrote:
> > On Tuesday 06 June 2017 12:47 PM, Lee Jones wrote:
> >>>> Are all of these drivers DT only?
> >>>
> >>> At least i did not find any platform code calling on to these drivers.
> >>> No dependency on OF as such. Hence sent these 9.
> >>
> >> I can't accept these changes on any drivers which does not depend on
> >> OF as a hard requirement.
> > 
> > Okay. So that is a per-requisite. At least palmas, tps65218, lp873x,
> > tps65217 imho can have the OF dependency. I will post patches for that
> > and then will resurrect this series.
> > 
> > Thanks for your feedback.
> 
> Tony,
> 
> I do not see any platform specific code for tps65218, tps65217 and
> palmas. I believe they are all completely Device Tree based. Can i make
> them depend on OF? It helps me clear up some unused data from their mfd
> drivers.

Yes all of arch/arm/mach-omap2 is device tree only nowadays.
There may be other SoCs or architectures using these too,
but grepping for platform_data should reveal that.

Regards,

Tony
