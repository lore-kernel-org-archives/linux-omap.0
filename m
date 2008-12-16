From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3: SDRC: fix walking of SDRC params list
Date: Mon, 15 Dec 2008 16:26:00 -0800
Message-ID: <20081216002600.GI19551@atomide.com>
References: <1229383908-15065-1-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0812151637330.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57133 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYLPA0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 19:26:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812151637330.26754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [081215 15:37]:
> On Mon, 15 Dec 2008, Kevin Hilman wrote:
> 
> > This patch fixes a bug where omap2_sdrc_get_params() does not properly
> > check for a valid table entry before continuing.
> > 
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing to l-o tree today.

Tony
