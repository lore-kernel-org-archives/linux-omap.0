From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: Solution: N810 keyboard regression
Date: Sat, 6 Jun 2009 18:15:35 -0500
Message-ID: <200906061815.48026.luke@dashjr.org>
References: <200906061651.43882.luke@dashjr.org> <20090606224204.GA16764@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:49620 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZFFXPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jun 2009 19:15:50 -0400
In-Reply-To: <20090606224204.GA16764@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Saturday 06 June 2009 05:42:04 pm Felipe Balbi wrote:
> Are you sure that was the commit that changed it ?
> that commit is only getting rid of the debug() macro and making use of
> dev_vdbg().

Oops, looks like I put the wrong commit at fault. The correct one is:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-
omap-2.6.git;a=commit;h=bb739803dce613ed58e8b35ae52af439ab7496bf

> If you had just followed git blame you'd see that was already the
> default value on n810's lm8323 platform_data since the initial import of
> that code into linux-omap.

According to the removed code in the above commit, the default value (outside 
of and not specified in n810's lm8323 platform_data) was 12.

> I do recall testing my patches on n810 before sending them upstream and
> they were working. How are you testing this ? which tree are you using ?

I am testing the latest Linux-OMAP kernel on my N810 with Nokia's flasher and 
--load --boot options. (Userspace is Gentoo)

> did you try changing that keysize calculation ?

No, I wanted to get the opinion of someone who knows how that code actually is 
supposed to work before I try randomly changing things I don't understand.

> Do you see irqs comming? Any debugging messages ?

There were no debugging messages when the broken keys were pressed, nor did a 
dbg I added to the driver get triggered for them.

Luke
