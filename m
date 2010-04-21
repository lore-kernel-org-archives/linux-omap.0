From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] cbus: fix comilation breakage
Date: Wed, 21 Apr 2010 17:56:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004211755550.24256@utopia.booyaka.com>
References: <1271859967-12914-1-git-send-email-ash@koowaldah.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50554 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab0DUX4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 19:56:47 -0400
In-Reply-To: <1271859967-12914-1-git-send-email-ash@koowaldah.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <ash@koowaldah.org>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, 21 Apr 2010, Alexander Shishkin wrote:

> Just tried to build n8x0_defconfig on the current master and
> got cbus failing to compile due to implicit kzalloc() (and
> others from slab.h) references. I'm not sure that including
> slab.h directly is the right thing to do here, though.
> 
> Signed-off-by: Alexander Shishkin <ash@koowaldah.org>

Yep, hit the same problem here, this patch fixes the build.


- Paul
