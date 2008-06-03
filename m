From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Booting 2.6.25 on the OMAP5912OSK
Date: Tue, 3 Jun 2008 20:32:36 +0300
Message-ID: <20080603173235.GC29125@kedavra.cpe.vivax.com.br>
References: <4842D6FB.2050508@balister.org> <94533b41efbc9aa07c7893a0a7de3080@felipebalbi.com> <48455B16.3000506@css-design.us> <20080603164926.GC6992@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34045 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbYFCRcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 13:32:25 -0400
Content-Disposition: inline
In-Reply-To: <20080603164926.GC6992@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Poulsen <spoulsen@css-design.us>, Felipe Balbi <me@felipebalbi.com>, Philip Balister <philip@balister.org>, linux-omap@vger.kernel.org

On Tue, Jun 03, 2008 at 09:49:27AM -0700, Tony Lindgren wrote:
> Hmm, yeah sounds like something is broken.. Anybody want to try to
> narrow it down with git-bisect?

ok, there's an easy way to reproduce.
echo host > /sys/devices/platform/musb_hdrc/mode
from 3430sdp. Some of the transfers in
drivers/i2c/chips/twl4030-usb.c:twl4030_set_host() is trigerring the
overflow.

btw, that XUDF bit, means _underflow_ and not overflow, so anyone who
finnishes the patch first care to send also a cleanup patch fixing that
info ;-)

I don't remember when it started to happen, but I remember that it used
to work without any underflow. Still need to read more, maybe i'll do it
tomorrow.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
