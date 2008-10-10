From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/7] 3430sdp and ldp use custom twl4030 power scripts.
Date: Fri, 10 Oct 2008 10:53:22 -0700
Message-ID: <200810101053.22508.david-b@pacbell.net>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:48513 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759490AbYJJRxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 13:53:24 -0400
In-Reply-To: <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> The TI 3430dsp and ldp boards have a custom power script.

And for those of us less conversant in this tech ... could
you summarize, in words of one syllable or less, just what
these scripts do that's different from the "generic" one?
And why the generic script is inappropriate?

IMO the C files should have at least brief comments about
that, and the patch comment can have more detail.

- Dave

