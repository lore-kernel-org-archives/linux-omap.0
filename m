From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: FSUSB Register access
Date: Wed, 5 Nov 2008 03:11:42 +0200
Message-ID: <20081105011142.GF4010@frodo>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com> <20081104222032.GD4010@frodo> <9D31108D62FAE54AA21AEF899D69931E0385AADF@AZ25EXM04.gddsi.com> <20081105005523.GE4010@frodo> <9D31108D62FAE54AA21AEF899D69931E0385AAF1@AZ25EXM04.gddsi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43676 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYKEBLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 20:11:49 -0500
Content-Disposition: inline
In-Reply-To: <9D31108D62FAE54AA21AEF899D69931E0385AAF1@AZ25EXM04.gddsi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "York, Jeffrey-P56387" <Jeff.York@gdc4s.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

On Tue, Nov 04, 2008 at 06:03:05PM -0700, York, Jeffrey-P56387 wrote:
> Balbi,
> 
> Thanks for your help.
> 
> See below for the answers.
> 
> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Tuesday, November 04, 2008 5:55 PM
> To: York, Jeffrey-P56387
> Cc: me@felipebalbi.com; linux-omap@vger.kernel.org
> Subject: Re: FSUSB Register access
> 
> Hi,
> 
> On Tue, Nov 04, 2008 at 05:38:28PM -0700, York, Jeffrey-P56387 wrote:
> > <JEFF SAYS:  I did this and I do see logging now.  It shows as
> expected
> > an external abort on non-linefetch when it tries to read from an FSUSB
> > register.  As far as I can tell from the TI spec, I should only have
> to
> > enable the 48 MHz clock...  And I know it is enabled via a read from
> the
> > CM_IDLEST_CKGEN register.>
> 
> hmm.. yeah, looks like it's clock issue. Do you call:
> 
> clk_get();
> clk_enable();
> 
> before reading the register ?? Although, if CM_IDLEST_CKGEN says it's
> on, it should be.
> 
> <JEFF SAYS:  I do when trying to request the "usb_fck" and "usb_l4_ick".
> Not sure what the code is doing for the 48 MHz clock.  That's done
> somewhere else in the Mobilinux kernel.  Given that the register says
> its on, I was assuming that clock was good.>

still, you were getting the "unable to enable clock usb_fck after 1000000
tries" message, right ? But then again, the register says it's good.

So might be something elsewhere. Could you share your code ? It'd be
much simpler to say what's going on by looking at your code.

-- 
balbi
