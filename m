From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: rdhi, rdlo and rm must all be different:  say =?UTF-8?Q?what=3F=3F?=
Date: Thu, 13 Mar 2008 02:35:16 -0500
Message-ID: <c3756a11e4164ac843d68e9be0d6112a@felipebalbi.com>
References: <200803121758.41024.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44548 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYCMHfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 03:35:17 -0400
In-Reply-To: <200803121758.41024.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org



On Wed, 12 Mar 2008 16:58:40 -0800, David Brownell <david-b@pacbell.net>
wrote:
> I did a build for H4, using the CodeSourcery 2007q3-53 toolchain, and:
> 
>     CC      kernel/sched.o
>   /tmp/ccePvKYj.s: Assembler messages:
>   /tmp/ccePvKYj.s:16: rdhi, rdlo and rm must all be different
>   /tmp/ccePvKYj.s:1243: rdhi, rdlo and rm must all be different
> 
> The problem doesn't crop up with a build for OSK; different CPUs,
> presumably.  It turns out these are both umull instructions; if
> I "make kernel/sched.s" and build the result, the relevant lines
> have different numbers but match up as:
> 
>   sched_clock:
>   16:     umull   r0, r1, r0, r3  @ tmp136, jiffies.371, tmp137
> 
>   sched_slice:
>           ...
>   1243:   umull   r0, r1, r0, r2  @ slice.2262, slice,
> <variable>.load.weight
> 
> So this all looks suspiciously buglike.  Does anyone know how
> to fix this issue?  Is it really a problem?

It doesn't look like an issue:

UMULL rdlo, rdhi, rn, rm

rdlo and rdhi really must be different, but they are. Maybe CodeSourcery's
toolchain is complaining about r0 appearing twice (as rdlo and rn) but
that's
not really an issue. We can multipply r0 and r3 and place the result in r0
and r1.

Most likely to be gcc bug (or codesourcery's). Please, visit [1] for more
info.

[1] http://www.keil.com/support/man/docs/armasm/armasm_cihbjehg.htm

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

