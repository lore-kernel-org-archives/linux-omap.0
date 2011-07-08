From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/6] OMAP4: ID: add omap_has_feature for max freq
 supported
Date: Fri, 8 Jul 2011 00:42:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080041150.24181@utopia.booyaka.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41920 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab1GHGmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 02:42:32 -0400
In-Reply-To: <1309573826-10615-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>

On Sat, 2 Jul 2011, Rajendra Nayak wrote:

> From: Aneesh V <aneesh@ti.com>
> 
> Macros for identifying the max frequency supported by various
> OMAP4 variants - Expanding along the lines of OMAP3's feature
> handling.
> 
> [nm@ti.com: minor fixes for checks that should only for 443x|446x]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

The use of the id.c 'features' code to specify MPU speed limits doesn't 
look right to me, but I don't have a better solution in mind at the 
moment, so:

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
