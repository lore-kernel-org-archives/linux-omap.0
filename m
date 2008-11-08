From: Rick Bronson <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Sat, 08 Nov 2008 07:29:25 -0800
Message-ID: <E1Kypkb-0001xP-PC@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:40648 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbYKHP32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Nov 2008 10:29:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Hiroshi,

  Thanks very much for the help.

  I'm getting farther.  It would help to have the right path ;-)

  Now I"m doing:

sudo modprobe bridgedriver base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P GT_str="**=01234567"

  But I still get the same results as far as interrupts.  Here is the
new (very much larger) output:

  http://www.efn.org/~rick/pub/dsp2.txt

  What does your ping.out look like?  Here's mine, it's awfully small:

-rwxr--r-- 1 rick solar 7248 2008-08-21 13:32 ping.out*                         

  What does your ping.out output when you run it?  Mine is absolutely
silent.

  Thanks again.

  Rick
