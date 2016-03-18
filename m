From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Fri, 18 Mar 2016 08:37:12 +0000
Message-ID: <56EBBE38.6070303@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
 <CAL_JsqLwvhbCnQzkRd1cyz+O6HU8a3X3MYoX=ChhuDyvdTWQYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLwvhbCnQzkRd1cyz+O6HU8a3X3MYoX=ChhuDyvdTWQYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 17/03/16 20:14, Rob Herring wrote:
> On Thu, Mar 17, 2016 at 9:19 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
>> Domain properties") documented optional clock and power-dmoain properties
>> for the ARM GIC. Currently, there are no users of these and for the
>> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
>> functional clock and interface clock, that need to be enabled.
>>
>> To allow flexibility, drop the 'clock-names' from the GIC binding and
>> just provide a list of clocks which the driver can parse. It is assumed
>> that any clocks that are listed, need to be enabled in order to access
>> the GIC.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> ---
>>
>> Please note that I am not sure if this will be popular, but I am trying
>> to come up with a generic way to handle multiple clocks that may be
>> required for accessing a GIC.
> 
> It's not. :)
> 
> We need to specify the number and order of clocks by compatible string
> at a minimum. Sadly, ARM's GICs are well documented and include clock
> names, so you can't just make up genericish names either which is
> probably often the case.

Do you have any suggestions then?

I have had a look at the ARM TRMs and although I see that they do show
the functional clock, there is no mention of whether there are any other
clocks need in order to interface to the GIC (ie. bus clock). I know
that for other SoCs such as OMAP it is common to have both a functional
clock and interface clock. So I believe this is fairly common.

Cheers
Jon
