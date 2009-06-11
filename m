From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 TV settings
Date: Thu, 11 Jun 2009 09:08:47 +0300
Message-ID: <1244700527.8293.4.camel@tubuntu>
References: <4A2FEAC5.1060107@mlbassoc.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57100 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbZFKGJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 02:09:24 -0400
In-Reply-To: <4A2FEAC5.1060107@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-06-10 at 19:17 +0200, ext Gary Thomas wrote:
> Tomi,
> 
> I'm running your latest DSS2 tree and have some questions about
> the TV settings.  The timings, as published, don't work all that
> well on our TV sets.  When I display a frame buffer to the TV
> (using the recipe from the Documentation directory), some of
> the actual frame buffer does not show on the screen.  In particular,
> if I have "tux" from the default system console framebuffer
> showing, the top of his head is chopped off, as is a fair
> amount of his left side.  Further tests show that some amount
> of the frame buffer is not present on all margins.
> 
> Is this to be expected?
> Can the timings be adjusted so that the whole frame buffer shows?

That is to be expected. I'm not an expert on analog TVs, but I think
analog TVs always have non-visible areas. Some TVs show more of the
total frame, and some show less.

You need to adjust the overlay position and size so that it's fully
visible on the TV. I guess there are some sane defaults that are more or
less ok for every TV out there, and omapfb could use those defaults, but
I haven't really had time to study the TV out.

> 
> [not 100% related] The documentation says that TI is working on
> the V4L2 support.  Do you know the status of this?  where I might
> find it?

I cannot help you with this. There have been mails about it on
linux-omap and v4l2 lists, so you could search those archives.

 Tomi


