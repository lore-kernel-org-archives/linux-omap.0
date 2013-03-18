From: Paul Walmsley <paul@pwsan.com>
Subject: Re: commit 6797b4f causes boot hangs with nfsroot
Date: Mon, 18 Mar 2013 01:57:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303180155220.32275@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303161925410.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36810 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab3CRB5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Mar 2013 21:57:41 -0400
In-Reply-To: <alpine.DEB.2.00.1303161925410.26959@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jon-hunter@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi Jon,

On Sat, 16 Mar 2013, Paul Walmsley wrote:

> Looks like commit 6797b4fe0e554ce71f47038fd929c9ca929a9f3c ("ARM: OMAP2+: 
> Prevent potential crash if GPMC probe fails") causes hangs on boot.  I 
> suspect it may only occur when the root filesystem is on NFS over 
> GPMC-based Ethernet.

Looks like you sent a patch for this a month ago and it just now got 
merged with v3.9-rc3 as commit 31d9adca82ce65e5c99d045b5fd917c702b6fce3 
("ARM: OMAP2+: Fix broken gpmc support").  Thanks for fixing this promptly 
and sorry about the extra noise,


- Paul
