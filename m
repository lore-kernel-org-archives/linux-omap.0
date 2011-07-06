From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/5] OMAP4: prm: Remove wrong clockdomain offsets
Date: Tue, 5 Jul 2011 23:58:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052358160.4217@utopia.booyaka.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com> <1309552060-4547-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54872 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1GFF6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:58:35 -0400
In-Reply-To: <1309552060-4547-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The following commit introduced new macros to define an offset
> per clock domain in an instance.
> 
> commit e4156ee52fe617c2c2d80b5db993ff4bf07d7c3c
> 
>     OMAP4: CM instances: add clockdomain register offsets
> 
> The PRM contains only two clock controls management entities:
> EMU and WKUP.
> Remove the other ones.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>


Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.


- Paul

