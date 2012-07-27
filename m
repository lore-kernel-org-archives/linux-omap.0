From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: remove obsolete comment
Date: Fri, 27 Jul 2012 01:14:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207270105001.21530@utopia.booyaka.com>
References: <1343305722-16721-1-git-send-email-michael.jones@matrix-vision.de> <alpine.DEB.2.00.1207261349350.14468@utopia.booyaka.com> <50123DD1.4090307@matrix-vision.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38658 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2G0HOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 03:14:14 -0400
In-Reply-To: <50123DD1.4090307@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Michael,

On Fri, 27 Jul 2012, Michael Jones wrote:

> Thanks for the comments, I'll adhere to them in the future.  I assume you
> meant you _only_ accept patches with a non-null changelog.

Indeed, that's right, I misstated it.

> I referred to 
> http://omappedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails 
> before my submission, and didn't see these two points.  A few Q's:
> 
> Can I add these two points to that Wiki page?

Sounds reasonable, but I don't know who maintains that page.

> Or is there a more authoritative checklist somewhere?

There is; it's Documentation/SubmittingPatches which can be viewed here:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=Documentation/SubmittingPatches

> Why is it queued for 3.7?

It is a low-priority fix (but valuable nonetheless, of course).

> I thought 3.6 was in the works?

Most of the significant new patches for 3.6 were tested and queued several 
weeks ago.  Now we are queuing bugfix and regression patches for 3.6-rc 
and new features and low-priority fixes for 3.7.

> Where is it queued?

It is currently queued in a git branch on my local drive.


- Paul
