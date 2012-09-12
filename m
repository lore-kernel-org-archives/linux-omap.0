From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 10/12] ARM: OMAP4: HWMOD: add support for
 lostcontext_mask
Date: Wed, 12 Sep 2012 19:52:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121951450.17903@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41210 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab2ILTwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 15:52:03 -0400
In-Reply-To: <1342704392-23657-11-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 19 Jul 2012, Tero Kristo wrote:

> Currently hwmod only provides the offset for the context lose register,
> and if we attempt to share the same register between two or more hwmods,
> the resulting context loss counts get wrong. Thus, we need a way to
> specify which bits are used for the context loss information for each.
> This is accomplished by adding a new field to the omap4 prcm struct,
> 'lostcontext_mask', which specifies a bit-mask to use for filtering
> the register. Only the specified bits are read and cleared by the
> context lose counter update code. If a hwmod doesn't specify
> 'lostcontext_mask' (default behavior), the whole contents of the
> context register are used without any filtering.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued for 3.7.


- Paul
