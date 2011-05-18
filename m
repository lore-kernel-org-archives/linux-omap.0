From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap3: boot message is not an error
Date: Wed, 18 May 2011 08:45:52 +0300
Message-ID: <20110518084552.1e65f00f.jhnikula@gmail.com>
References: <1305644565-26233-1-git-send-email-premi@ti.com>
	<1305653621.2694.4.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59384 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab1ERFp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:45:56 -0400
Received: by ewy4 with SMTP id 4so335156ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 22:45:55 -0700 (PDT)
In-Reply-To: <1305653621.2694.4.camel@vence>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

On Tue, 17 May 2011 19:33:41 +0200
Kevin Hilman <khilman@ti.com> wrote:

> Hi Sanjeev,
> 
> On Tue, 2011-05-17 at 20:32 +0530, Sanjeev Premi wrote:
> > With current level, it shows up on the console
> > despite using 'silent' in bootargs.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> > 
> >  1) Couldn't find better text on commit message.
> >     Any suggestions?
> > 
> >  2) Though pm34xx.x is changed, the change itself
> >     is no related to power management. Hence, did
> >     annotate "pm:"
> 
> Well, it's a change to PM core code, so PM prefix is fine.  How about:
> 
> OMAP3: PM: boot message is not an error, use pr_info
> 
> Also, please Cc linux-arm-kernel, and I will queue this fix for 2.6.40.
...  
> >  arch/arm/mach-omap2/pm34xx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
Does this bootup info print here bring any benefit for pm developers
and users?

For me it looks it can be removed as the pm34xx.c is always compiled
and initialized for CONFIG_ARCH_OMAP3 so IMHO only error prints from
pm34xx.c are relevant.


-- 
Jarkko
