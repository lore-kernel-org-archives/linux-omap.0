From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Thu, 13 Nov 2008 14:40:54 -0800
Message-ID: <20081113224053.GO3106@atomide.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com> <20081111145715.GA11056@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62958 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYKMWlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 17:41:08 -0500
Content-Disposition: inline
In-Reply-To: <20081111145715.GA11056@2ka.mipt.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* Evgeniy Polyakov <johnpol@2ka.mipt.ru> [081111 06:48]:
> Hi Stanley.
> 
> On Tue, Nov 11, 2008 at 07:50:52PM +0800, Stanley.Miao (stanley.miao@windriver.com) wrote:
> > Changes since v1:
> > 
> > 1, fix all the patch format problem.
> > 
> > 2, split the defconfig patch from code patches.
> > 
> > 3, put a twl4030keypad bug fix into a single patch.
> > 
> > 4, Add a "persistent" bit in the keypad map, and prune off "#ifdef(OMAP_LDP)"
> > from the keypad driver.
> > 
> > 
> > Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
> > up, even crash at boot time(because of omap_hdq problem).
> > 
> > Add the following patches to fix the boot crash and let LDP boot succussfuly.
> 
> I have no objections against w1 changes.
> I have no objections against other changes too, since I do not know what it is.
> 
> Feel free to add my ack if needed.

Evgeniy, can you please confirm you're adding the Stanley's 1w patch to your
upstream queue? Or else let Stanley know if he needs to repost it to
LKML.

I'm only picking up the arch/arm/*omap* parts to my queue.

Regards,

Tony

