From: Sergey Lapin <slapin@ossfans.org>
Subject: Re: [PATCH] OMAP: McBSP: Add 32-bit mode support
Date: Thu, 13 May 2010 18:16:03 +0400
Message-ID: <20100513141603.GA7920@build.ossfans.org>
References: <1273757957-7299-1-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from build.ossfans.org ([67.223.233.67]:34904 "EHLO
	build.ossfans.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab0EMOQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 10:16:08 -0400
Content-Disposition: inline
In-Reply-To: <1273757957-7299-1-git-send-email-slapin@ossfans.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 05:39:17PM +0400, Sergey Lapin wrote:
> This patchs should allow to use 32-bit samples on e.g. TLV320AIC23 codec,
> or others.
others include TLV320AIC32 codec.
> 
> ---
>  sound/soc/omap/omap-mcbsp.c |   30 ++++++++++++++++++++++++++----
>  1 files changed, 26 insertions(+), 4 deletions(-)

I've forgot
Signed-off-by: Sergey Lapin <slapin@ossfans.org>

