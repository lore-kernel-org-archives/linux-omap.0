From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/6] Split powerdomain framework into plat
 specific/independent
Date: Sun, 28 Nov 2010 17:33:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281731090.2515@utopia.booyaka.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43799 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab0K2Ads (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 19:33:48 -0500
In-Reply-To: <1289921886-5139-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Hi Rajendra,

As you've seen, I just did another review pass on these.  All of the 
review comments are pretty minor, although some of them will require 
moving some of the functions to different files, mostly due to OMAP3 
functions being present in an OMAP2xxx file.  

Once those changes are made and the series reposted, I think these will be 
good to merge.

regards

- Paul
