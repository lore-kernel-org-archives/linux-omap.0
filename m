From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] PLAT-OMAP: McBSP: Coding style cleanup on
	arch/arm/plat-omap/mcbsp.c
Date: Mon, 14 Apr 2008 21:16:18 +0300
Message-ID: <20080414181618.GD4463@kedavra.cpe.vivax.com.br>
References: <1208188381-29638-1-git-send-email-edubezval@gmail.com> <1208188381-29638-2-git-send-email-edubezval@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39133 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764947AbYDNSOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:14:34 -0400
Content-Disposition: inline
In-Reply-To: <1208188381-29638-2-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Mon, Apr 14, 2008 at 11:53:00AM -0400, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch fix lots of warnings and errors reported by
> scripts/checkpatch.pl on arch/arm/plat-omap/mcbsp.c.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi, if you're touching mcbsp.c could you please also take a look at
this:

$ scripts/checkpatch.pl --strict --file arch/arm/plat-omap/mcbsp.c
CHECK: spinlock_t definition without comment
#60: FILE: arm/plat-omap/mcbsp.c:60:
+       spinlock_t                   lock;

total: 0 errors, 0 warnings, 1 checks, 799 lines checked

arch/arm/plat-omap/mcbsp.c has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

maybe you could just add this comment and resend this same patch ?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
