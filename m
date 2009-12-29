From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap: Remove set_clock for usb-musb.c
Date: Tue, 29 Dec 2009 21:37:01 +0200
Message-ID: <1262115421.28789.80.camel@gandalf>
References: <20091229193103.GB3512@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37609 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbZL2ThK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:37:10 -0500
In-Reply-To: <20091229193103.GB3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tue, 2009-12-29 at 11:31 -0800, Tony Lindgren wrote:
> Felipe, can you take a look at this patch? To me it seems
> like it should be now OK to get rid of set_clock.

I did that yesterday. Take a look at my git tree if you will:

http://gitorious.org/usb/usb/commits/for-tony

-- 
balbi

