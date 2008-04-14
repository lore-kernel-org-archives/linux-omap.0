From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] PLAT-OMAP: McBSP: Coding style cleanup on arch/arm/plat-omap/mcbsp.c
Date: Mon, 14 Apr 2008 16:24:52 -0400
Message-ID: <1208204693-11388-1-git-send-email-edubezval@gmail.com>
References: <20080414181618.GD4463@kedavra.cpe.vivax.com.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40296 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbYDNUZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 16:25:52 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3EKPWD7022977
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 23:25:49 +0300
Received: from knuth.nokia.com (essapo-nirac25231.europe.nokia.com [10.162.252.31])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3EKOp0T026203
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 23:24:51 +0300
In-Reply-To: <20080414181618.GD4463@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


On Mon, Apr 14, 2008 at 2:16 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Apr 14, 2008 at 11:53:00AM -0400, Eduardo Valentin wrote:
>  > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  >
>  > This patch fix lots of warnings and errors reported by
>  > scripts/checkpatch.pl on arch/arm/plat-omap/mcbsp.c.
>  >
>  > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  
>  Hi, if you're touching mcbsp.c could you please also take a look at
>  this:
>  
>  $ scripts/checkpatch.pl --strict --file arch/arm/plat-omap/mcbsp.c
>  CHECK: spinlock_t definition without comment
>  #60: FILE: arm/plat-omap/mcbsp.c:60:
>  +       spinlock_t                   lock;
>  
>  total: 0 errors, 0 warnings, 1 checks, 799 lines checked
>  
>  arch/arm/plat-omap/mcbsp.c has style problems, please review.  If any of these errors
>  are false positives report them to the maintainer, see
>  CHECKPATCH in MAINTAINERS.
>  
>  maybe you could just add this comment and resend this same patch ?
>  

For sure. And here is another updated version of the previous patch
with the comment.

>  --
>  Best Regards,
>  
>  Felipe Balbi
>  me@felipebalbi.com
>  http://blog.felipebalbi.com
>  



-- 
Eduardo Bezerra Valentin


