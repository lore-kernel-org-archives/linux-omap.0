From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 5/7] 3430sdp and ldp use custom twl4030 power scripts.
Date: Mon, 13 Oct 2008 11:45:02 +0300
Message-ID: <20081013084502.GE4596@codecarver.research.nokia.com>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com> <200810101053.22508.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57536 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbYJMIp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 04:45:27 -0400
Content-Disposition: inline
In-Reply-To: <200810101053.22508.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 10:53:22AM -0700, ext David Brownell wrote:
> On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> > The TI 3430dsp and ldp boards have a custom power script.
> 
> And for those of us less conversant in this tech ... could
> you summarize, in words of one syllable or less, just what
> these scripts do that's different from the "generic" one?
> And why the generic script is inappropriate?
> 

These scripts are already in linux-omap, so this just maintaining
existing functionality. I don't have access to an LDP, and have no idea
why they don't use the generic script.

Cheers,

Peter.

-- 
goa is a state of mind
