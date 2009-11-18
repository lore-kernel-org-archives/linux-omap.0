From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/8] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE
 handling
Date: Wed, 18 Nov 2009 03:01:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180259330.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>  <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>  <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>  <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <ce9ab5790911180045sa35c96bgc5d49fddc83d5ffc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36282 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990AbZKRKBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:01:02 -0500
In-Reply-To: <ce9ab5790911180045sa35c96bgc5d49fddc83d5ffc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Wed, 18 Nov 2009, Vimal Singh wrote:

> On Wed, Nov 18, 2009 at 6:35 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > From: Paul Walmsley <paul@pwsan.com>
> >
> > This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
> > hwmod code.
> >
> > After this patch, the hwmod code will set the module AUTOIDLE bit (generally
> > <module>.OCP_SYSCONFIG.AUTOIDLE) to 1 by default upon enable, and 1 upon
> > disable.
> 
> You wanted to say:  "0 upon disable", isn't it?

No, the original wording was intended, although it is somewhat confusing.

This patch wasn't intended to be posted publicly; it combines two 
unrelated changes that should be split.


- Paul
