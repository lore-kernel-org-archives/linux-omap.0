From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/8] lp5521: move to drivers/leds
Date: Tue, 14 Oct 2008 08:53:28 -0700
Message-ID: <200810140853.28676.david-b@pacbell.net>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-3-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:26707 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751128AbYJNPxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 11:53:30 -0400
In-Reply-To: <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> This driver should be sitting together with the other
> led drivers.

... iff it actually uses the LED framework.  Which it
doesn't, yet, even for simple operations.

