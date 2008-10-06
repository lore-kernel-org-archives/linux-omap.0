From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: mmc: fix compile breakage on board-n800-mmc.c
Date: Mon, 6 Oct 2008 12:25:38 +0300
Message-ID: <20081006092538.GG7437@gandalf.research.nokia.com>
References: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com> <20081006092137.GB2806@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43933 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYJFJ0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:26:38 -0400
Content-Disposition: inline
In-Reply-To: <20081006092137.GB2806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Mon, Oct 06, 2008 at 12:21:38PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [081006 12:10]:
> > Commit 81d2c7d87a9c1eb724788fce7312922effa1b1ae broke
> > compilation of board-n800-mmc.c, this patch fixes it.
> 
> Thanks, pushing.
> 
> > Still n810 doesn't boot anymore with current linux-omap.
> > Will look into that soon.
> 
> Could it be because of the removal of the 0 byte I2C hack?

could be but I don't really think so. I'll try reverting that hack and
see if it works.

-- 
balbi
