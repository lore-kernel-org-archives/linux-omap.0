From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Tue, 12 Apr 2016 11:14:52 +0100
Message-ID: <570CCA9C.1030907@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171550200.3978@nanos> <56EAC761.1040801@nvidia.com>
 <20160409115854.492090a5@arm.com> <570BC34A.5030806@nvidia.com>
 <570BC528.9050601@arm.com> <570CB6DA.2050909@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570CB6DA.2050909@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/04/16 09:50, Jon Hunter wrote:
> 
> On 11/04/16 16:39, Marc Zyngier wrote:
>> On 11/04/16 16:31, Jon Hunter wrote:
>>> On 09/04/16 11:58, Marc Zyngier wrote:
> 
> [snip]
> 
>>>> I think we need to phase things. Let's start with warning people for a
>>>> few kernel releases. Actively maintained platforms will quickly address
>>>> the issue (fixing their DT). As I see it, this issue seems rather
>>>> widespread (even kvmtool outputs a DT with the wrong triggering
>>>> information).
>>>>
>>>> Once we've fixed the bulk of the platforms and virtual environments, we
>>>> can start thinking about making it fail harder.
>>>
>>> Ok, so are you OK with this patch as-is? If so, can I add your ACK?
>>
>> It depends where you plan to handle the error. Ideally, I'd keep on
>> returning the error (because that's the right thing to do), and move the
>> WARN_ON() into the core code. We'd keep on ignoring the error as we're
>> doing today, but we'd scream about it.
>>
>> After a couple of releases, we'd turn the WARN_ON into a hard fail.
>>
>> Thoughts?
> 
> I agree that would be best/ideal, but looking at it, I don't believe it
> is possible and this is why I have not done that so far.
> 
> If we were to add the WARN to the core code, then we would need to add a
> warning everywhere __irq_set_trigger() is called. One of the places it
> is called today is from __setup_irq() and today this does the right
> thing and handle any error returned. The problem is that in
> irq_create_fwspec_mapping() we have never checked the return code from
> irq_set_irq_type() (which calls __irq_set_trigger()) or attempted to
> handle any errors. So the problem is that depending on the path through
> which the type is programmed, errors may or may not be detected. This is
> the actual headache :-(
> 
> Given that this problem so far only pertains to GIC PPI interrupts and
> that it is a not a catastrophic error (interrupts still work fine), I
> was thinking we add the warning to the GIC driver.
> 
> May be a less severe change would be to only return an error if
> configuring an SPI fails and if it is a PPI then simply WARN and
> carry-on as we assume we cannot change it.

I'd take that. Limiting it to PPIs would be a minimal change, and the
warning would hopefully make people realize their DT is wrong. Failing
to program an SPI is really not expected, and should definitely explode.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
