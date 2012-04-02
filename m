From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv3 0/3] spi: omap2-mcspi: driver updates
Date: Mon, 02 Apr 2012 13:40:48 -0600
Message-ID: <20120402194049.06B613E314E@localhost>
References: <1333193818-3984-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55553 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2DBTkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Apr 2012 15:40:51 -0400
Received: by pbcun15 with SMTP id un15so4766369pbc.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Apr 2012 12:40:51 -0700 (PDT)
In-Reply-To: <1333193818-3984-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: Shubhrajyoti@ponder.secretlab.ca, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, D <shubhrajyoti@ti.com>

On Sat, 31 Mar 2012 17:06:55 +0530, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> The patch series does the following cleanups
> - Makes the driver use autosuspend
> - Folds Benoit's bus_num removal patch in the series
> - The tmp variable is used to write this can be optimised 
>  as it is not needed if the value is directly written.
>  Acknowledge  Tarun for the suggestion.
> 
> This is also available through
> git     : git://gitorious.org/linus-tree/linus-tree.git
> branch  : spi_next
> 
> Rebased to Grant's spi/next branch.

Merged, thanks.

BTW, it's easier to pull if you put the branch after the git URL (I
can cut and paste all at once):

	git://gitorious.org/linus-tree/linus-tree.git spi_next

"git request-pull" can be your friend here.

I've also respun the top commit (Trivial optimization...) because the
Cc tag format was wrong in the commit text (whitespace errors).
You'll need to be pendantic about stuff like that for trees that I
might pull.

g.


> 
>  
> 
> Benoit Cousson (1):
>   spi/omap: Remove bus_num usage for instance index
> 
> Shubhrajyoti D (2):
>   spi: omap2-mcspi: add support for pm_runtime autosuspend
>   spi: omap2-mcspi: Trivial optimisation
> 
>  drivers/spi/spi-omap2-mcspi.c |   86 +++++++++++++++++++---------------------
>  1 files changed, 41 insertions(+), 45 deletions(-)
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
