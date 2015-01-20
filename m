From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready()
 failed
Date: Tue, 20 Jan 2015 06:11:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501200611370.5450@utopia.booyaka.com>
References: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54323 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbATGLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 01:11:48 -0500
In-Reply-To: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, t-kristo@ti.com, rogerq@ti.com, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 19 Dec 2014, Lokesh Vutla wrote:

> Fixed pr_debug to pr_err when hwmod returns an error when enabling
> a module.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.20 with Roger's ack.


- Paul
