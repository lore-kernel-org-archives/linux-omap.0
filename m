From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP: omap_device: track latency in nanoseconds
Date: Tue, 1 Dec 2009 05:55:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010555480.13408@utopia.booyaka.com>
References: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com> <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35193 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbZLAMzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 07:55:53 -0500
In-Reply-To: <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 23 Nov 2009, Kevin Hilman wrote:

> Rather than having to do a usecs = nsecs / NSECS_PER_USEC to
> track latency in usecs, just track it in nanoseconds.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, looks good.  Will queue this up with the rest of the hwmod
patches for .33.

- Paul
