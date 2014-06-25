From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with
 module_init
Date: Wed, 25 Jun 2014 12:48:58 -0300
Message-ID: <20140625154858.GD743@arch.cereza>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F5F4.3030806@ti.com>
 <20140625130042.GK3705@n2100.arm.linux.org.uk>
 <20140625143246.GA743@arch.cereza>
 <20140625144636.GO3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:41283 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071AbaFYPtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 11:49:45 -0400
Received: by mail-yk0-f180.google.com with SMTP id 131so1202309ykp.11
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 08:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140625144636.GO3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Mack <zonque@gmail.com>, Guido Martinez <guido@vanguardiasur.com.ar>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Russell,

On 25 Jun 03:46 PM, Russell King - ARM Linux wrote:
> > 
> > That doesn't make any sense. Using late_initcall for the tilcdc DRM
> > driver would make the tilcdc DRM get probed before any other regular
> > module_init driver, including the tda998x encoder.
> 
> A module_init() is a device_initcall(), which is at level 6.  A
> late_initcall() is at level 7.  Level 6 initcalls are run before level
> 7 initcalls.  The tda998x is a module_init(), so the tda998x gets
> initialised *before* tilcdc's late_initcall().
> 

Oh, thanks a lot for correcting me.

> Now, if you build everything as a module, then you have no initialisation
> ordering, and you can't rely on any kind of order.  Initialisation
> functions can even run in parallel on different CPUs due to modules being
> loaded from userspace in a multi-threaded way.  So anything which relies
> on a certain initcall ordering is fundamentally broken if it can be
> modular.
> 

OK, but is there any outstanding issue with the tilcdc initialization, either
when compiled as built-in or as modules, *after* this patchset?

Of course, this driver only worked as built-in (see the horrible bugs we are
fixing here, that prevented unloading and re-loading it). This series fixes
all such bugs, and also adds the required changes to allow to build everything
as a module.

Again, I can't see any issues that remain to be fixed after this patchset.
When compiled as built-in, the tilcdc DRM will be defered and once the tda998x
is ready, the tilcdc DRM will load properly.

When compiled as module you can load any of them in any order. If the tda998x
module is not loaded by the time you load the tilcdc module, the former will
get loaded.

Hm... now that I think about this. We still get into trouble if the tda998x
is built as module, but the tilcdc is built-in. Shouldn't we just forbid that?
Either both built-ins or both as modules?

> > > There's a solution to that...
> > 
> > A solution to *what* ?
> 
> Maybe if you left the context above that line in place, you might
> understand that my "that" refers to what was discussed in that
> context.  That being the initialisation ordering.
> 
> Convention and proper Internet etiquette is to trim the quoted text
> and place relies below the paragraph to which they refer, the quoted
> paragraph giving the context to the reply.
> 

Yeah, sorry about that.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
