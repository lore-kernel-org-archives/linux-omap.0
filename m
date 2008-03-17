From: Tony Lindgren <tony@atomide.com>
Subject: Re: I2C: Fix unhandled fault in i2c-omap controller
Date: Mon, 17 Mar 2008 08:39:29 +0200
Message-ID: <20080317063927.GN11653@atomide.com>
References: <20080313155123.GI11653@atomide.com> <20080314165317.6bc1a19e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60749 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbYCQGkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 02:40:11 -0400
Content-Disposition: inline
In-Reply-To: <20080314165317.6bc1a19e@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [080314 17:53]:
> Hi Tony,
> 
> On Thu, 13 Mar 2008 17:51:24 +0200, Tony Lindgren wrote:
> > Here's an omap I2C fix that would be nice to get into 2.6.25 if still
> > possible.
> 
> Yeah, that's possible, however the patch isn't totally trivial so I
> would appreciate if someone from the OMAP community could review it
> publicly and ack it. Then I'll push it to Linus quickly.

Well we've had this fix tested in linux-omap for about a month now and
it really fixes the problem. I'll add that to the comments.

I don't know if anybody else has seen this problem repeatedly on omaps
as it's quite rare condition, but if somebody else was seeing it,
please Ack here! :)

Regards,

Tony

