From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Fri, 28 Jun 2013 18:45:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com> <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com> <51CBBCD8.5030600@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53379 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3F1Spj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jun 2013 14:45:39 -0400
In-Reply-To: <51CBBCD8.5030600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Lokesh

On Thu, 27 Jun 2013, Lokesh Vutla wrote:

> On Wednesday 26 June 2013 10:56 PM, Paul Walmsley wrote:
> > 
> > Here's how I do it:
> > 
> > ARCH=arm CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX} nice make
> > -j$CORES zImage am335x-bone.dtb
> > 
> > cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb >
> > arch/arm/boot/zImage-dtb.am335x-bone
> Here is the catch..
> Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb was
> generated in arch/arm/boot).

Ugh... that's probably it :-(

> You are using very old dtb file. Please delete all your dtb files in
> arch/arm/boot/ folder and check once.

The tree is freshly recreated for each build, so the most likely scenario 
is that there's no DTB file at all appended to the image.

> Here is the patch from Grant Likely which does that.
> https://patchwork.kernel.org/patch/1813321/
> Can you please give a try updating this ..:)

Yeah will try that, probably either today or tomorrow.


- Paul
