From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 naming conventions
Date: Tue, 12 May 2009 09:24:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905120909370.17514@utopia.booyaka.com>
References: <87tz3qe5ay.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZELPYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 11:24:30 -0400
In-Reply-To: <87tz3qe5ay.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, 12 May 2009, Kevin Hilman wrote:

> As the OMAP4 patches are coming in, there seems to be a bit of variety
> in the naming of functions/macros/variables etc.
> 
> Could I propose that we just use omap4_* and OMAP4_* instead of
> OMAP44XX_* or OMAP4XXXX_* etc.
> 
> I know that OMAP2 and OMAP3 have a variety of forms here too, but
> those should probably be cleaned up eventually too.
> 
> With proper runtime revision detecting, IMO, we should only really
> have the OMAP4 prefix, and leave the sub revision handling to runtime
> code.
> 
> Thoughts?

Here are some questions that we should figure out answers to before 
deciding:

How should macros be named that only apply to specific OMAP4 chips (i.e., 
what happens if TI repeats a OMAP2420 to 2430 transition)?

How should macros be handled that are only applicable to later ES levels?  
Tagging ES levels in macros has caught many bugs in the OMAP2/3 code.


- Paul
