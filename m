From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [next-20150119]regression (mm)?
Date: Wed, 21 Jan 2015 11:29:11 +0100
Message-ID: <CAJKOXPdBzSTM0EaFv5C_on8fAPDERkHOtTwVyN04kTRErAE+KA@mail.gmail.com>
References: <54BD33DC.40200@ti.com>
	<20150119174317.GK20386@saruman>
	<20150120001643.7D15AA8@black.fi.intel.com>
	<20150120114555.GA11502@n2100.arm.linux.org.uk>
	<20150120140546.DDCB8D4@black.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150120140546.DDCB8D4@black.fi.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, linux-mm@kvack.org, linux-next <linux-next@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2015-01-20 15:05 GMT+01:00 Kirill A. Shutemov <kirill.shutemov@linux.intel.com>:
> Russell King - ARM Linux wrote:
>> On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
>> > Better option would be converting 2-lvl ARM configuration to
>> > <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.
>>
>> Well, IMHO the folded approach in asm-generic was done the wrong way
>> which barred ARM from ever using it.
>
> Okay, I see.
>
> Regarding the topic bug. Completely untested patch is below. Could anybody
> check if it helps?
>
> From 34b9182d08ef2b541829e305fcc91ef1d26b27ea Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Tue, 20 Jan 2015 15:47:22 +0200
> Subject: [PATCH] arm: define __PAGETABLE_PMD_FOLDED for !LPAE
>
> ARM uses custom implementation of PMD folding in 2-level page table case.
> Generic code expects to see __PAGETABLE_PMD_FOLDED to be defined if PMD is
> folded, but ARM doesn't do this. Let's fix it.
>
> Defining __PAGETABLE_PMD_FOLDED will drop out unused __pmd_alloc().
> It also fixes problems with recently-introduced pmd accounting on ARM
> without LPAE.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 2 ++
>  1 file changed, 2 insertions(+)

Helps for this issue on Exynos 4412 (Trats2) and Exynos 5420 (Arndale Octa):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Off-topic: "Using smp_processor_id() in preemptible" still screams [1]

[1] https://lkml.org/lkml/2015/1/20/162

Best regards,
Krzysztof

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
