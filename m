From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: FSUSB Register access
Date: Wed, 5 Nov 2008 02:55:24 +0200
Message-ID: <20081105005523.GE4010@frodo>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com> <20081104222032.GD4010@frodo> <9D31108D62FAE54AA21AEF899D69931E0385AADF@AZ25EXM04.gddsi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49393 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbYKEAzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 19:55:32 -0500
Content-Disposition: inline
In-Reply-To: <9D31108D62FAE54AA21AEF899D69931E0385AADF@AZ25EXM04.gddsi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "York, Jeffrey-P56387" <Jeff.York@gdc4s.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

Hi,

On Tue, Nov 04, 2008 at 05:38:28PM -0700, York, Jeffrey-P56387 wrote:
> <JEFF SAYS:  I did this and I do see logging now.  It shows as expected
> an external abort on non-linefetch when it tries to read from an FSUSB
> register.  As far as I can tell from the TI spec, I should only have to
> enable the 48 MHz clock...  And I know it is enabled via a read from the
> CM_IDLEST_CKGEN register.>

hmm.. yeah, looks like it's clock issue. Do you call:

clk_get();
clk_enable();

before reading the register ?? Although, if CM_IDLEST_CKGEN says it's
on, it should be.

Anyways, try to clk_get() the correct clock and clk_enable() it before
reading the register.

Remember, also, to clk_disable() when you're not reading the register
and clk_put() when you don't need it anymore.

> what's the kernel version ?? This should be fixed a long time ago.
> <JEFF SAYS:  2.6.21>

If you can try the current linux-omap git tree, I'd be glad. Also, when
you post bug. Please, send the console output. It really helps us
finding issues and suggesting you what to do.

-- 
balbi
