From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/8] OMAP: omap_device: add usecounting
Date: Wed, 18 Nov 2009 03:51:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180349590.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZKRKvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:51:04 -0500
In-Reply-To: <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hello Kevin,

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> Add use counters to omap_device to enable multiple potential users of
> an omap_device.  This is needed if ever there are multiple users or
> multiple instances of a driver with a single omap_device.
> 
> Without usecounting, with multiple users, the first one to call idle
> may forcibly idle the device while other users are still active.

Could you please send along an example of the use case for this?  I would 
prefer not to add usecounting at this layer unless it is absolutely 
necessary, since only one driver should be bound to a device at a time.


- Paul
