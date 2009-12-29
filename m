From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 6/8] arm: omap: musb: pass power to usb_musb_init
Date: Tue, 29 Dec 2009 21:53:01 +0200
Message-ID: <1262116381.28789.83.camel@gandalf>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
	 <1261998590-6639-7-git-send-email-felipe.balbi@nokia.com>
	 <20091229195112.GF3512@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52335 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbZL2TxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:53:10 -0500
In-Reply-To: <20091229195112.GF3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 2009-12-29 at 11:51 -0800, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [091228 03:10]:
> > each board might have a different charge pump and
> > thus able to source more or less current on vbus
> > so let power be easily configurable.
> 
> In order to justify merging this as a fix, can you please update
> the subject and description to describe that this fixes the
> the power value ?

for sure, doing it right now.

-- 
balbi

