From: David Brownell <david-b@pacbell.net>
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 12:15:37 -0700
Message-ID: <200808211215.37760.david-b@pacbell.net>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com> <48AD8526.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:21943 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753609AbYHUTPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Aug 2008 15:15:41 -0400
In-Reply-To: <48AD8526.8080206@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, Swaminathan S <swami.iyer@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com, Kevin Hilman <khilman@deeprootsystems.com>

On Thursday 21 August 2008, Dmitry Krivoschekov wrote:
> why don't rely on an endpoint interrupt which is generated
> after a USB transaction is complete?

That's what I thought *was* working a couple years ago...

I take it that something broke since then?  Or is this
a corner case which didn't always work right?

I'm not sure this would be appropriate for mainline
until the DaVinci code can run there.  There are a
bunch of arch/arm/mach-davinci updates needed first.
I know Kevin was looking at some of this, but just
now I think enabling MUSB on a 2.6.27-rc4 DaVinci
config means a broken build.

- Dave
