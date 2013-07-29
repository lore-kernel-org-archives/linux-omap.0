From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
Date: Mon, 29 Jul 2013 14:40:33 +0200
Message-ID: <798C2D39-EE8E-4C73-A98D-63231375599C@collabora.co.uk>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com> <51F633AE.8090308@collabora.co.uk> <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com> <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk> <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43424 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab3G2Mki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 08:40:38 -0400
In-Reply-To: <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

On 29/07/2013, at 13:43, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Jul 29, 2013 at 12:19 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> 
>> I guess the safer approach is to just revert these since they are causing
>> a regression and what the patches aims to fix as been broken since the
>> initial OMAP migration to DT anyways.
> 
> I have already reverted these and pushed to linux-next.
> 

Thanks for doing that and sorry for all the inconvenience.

Too bad this regression was not found before the patches hit mainline and they even were on linux-next for some time but shit happens :-(

> Actually input-hogs was not such a good idea either, after
> meditating on this I realized that the information about what
> GPIOs are used as interrupts is a piece of information that
> already exist in the device tree, albeit a bit distributed.
> 
> So I'm drafting an RFC to indicate how I think this should
> be solved.
> 

Great, I hope we can finally have a good solution for this long standing issue.

> Yours,
> Linus Walleij

Best regards,
Javier