From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: How to properly enable omap-pm functionality
Date: Mon, 20 Jul 2009 08:30:53 -0700
Message-ID: <87iqhnqslu.fsf@deeprootsystems.com>
References: <0635E980-ADB1-415C-9E72-E057930C372F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:49429 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZGTPbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 11:31:03 -0400
Received: by pzk42 with SMTP id 42so5773pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2009 08:31:01 -0700 (PDT)
In-Reply-To: <0635E980-ADB1-415C-9E72-E057930C372F@mac.com> (Elvis Dowson's message of "Sat\, 18 Jul 2009 14\:56\:47 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> 			Which board file (e.g. board-3430sdp.c, etc),
> can I use as the  basis for studying how to properly implement PM for
> the gumstix overo?

SDP, omap3evm, Beagle and RX51 are all good example.

But for PM, the board files only come into play for DVFS, where the
board files can configure which OPPs to make available to core code.
On the current PM branch, I did not test DVFS on Overo because
it seems like the SDRC settings need some testing/updating[1].

> At the moment, if I look at the linux-omap-2.6 repository and take a
> look at omap-2.6.30 branch, and take a look at board-overo.c, I don't
> find any entries for including omap-pm.h, etc. 

That's because that branch has no PM support.

> You had mentioned that there was initial support for overo in the
> omap-2.6.30 release, so I thought I'd just start and check there
> initially.

No, I mentioned[1] that there was basic Overo testing done on the
latest 'pm' branch, not omap-2.6.30 branch.

Please checkout the branch named 'pm' and look there.

You still will not see omap-pm.h included because I did not
test DVFS on Overo since just going idle eventually leads
to memory corruption.

As I stated[1], SDRC settings need some validation on Overo
before DVFS can be tested.

Kevin


[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13980.html
