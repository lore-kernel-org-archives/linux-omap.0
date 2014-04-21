From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Mon, 21 Apr 2014 08:35:40 -0700
Message-ID: <20140421153539.GB23945@atomide.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
 <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64148 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751649AbaDUPfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 11:35:44 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140419 09:25]:
> On 19 April 2014 18:14, Joachim Eastwood <manabian@gmail.com> wrote:
> > This was introduced in 43a348ea53eb5fd79 but hasn't caused
> > any harm since it don't have any users yet.
> 
> Or maybe I am confused about this macro.
> 
> Tony which offset from the OMAP4 TRM should be used?
> 
> Under section 18.6.8 there are is a column with address offset. Is
> this the number you want in the macro?

Oh I see, the offsets in the TRM in this case are from the base
of the wkup module padconf base instead of listing the physical
address for the register. Ideally the value would be what the
documentation lists in the "Table 18-9. Device Wake-Up Control
Module Pad Configuration Register Fields" with 2 added to it for
the upper registers as we're using 16-bit register address.
In any case something that's relatively easy to verify against
the documentation. But that seems to vary between the physical
address and the offset, so we need to specify some mask there.

Something like below (untested) should do the trick as long as
we never have padconf reg areas larger than 0xfff. We may want to
allow defining a custom mask for the macro if needed depending
how the documentation is defining the mux tables for.

--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -51,9 +51,9 @@
 
 /*
  * Macros to allow using the absolute physical address instead of the
- * padconf registers instead of the offset from padconf base.
+ * padconf register offset from padconf register base.
  */
-#define OMAP_IOPAD_OFFSET(pa, offset)	(((pa) & 0xffff) - (offset))
+#define OMAP_IOPAD_OFFSET(pa, offset)   (((pa) & 0xfff) - ((offset) & 0xfff))
 
 #define OMAP2420_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0030) (val)
 #define OMAP2430_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
