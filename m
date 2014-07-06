From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: add entry for RTCSS
Date: Sun, 6 Jul 2014 00:32:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
References: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com> <53B52EEC.2030800@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43451 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbaGFAcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jul 2014 20:32:08 -0400
In-Reply-To: <53B52EEC.2030800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, 3 Jul 2014, Rajendra Nayak wrote:

> On Friday 09 May 2014 06:07 PM, Sekhar Nori wrote:
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> > 
> > RTCSS on DRA7 provides a precise real-time clock.
> > Add hwmod entry for this IP.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> 
> > ---
> > Applies to linux-next of 5th May.
> 
> Might need a repost with rebase on the latest mainline.

Will queue this as soon as someone sends a Tested-by: & a boot log for it.


- Paul
