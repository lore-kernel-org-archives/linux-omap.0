From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type fails
Date: Fri, 18 Mar 2016 10:20:34 +0100
Message-ID: <CAMuHMdU8PDUVZ8=S04fkahez1dh7JHjpj2-3w+Vfz05X=ZFMUQ@mail.gmail.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
	<alpine.DEB.2.11.1603171550200.3978@nanos>
	<56EAC761.1040801@nvidia.com>
	<20160317151800.GH1184@io.lakedaemon.net>
	<56EAD93B.7040105@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <56EAD93B.7040105@nvidia.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2016 at 5:20 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> On 17/03/16 15:18, Jason Cooper wrote:
>> On Thu, Mar 17, 2016 at 03:04:01PM +0000, Jon Hunter wrote:
>>> On 17/03/16 14:51, Thomas Gleixner wrote:
>>>> On Thu, 17 Mar 2016, Jon Hunter wrote:
>>>>> Setting the interrupt type for private peripheral interrupts (PPIs) may
>>>>> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
>>>>> whether this is allowed. There is no way to know if setting the type is
>>>>> supported for a given GIC and so the value written is read back to
>>>>> verify it matches the desired configuration. If it does not match then
>>>>> an error is return.
>>>>>
>>>>> There are cases where the interrupt configuration read from firmware
>>>>> (such as a device-tree blob), has been incorrect and hence
>>>>> gic_configure_irq() has returned an error. This error has gone
>>>>> undetected because the error code returned was ignored but the interrupt
>>>>> still worked fine because the configuration for the interrupt could not
>>>>> be overwritten.
>>>>>
>>>>> Given that this has done undetected and we should only fail to set the
>>>>> type for PPIs whose configuration cannot be changed anyway, don't return
>>>>> an error and simply WARN if this fails. This will allows us to fix up any
>>>>> places in the kernel where we should be checking the return status and
>>>>> maintain back compatibility with firmware images that may have incorrect
>>>>> interrupt configurations.
>>>>
>>>> Though silently returning 0 is really the wrong thing to do. You can add the
>>>> warn, but why do you want to return success?
>>>
>>> Yes that would be the correct thing to do I agree. However, the problem
>>> is that if we do this, then after the patch "irqdomain: Don't set type
>>> when mapping an IRQ" is applied, we may break interrupts for some
>>> existing device-tree binaries that have bad configuration (such as omap4
>>> and tegra20/30 ... see patches 1 and 2) that have gone unnoticed. So it
>>> is a back compatibility issue.

Indeed (also for sh73a0 and r8a7779).

>> This sounds like a textbook case for adding a boolean dt property.  If
>> "can-set-ppi-type" is absent (old DT blobs and new blobs without the
>> ability), warn and return zero.  If it's present, the driver can set the
>> type, returning errors as encountered.
>
> True. However, if we did have this "can-set-ppi-type" property set for a
> device, it really should never fail (unless someone specified it
> incorrectly). So I am trying to understand the value in adding a new DT
> property.

Do we really want to add properties that basically indicate that a description
in DT is correct?

Alternatively, it can be fixed in the kernel in a DT quirk (if SoC == xxx then
fix TWD).

> Please note that gic_configure_irq() never used to return an error and
> only when adding support for setting the type of PPIs was this added.
> However, given that this has gone unnoticed and does not have a real
> functional impact on the device behaviour, I wonder now if this function
> should return an error? Yes, ideally, it should, but does it still make
> sense?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
