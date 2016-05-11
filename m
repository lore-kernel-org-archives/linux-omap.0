From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Wed, 11 May 2016 20:49:31 +0100
Message-ID: <57338CCB.2080805@nvidia.com>
References: <20160427173810.GC7359@leverpostej> <5721C597.1010105@nvidia.com>
 <20160428095525.GB21145@leverpostej> <572C56A6.7020408@nvidia.com>
 <CAMuHMdX+egbNPP4QQ2R28GbyVkg9qBrwYfUy8EE0PdB6od+LBg@mail.gmail.com>
 <CAL_Jsq+HSH7e1T9y47nHV_x5NvZ-52cfDEKKFkr16ax671FxSw@mail.gmail.com>
 <573358F9.6000108@nvidia.com> <57335AD3.7070109@nvidia.com>
 <CAL_Jsq+ZhwUOSfQG-8V9xgxiXBj2j3Q6k48d=BWtWK9pEHH_MQ@mail.gmail.com>
 <57336397.4000401@nvidia.com> <20160511172823.GC18829@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511172823.GC18829@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 11/05/16 18:28, Mark Rutland wrote:
> On Wed, May 11, 2016 at 05:53:43PM +0100, Jon Hunter wrote:
>> Hi Rob, Mark,
>>
>> On 11/05/16 17:30, Rob Herring wrote:
>>> A platform driver for just gic-400 is wrong IMO until we have platform
>>> drivers for all interrupt controllers.
>>
>> Yes, that is fine with me, but can we decide on whether the platform
>> driver should match "tegra210-agic" or the early driver should bail-out
>> if clocks/power-domains are present?
>>
>> I am fine with either, but I think that Rob prefers the tegra210-agic
>> compat string and Mark prefers to bail-out of the early driver if
>> clocks/power-domains are present.
> 
> If anything, I wasn't too keen on bailing out becuase of those
> properties, as I mentioned for the case of a root interrupt controller.
> 
> I am happy to match the "tegra210-agic" string specifically.

Thanks guys. I will stick with tegra210-agic for now.

Cheers
Jon
