From: Tony Lindgren <tony@atomide.com>
Subject: Re: cpu_is_omap15xx() doesn't get set for OMAP310
Date: Thu, 4 Sep 2008 14:51:13 -0700
Message-ID: <20080904215109.GV23085@atomide.com>
References: <20080904211036.GH2309@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50410 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbYIDVvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 17:51:21 -0400
Content-Disposition: inline
In-Reply-To: <20080904211036.GH2309@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 14:10]:
> While trying out some of the changes in qemu (which emulates an OMAP310)
> I found that cpu_is_omap15xx() returns false.
> 
> The comment says:
> 
>  * Macros to group OMAP into cpu classes.
>  * These can be used in most places.
>  * cpu_is_omap7xx():    True for OMAP730
>  * cpu_is_omap15xx():   True for OMAP1510, OMAP5910 and OMAP310
> 
> and cpu_is_omap15xx() is defined as:
> 
> #  define cpu_is_omap15xx()             is_omap15xx()
> 
> #define GET_OMAP_CLASS  ((system_rev >> 24) & 0xff)
> 
> #define IS_OMAP_CLASS(class, id)                        \
> static inline int is_omap ##class (void)                \
> {                                                       \
>         return (GET_OMAP_CLASS == (id)) ? 1 : 0;        \
> }
> 
> IS_OMAP_CLASS(15xx, 0x15)
> 
> 
> So, it's looking for the top byte of system_rev to be 0x15.  However,
> the ID table in arch/arm/mach-omap1/id.c contains:
> 
> { .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},
> 
> so the top byte contains 0x03.  Moreover, it goes on to say:
> 
>         /* Add the cpu class info (7xx, 15xx, 16xx, 24xx) */
>         cpu_type = system_rev >> 24;
>         switch (cpu_type) {
>         case 0x03:
>                 system_rev |= 0x15;
>                 break;
> 
> So, if this code is supposed to be setting the cpu class, it's setting
> it in the low byte.
> 
> It looks to me like the omap1 ID code is out of step with the omap2 ID
> code, or omap310 ID support is broken.

Looks like adding omap2 detection has broken this by stuffing in other
data there and tweaking GET_OMAP_CLASS macro. And again we have
something that's mostly working only by accident.

Probably the right fix would be to keep the original low byte as the
cpu class, fix the GET_OMAP_CLASS macro, clean-up mach-omap2/id.c
and set up static u32 system_mode to indicate HS or GP omap (High
Security vs General Purpose). That would still leave one byte in
system_rev to indicate processor revision (ES1, ES2.0).

The ugly short term fix would be to define IS_OMAP_CLASS in a different
way for omap1 and omap2. Anyways, I can fix it properly unless you're
already patching it.

Tony
