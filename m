From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/8] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE
 handling
Date: Wed, 18 Nov 2009 03:55:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180354280.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46619 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbZKRKzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:55:09 -0500
In-Reply-To: <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> From: Paul Walmsley <paul@pwsan.com>
> 
> This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
> hwmod code.

This patch actually combines two unrelated changes.  I've got those split 
into two patches here, will post them.

- Paul
