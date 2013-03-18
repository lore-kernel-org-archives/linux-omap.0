From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: commit 6797b4f causes boot hangs with nfsroot
Date: Mon, 18 Mar 2013 08:47:54 -0500
Message-ID: <51471B0A.1090608@ti.com>
References: <alpine.DEB.2.00.1303161925410.26959@utopia.booyaka.com> <alpine.DEB.2.00.1303180155220.32275@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52352 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab3CRNr5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Mar 2013 09:47:57 -0400
In-Reply-To: <alpine.DEB.2.00.1303180155220.32275@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


On 03/17/2013 08:57 PM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Sat, 16 Mar 2013, Paul Walmsley wrote:
> 
>> Looks like commit 6797b4fe0e554ce71f47038fd929c9ca929a9f3c ("ARM: OMAP2+: 
>> Prevent potential crash if GPMC probe fails") causes hangs on boot.  I 
>> suspect it may only occur when the root filesystem is on NFS over 
>> GPMC-based Ethernet.
> 
> Looks like you sent a patch for this a month ago and it just now got 
> merged with v3.9-rc3 as commit 31d9adca82ce65e5c99d045b5fd917c702b6fce3 
> ("ARM: OMAP2+: Fix broken gpmc support").  Thanks for fixing this promptly 
> and sorry about the extra noise,

Yes I see that just got merged last week so we should be good now.

Cheers
Jon
