From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 8/9] dspbridge: add map support for big buffers
Date: Thu, 26 Aug 2010 09:13:16 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F10ED4B4@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602F10ED4B1@dlee06.ent.ti.com>
	<20100826215554N.fujita.tomonori@lab.ntt.co.jp>
	<496565EC904933469F292DDA3F1663E602F10ED4B3@dlee06.ent.ti.com>,<20100826230139Y.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100826230139Y.fujita.tomonori@lab.ntt.co.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ohad@wizery.com" <ohad@wizery.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

________________________________________
>From: FUJITA Tomonori [fujita.tomonori@lab.ntt.co.jp]
>Sent: Thursday, August 26, 2010 9:03 AM
>To: Guzman Lugo, Fernando
>Cc: fujita.tomonori@lab.ntt.co.jp; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; ohad@wizery.com; hiroshi.doyu@nokia.com; ameya.palande@nokia.com; >felipe.contreras@nokia.com
>Subject: RE: [PATCH 8/9] dspbridge: add map support for big buffers
>
>On Thu, 26 Aug 2010 08:16:24 -0500
>"Guzman Lugo, Fernando" <fernando.lugo@ti.com> wrote:
>
>> >From a quick look, arch/arm/plat-omap/iovmm.c does nothing wrong about
>> >scatter gather chaining. arm/arm/mm/dma-mapping.c looks fine too about
>> >it. Maybe just defining ARCH_HAS_SG_CHAIN works?
>>
>> I can try, but it looks tricky for me. Maybe someone else can tell us why
>> SG chain is not supported for ARM or if there is a problem just defining
>> ARCH_HAS_SG_CHAIN.
>
>I suppose that nobody in ARM has been interested in the feature. It
>was invented to improve I/O performance with large I/O requests. No
>wonder embeded people aren't interested in it.
>
>fujita@rose:~/git/linux-2.6$ find arch -name 'scatterlist.h'|xargs grep HAS_SG
>arch/x86/include/asm/scatterlist.h:#define ARCH_HAS_SG_CHAIN
>arch/ia64/include/asm/scatterlist.h:#define ARCH_HAS_SG_CHAIN
>arch/sparc/include/asm/scatterlist.h:#define ARCH_HAS_SG_CHAIN
>arch/powerpc/include/asm/scatterlist.h:#define ARCH_HAS_SG_CHAIN

Ok, so let me try SG chain, that should be the correct fix.

Thanks a lot,
Fernando.
