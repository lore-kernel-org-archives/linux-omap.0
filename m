From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Mon, 31 Jan 2011 08:09:12 -0800
Message-ID: <877hdl9hsn.fsf@ti.com>
References: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37208 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322Ab1AaQJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 11:09:17 -0500
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 31 Jan 2011 10:13:13 -0500 (EST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Rajendra Nayak <rnayak@ti.com>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
>> Can you elaborate a bit more on how/why runtime PM transitions
>> are disabled during system suspend, and how is it taken care
>> of that a runtime resume of a device works however a subsequent
>> runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to 
> prevent runtime power transitions from interfering with a system power 
> transition.  The PM core increments the device's usage_count; this 
> prevents the device from being runtime-suspended but it allows 
> runtime-resume calls to go through.

I understand how this works, but frankly I'm still a bit fuzzy on why.

I guess I'm still missing a good understanding of what "interfering with a
system power transition" means, and why a runtime suspend qualifies as
interfering but not a runtime resume.

More specifically, the reason for $SUBJECT patch is precisely because a
runtime resume is allowed, a runtime suspend is not, and thus a system
power transititon is prevented.

Kevin
