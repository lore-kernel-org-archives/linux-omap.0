From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: twl4030: warning: mixed declarations and code
Date: Mon, 23 Jun 2008 16:00:05 +0300
Message-ID: <20080623130004.GX7741@atomide.com>
References: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com> <a0580c510806110653p65b64857y8de6897489d60466@mail.gmail.com> <20080611135502.GI20671@gandalf.research.nokia.com> <a0580c510806110702m655cf96by6dbd9800ef48adf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.179] ([63.208.196.179]:61710 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753798AbYFWM7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 08:59:41 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510806110702m655cf96by6dbd9800ef48adf4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval@gmail.com> [080611 17:04]:
> Hi Balbi,
> 
> On Wed, Jun 11, 2008 at 9:55 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> > On Wed, Jun 11, 2008 at 09:53:45AM -0400, ext Eduardo Valentin wrote:
> >> > -       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
> >> >        u32 l;
> >> > +       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
> >>
> >> To me you are just moving the place of this declaration.
> >
> > Yes, because ISO C99 forbids mixed declaraction and code. build
> > tlw4030-usb and you'll see the warning. ;-)
> 
> Ok. I'd suggest changing the commit message to
> i2c: twl4030: C99 warning: mixed declarations and code
> 
> But this is up to you :)

Pushing today, that driver is not in mainline yet so the comments are
just fine.

Tony
