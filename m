From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 0/8] ARM: AM43 (OMAP2+) boot support
Date: Tue, 19 Feb 2013 15:39:32 +0530
Message-ID: <51234F5C.6050500@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 18 February 2013 05:05 PM, Afzal Mohammed wrote:
> (Resending, since it seems, LAKML doesn't accept patches with subject
> prefix only as "RFC", but requires "PATCH" prefix also)
>
> Hi,
>
> This series adds minimal support to boot Linux on platforms having
> AM43 based SoC's.
>
> This is being sent as an RFC to seek opinion about modification in
> twd to register percpu local timer clock event for scheduler tick in
> the case of one core SMP.
>
> AM43 SoC's are based on ARM Cortex-A9. It is an ARM Cortex-A9 SMP
> configuration with one core (not uniprocessor configuration). AM43 is
> similar to AM335x in it's peripheral capabilities, with many of the
> peripheral register mapping's similar like that of uart.
>
After looking at the specs, you don't need the SMP mode since ACP
isn't being used.


> AM43 is in pre-silicon stage and currently there are no public
> documents.
>
> This series has been tested on a pre-silicon platform that emulates
> AM43 SoC, changes proposed here are minimal - to get it booting.
> Kernel was directly run without the help of bootloader - Images were
> directly loaded onto a pre-initialized RAM and ARM registers updated
> as required for booting.
>
> Changes have been made over linux-next (next-20130213) with three "OF"
> related reverts (which otherwise causes problem in other platforms
> also) and compiled with omap2plus_defconfig. Multiplatform option was
> enabled, while most of CONFIG options were deselected for a faster
> boot. Beagle bone boots as earlier with these changes.
>
> An interesting observation is that it may be possible to boot this
> platform to console without any platform specific modification to
> proper Kernel (by that I mean excluding DT sources) using Arnd's,
>
> "[PATCH,RFC] default machine descriptor for multiplatform",
>
> along with a "CLOCKSOURCE_OF_DECLARE" for smp twd.
>
TWD use for AM437x is also limited because these times stops in
low power sates and there you will need broad-cast mechanism which
again more of SMP machine feature.

So I suggest to use the wakeup timer(GPT1) clock-event instead
of local timer for the mentioned reason.

Regards,
Santosh

