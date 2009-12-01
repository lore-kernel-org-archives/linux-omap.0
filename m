From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP: omap_device: fix nsec/usec conversion in
 latency calculations
Date: Tue, 1 Dec 2009 05:55:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010554440.13408@utopia.booyaka.com>
References: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbZLAMzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 07:55:38 -0500
In-Reply-To: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 23 Nov 2009, Kevin Hilman wrote:

> Use
> 
>    usecs = nsecs / NSEC_PER_USEC;
> 
> instead of
> 
>    usecs = nsecs * NSEC_PER_USEC;
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, looks good.  Will queue this up with the rest of the hwmod 
patches for .33.

- Paul
