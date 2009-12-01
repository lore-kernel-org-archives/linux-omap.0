From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: add to_omap_device() macro
Date: Tue, 1 Dec 2009 05:37:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010537300.13408@utopia.booyaka.com>
References: <1259088117-25834-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37368 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbZLAMhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 07:37:39 -0500
In-Reply-To: <1259088117-25834-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 24 Nov 2009, Kevin Hilman wrote:

> Following the model of to_platform_device(), add to_omap_device()
> macro so a platform_device pointer can be converted into an
> omap_device pointer.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, I'll add this to the rest of the hwmod patches for 2.6.33.

- Paul
