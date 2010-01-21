From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the
 cpuidle thread.
Date: Wed, 20 Jan 2010 23:23:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202314040.24456@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37259 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0AUGXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 01:23:35 -0500
In-Reply-To: <1264001442-20078-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com


Hi Thara,

I'd like to merge the powerdomain changes separately from the other 
changes, most of which should probably go through Kevin's PM branch.

After you revise your patches based on the comments, can you take your 
patches 3, 4, and the powerdomain portions of patch 7 and post those in a 
separate series as an OSWR preparatory powerdomain patch set?  That will 
make it easier for both Kevin and I to handle.

Note: the powerdomain code will need to be edited somewhat to bring it 
up-to-date with the latest OMAP4 changes in the for_2.6.34 branch, which 
is where your patches will go.  I'm happy to do this, but after I do it, 
will you be able to test the updated series to ensure that this process 
didn't break anything?

regards,

- Paul
