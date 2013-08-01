From: Olof Johansson <olof@lixom.net>
Subject: Re: [FAILURE] omap4430-sdp allnoconfig
Date: Thu, 1 Aug 2013 13:06:18 -0700
Message-ID: <20130801200618.GA8892@quad.lixom.net>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
 <51FAA4C6.10203@ti.com>
 <20130801182707.GB23053@n2100.arm.linux.org.uk>
 <51FAA985.3000809@ti.com>
 <51FAAA31.6020903@codeaurora.org>
 <51FAAAFD.6000706@codeaurora.org>
 <51FAAD73.3030103@ti.com>
 <20130801185956.GK8868@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54259 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3HAUGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 16:06:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so2541145pab.41
        for <linux-omap@vger.kernel.org>; Thu, 01 Aug 2013 13:06:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130801185956.GK8868@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, arm@kernel.org

On Thu, Aug 01, 2013 at 11:59:56AM -0700, Stephen Boyd wrote:
> On 08/01, Santosh Shilimkar wrote:
> > This one looks fine for me. Can you send above in
> > a proper patch ? Let me know if you want me to
> > send it.
> > 
> 
> Here's a proper patch. Olof, can you please apply this on top of
> the merge (and maybe you can fix the merge again to handle the
> HAVE_CAN problem I mentioned earlier).
> 
> ---8<---
> Subject: [PATCH] ARM: OMAP2+: Fix fallout from localtimer divorce and SMP=n
> 
> A recent patch ef3160c (ARM: OMAP2+: Divorce from local timer
> API, 2013-03-04) broke the omap build when SMP=n because the TWD
> functions are only compiled on SMP=y builds. Stub out the TWD
> calls when the TWD isn't built in to to keep everything building.
> 
> arch/arm/mach-omap2/built-in.o: In function
> `omap4_local_timer_init':
> dss-common.c:(.init.text+0x1d90): undefined reference to
> `twd_local_timer_register'
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, applied (with the reported-by changed as requested)


-Olof
