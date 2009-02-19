From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 00:46:36 +0200
Message-ID: <20090219224636.GH32564@gandalf>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com> <20090219203251.GG20723@frodo> <20090219210429.GB7414@atomide.com> <20090219211820.GJ20723@frodo> <20090219212927.GE7414@atomide.com> <5e088bd90902191443s2ab4cc0bkc7ae51ffdef4fd71@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58265 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbZBSWqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 17:46:44 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90902191443s2ab4cc0bkc7ae51ffdef4fd71@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Feb 19, 2009 at 02:43:36PM -0800, Steve Sakoman wrote:
> EHCI omap driver definitely needs some work - there is machine
> specific stuff in there that rightfully belongs in platform data.  I
> haven't had time to work on it :-(

For sure, and there's still workaround for clk framework stuff that
should already move there.

I'll try to start with some cleanups already during this weekend (yeah,
I've got no life :-p) and post as RFT asap. After the cleanups are ok,
then I'll start moving platform code out of there and for the clock
workarounds I'll need help from Paul Walmsley, probably :-)

-- 
balbi
