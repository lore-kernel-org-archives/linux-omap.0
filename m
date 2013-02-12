From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP1: fix USB host on 1710
Date: Wed, 13 Feb 2013 01:13:54 +0200
Message-ID: <20130212231353.GA9991@blackmetal.musicnaut.iki.fi>
References: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
 <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58914 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758831Ab3BLXOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 18:14:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Jan 25, 2013 at 08:10:05AM +0000, Paul Walmsley wrote:
> On Fri, 25 Jan 2013, Aaro Koskinen wrote:
> 
> > There is a long-standing bug that OHCI USB host controller does
> > not respond on 1710, because of wrong clock definitions. See e.g.
> > http://marc.info/?l=linux-omap&m=119634441229321&w=2. All register reads
> > return just zeroes:
> 
> Thanks, queued for v3.8-rc fixes.

What happened to this patch? Will it go to 3.9?

A.
