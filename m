From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Fri, 3 Oct 2008 09:42:28 -0700
Message-ID: <200810030942.28540.david-b@pacbell.net>
References: <200810030857.37888.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:32732 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751941AbYJCQmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:42:31 -0400
In-Reply-To: <200810030857.37888.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Friday 03 October 2008, David Brownell wrote:
> This flushes my queue of TWL (and related) patches that
> seem ready to merge:

Sanity tested on Beagle, FYI.

Where I observed a new oddity:  the boot hung right after
listing the MTD partitions.  Which is where the EHCI code
would come up ... took that driver out of the build, and
the hang went away.  Clue, oh clue; where art thou?

- Dave
