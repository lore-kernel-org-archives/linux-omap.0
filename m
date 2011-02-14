From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap iommu: print module name on error messages
Date: Mon, 14 Feb 2011 15:41:30 +0200 (EET)
Message-ID: <20110214.154130.1019130951550611673.Hiroshi.DOYU@nokia.com>
References: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:55442 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab1BNNl0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 08:41:26 -0500
In-Reply-To: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dacohen@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

From: ext David Cohen <dacohen@gmail.com>
Subject: [PATCH] omap iommu: print module name on error messages
Date: Sat, 12 Feb 2011 12:02:29 +0200

> OMAP IOMMU generic layer doesn't need ot print function name during
> error messages. Print module name instead which is more useful.

Agree. This makes more sense.

> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
>  arch/arm/plat-omap/iommu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
