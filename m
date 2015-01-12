From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: ARM64: hibernation: How to use hibernation/suspend-to-disk on ARMv8?
Date: Mon, 12 Jan 2015 11:45:39 +0530
Message-ID: <CAP245DUypHRtjdF4+nRc0UX-VWqyne6NMsgoWaBxKTXFP4QAOw@mail.gmail.com>
References: <CADcZZT+nQ_0LfurU+z5wLC_OxNhEs6n0kCoLSkfoFCDqyOu04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CADcZZT+nQ_0LfurU+z5wLC_OxNhEs6n0kCoLSkfoFCDqyOu04g@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: George Bush <georgebush815@gmail.com>
Cc: Russ Dill <Russ.Dill@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Brown, Len" <len.brown@intel.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, jonathan.austin@arm.com, Catalin Marinas <catalin.marinas@arm.com>, u.kleine-koenig@pengutronix.de, Stephen Boyd <sboyd@codeaurora.org>, victor.kamensky@linaro.org, r.sricharan@ti.com, liuj97@gmail.com, lauraa@codeaurora.org, zhou0283@gmail.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Sebastian Capella <capellas@broadcom.com>
List-Id: linux-omap@vger.kernel.org

(Fixing Sebastian's email address)

On Sat, Jan 10, 2015 at 8:44 PM, George Bush <georgebush815@gmail.com> wrote:
> Hi all
>
> I notice we have hibernation.c in arm/kernel, however, I don't find it in arm64.
> Does it mean arm64 do not support hibernation/suspend-to-disk function?

Correct. arm64 is a separate architecture and will need to implement
something similar to SHA 603fb42a66499ab353466c7afa3d38beea20a8a9.

> I tried some path to search the reason, but found nothing, they all say arm64
> has the backward compatibility. So I send this email to the community and
> hope to get the reason.
> Thanks!
>
> I ported the arm hibernation.c to arm64/kernel(with LP64), but failed in a
> strange way. When I do resume, the arch_restore_image() get a page_fault
> when it calls the copy_page(), like:

I'm afraid I can't help with the memory management aspects of arm64
but you've cc'ed the right people who'd know.

> "Unable to handle kernel paging request at virtual address 0xffffffbc055c3fa8"
> I'm sure the copy_page()'s parameters is in the memory area, why and how
> I get the strange address 0xffffffbc055c3fa8?
>
> vmalloc:         0xffffff8000000000 - 0xffffffbb00000000
> vmemmap:     0xffffffbc01400000 - 0xffffffbc04f88000
> modules:       0xffffffbffc000000   -  0xffffffc000000000
> memory:        0xffffffc000000000 - 0xffffffc0be800000
>
