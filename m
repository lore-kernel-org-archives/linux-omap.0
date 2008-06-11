From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] i2c: twl4030: warning: mixed declarations and code
Date: Wed, 11 Jun 2008 16:55:02 +0300
Message-ID: <20080611135502.GI20671@gandalf.research.nokia.com>
References: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com> <a0580c510806110653p65b64857y8de6897489d60466@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42098 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYFKN4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 09:56:40 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510806110653p65b64857y8de6897489d60466@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eduardo Valentin <edubezval@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Wed, Jun 11, 2008 at 09:53:45AM -0400, ext Eduardo Valentin wrote:
> > -       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
> >        u32 l;
> > +       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
> 
> To me you are just moving the place of this declaration.

Yes, because ISO C99 forbids mixed declaraction and code. build
tlw4030-usb and you'll see the warning. ;-)

-- 
	- Balbi
