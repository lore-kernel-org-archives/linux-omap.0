From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Tue, 14 Oct 2008 14:44:51 -0700
Message-ID: <200810141444.51894.david-b@pacbell.net>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <200810140900.55697.david-b@pacbell.net> <20081014212034.GA31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:39093 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751251AbYJNVoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 17:44:54 -0400
In-Reply-To: <20081014212034.GA31842@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, ext Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> I'd say that if it goes to the "wrong" place and doesn't bother anyone,
> will get forgotten. Just like the whole bunch of other drivers sitting
> in linux-omap...

I thought the point was to have them sit in mainline.  ;)


> Funny that most of such drivers are for nokia tablets :-p

Some of these drivers are first-of-a-kind, so these questions wouldn't
necessarily have come up before.  That's one of the obstacles to
mainline merge that isn't always acknowledged.

- Dave
