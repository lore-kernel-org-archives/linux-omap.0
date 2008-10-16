From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [omap2] Fix compiler warnings in gpmc.c
Date: Thu, 16 Oct 2008 14:16:40 -0700
Message-ID: <20081016211640.GU15820@atomide.com>
References: <1223633991-32406-1-git-send-email-premi@ti.com> <20081010112708.GS3044@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB028C70DE4D@dbde02.ent.ti.com> <20081011150011.GB15868@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65429 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYJPVQo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 17:16:44 -0400
Content-Disposition: inline
In-Reply-To: <20081011150011.GB15868@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [081012 18:25]:
> * Pakaravoor, Jagadeesh <j-pakaravoor@ti.com> [081010 17:58]:
> > 
> > What was wrong with this patch?
> > 
> > http://marc.info/?l=linux-omap&m=122277286326989&w=2
> 
> Hmm, looks like I forgot again we already had a patch for that, sorry :)
> I'll take a better look on Tuesday.

Hmm, looks like your's is missing clk_put(), so let's keep what I
already pushed.

Cheers,

Tony
