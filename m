From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: pm: Fix error condition in _pwrdm_deps_lookup when
 pwrdm not found.
Date: Thu, 13 Aug 2009 00:08:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908130008300.31026@utopia.booyaka.com>
References: <1250100755-29723-1-git-send-email-mike@android.com> <87skfwskyr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42309 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZHMGIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 02:08:44 -0400
In-Reply-To: <87skfwskyr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Chan <mike@android.com>, linux-omap@vger.kernel.org

On Wed, 12 Aug 2009, Kevin Hilman wrote:

> Mike Chan <mike@android.com> writes:
> 
> > Check pwrdm_name instead of the address of a null struct when at the
> > end of pwrdm_dep array.
> >
> > Reported-by: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Mike Chan <mike@android.com>
> 
> Thanks, to keep it all together, I'll revert the original and merge
> this into a single patch.

Great, then:

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/powerdomain.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index 0334609..02c1ef6 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -103,7 +103,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
> >  
> >  	}
> >  
> > -	if (!pd)
> > +	if (!pd->pwrdm_name)
> >  		return ERR_PTR(-ENOENT);
> >  
> >  	return pd->pwrdm;
> > -- 
> > 1.5.4.5
> 


- Paul
