From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP2/3: SDRC: fix walking of SDRC params list
Date: Mon, 15 Dec 2008 16:37:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812151637330.26754@utopia.booyaka.com>
References: <1229383908-15065-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41096 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYLOXht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 18:37:49 -0500
In-Reply-To: <1229383908-15065-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 15 Dec 2008, Kevin Hilman wrote:

> This patch fixes a bug where omap2_sdrc_get_params() does not properly
> check for a valid table entry before continuing.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
