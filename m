From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH v8 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Sun, 16 Nov 2014 10:20:01 +0900
Message-ID: <00ef01d0013b$716f1d30$544d5790$@kernel.org>
References: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
 <54660DAE.9090601@samsung.com> <2593372.vOeyyAKq5M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62421 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbaKPBUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2014 20:20:03 -0500
In-reply-to: <2593372.vOeyyAKq5M@wuerfel>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>, 'Marek Szyprowski' <m.szyprowski@samsung.com>
Cc: 'Olof Johansson' <olof@lixom.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, 'Mark Rutland' <mark.rutland@arm.com>

Arnd Bergmann wrote:
> 
> On Friday 14 November 2014 15:11:58 Marek Szyprowski wrote:
> >
> > I assume that after all comments from previous versions, no more changes
> > are needed
> > to this patchset and I would really like to have it queued to v3.19.
> >
> > Arnd, Olof: could you take this patchset thought arm-soc tree? It already
> > contains all dependencies.
> >
> > Kukjin: could you ack this patchset?
> 
> I'd rather see this merged through Russell's tree, as most of the patches
> are for core code, and only three are for the platform.
> 
> For the exynos patches:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
I'm also fine on this series for the exynos stuff:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

And agree with Arnd's suggestion to handle in rmk tree.
(I think seems this has no dependency with samsung tree)

Thanks,
Kukjin

