From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: 3.8 -> 3.9-rc1 upgrade: old configs broken
Date: Fri, 8 Mar 2013 09:42:15 +0530
Message-ID: <5139651F.6010404@ti.com>
References: <51376E2F.9090005@broadcom.com> <20130306203332.GR11806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34879 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760164Ab3CHEMj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 23:12:39 -0500
In-Reply-To: <20130306203332.GR11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Piotr Haber <phaber@broadcom.com>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Thursday 07 March 2013 02:03 AM, Tony Lindgren wrote:
> So basically what's going is that __clk_init() calls kzalloc() before
> kmem_cache_init() is done. This happens the first time for sys_clkin_ck
> where we do have clk->num_parents.
> 
> With CONFIG_DEBUG_SLAB we actually get an error in __find_general_cachep()
> as generic caches are not yet initialized.
> 
> It seems that in the omap case we need to statically allocate clk->parents
> to fix this. I believe we now are overwriting parent clocks..

Actually we are not. It was a known issue that the kzalloc() calls in
__clk_init() for OMAP would fail, since our clock inits happen quite
early. And hence I submitted this patch 'clk: Allow late cache allocation
 for clk->parent, commit 7975059d' to Mike, hoping to work this around in some way.
However I seem to have overlooked the fact that we have BUG() some places
with DEBUG turned on.
The right fix obviously is to move all the static clocks for OMAP over to
use dynamic registrations and do them much after the slab is available.
While we are at this, for now like you rightly said, we would need to have
static clk->parents sent over to __clk_init() to fix these crashes with SLAB_DEBUG
enabled.
I am in the middle of travel with no access to hardware. I will get to this on
monday and send a fix over.

regards,
Rajendra
