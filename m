From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP support in mainline?
Date: Fri, 3 Oct 2008 18:40:23 -0700
Message-ID: <200810031840.23317.david-b@pacbell.net>
References: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com> <200810030136.33838.david-b@pacbell.net> <e5e6ade50810031823p1b1803e3n41ccc737b63b271f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:21135 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750948AbYJDBkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 21:40:25 -0400
In-Reply-To: <e5e6ade50810031823p1b1803e3n41ccc737b63b271f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 03 October 2008, Nathan Monson wrote:
> On Fri, Oct 3, 2008 at 1:36 AM, David Brownell <david-b@pacbell.net> wrote:
> >> > Unfortunately, without the patch, USB host doesn't work on the BeagleBoard.
> >
> > I see it working ... there's a bit of oddness in a host-only config,
> > devices have to be plugged in after boot, but "doesn't work" seems
> > pretty wrong.
> 
> The secret is to unplug the A cable from the mini-AB port on the
> Beagleboard.  I was un/replugging my cable from the hub repeatedly,
> thinking it was broken.  But un/replugging from the mini-AB port makes
> everything appear.  Thanks for the hint -- I was ready to give up.

Yeah, I was pleased to discover that trick!

Of course, it's supposed to work without the unplug step too.  :)

- Dave

