From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP4: prm: Remove wrong clockdomain offsets
Date: Thu, 30 Jun 2011 17:12:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106301711510.2874@utopia.booyaka.com>
References: <1308847544-2322-1-git-send-email-b-cousson@ti.com> <1308847544-2322-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45765 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab1F3XMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 19:12:05 -0400
In-Reply-To: <1308847544-2322-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org

On Thu, 23 Jun 2011, Benoit Cousson wrote:

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
> Cc: Paul Walmsley <paul@pwsan.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
