From: Phil Carmody <pc+lkml@asdf.org>
Subject: Re: IS_ERR_OR_NULL - please STOP telling people to use this on a
	whim
Date: Wed, 17 Oct 2012 23:28:48 +0300
Message-ID: <20121017202848.GF22812@fatphil.org>
References: <20121017194157.GM21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 87-119-183-129.tll.elisa.ee ([87.119.183.129]:39793 "EHLO
	fatphil.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757825Ab2JQUrU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 16:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20121017194157.GM21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 17/10/12 20:41 +0100, Russell King - ARM Linux wrote:
> People,
> 
> This is not aimed at anyone specifically - but it is aimed at everyone
> who reviews patches to make them aware of this issue, and to modify their
> behaviour.
> 
> I'm geting sick and tired of telling people about this.  I've just
> floated the idea of removing IS_ERR_OR_NULL from the kernel tree because
> it's one of the most incorrectly used and abused macros we have in the
> source tree.

This makes me sad. I was responsible for its introduction, and my motive
was exactly yours in sending the above. 

> It would be one thing if this was only being done by people who are
> submitting new code, but it's far worse than that.  Reviewers who should
> know better are telling people to use it _incorrectly_.
> 
> Reviewers really need to think about your review comments.  Looking
> through the kernel tree today, I see lots of uses of IS_ERR_OR_NULL(),
> many of them are *buggy*.
> 
> Take a moment to think about this:
> 
> int error_value(struct device *dev, void *foo)
> {
> 	if (IS_ERR_OR_NULL(foo))
> 		return PTR_ERR(foo);
> 	return 0;
> }
> 
> Consider the value this function returns for three arguments:
> 
> 1. an errno encoded pointer
> 2. a NULL pointer.
> 3. a valid pointer.
> 
> If you can't see the problem, then *do* *not* tell anyone to use
> IS_ERR_OR_NULL(), because you do *not* have the understanding necessary
> to make that judgement yourself - you're probably telling people to
> create buggy code.

The problem I saw was functions returning -ERRORs or NULL. There were
too many, and there was too much sloppy code inconsistently handling one
or either of the two, and not always both. I did consider trying to fix
some of the core functions that were returning -ERRORs or NULL to the
drivers I was involved in, but it seemed like there were too many, and
that would be too "brave". I imagined that my macro would help catch
that undesirable situation, and permit people to map the error onto
whatever was most appropriate to propagate on.

The idea of them propagating the undesirable problem up further in the call
chain is the exact antithesis of what I intended.

Thank you for highlighting the issue I didn't foresee (neither did my 
colleagues at Nokia, they made good use of it fairly quickly) and in 
such unambiguous terms. Better to nip it in the bud, certainly.

> Here's the list so far of what looks like buggy uses specific to ARM.
> There _are_ others elsewhere in the kernel.
> 
> drivers/media/video/s5p-mfc/s5p_mfc.c:  if (IS_ERR_OR_NULL(dev->alloc_ctx[0])) {
> drivers/media/video/s5p-mfc/s5p_mfc.c-          ret = PTR_ERR(dev->alloc_ctx[0]);
> drivers/media/video/s5p-mfc/s5p_mfc.c-          goto err_res;
> drivers/media/video/s5p-mfc/s5p_mfc.c-  }
...

:-(

So, what to do? It can and has been used sensibly, so I don't think removing
it is the best option.

Phil

"pcarmody@nokia.com" is no more, I'm now "pc+lkml@asdf.org"
