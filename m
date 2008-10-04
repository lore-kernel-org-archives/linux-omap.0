From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: OMAP support in mainline?
Date: Fri, 3 Oct 2008 18:23:28 -0700
Message-ID: <e5e6ade50810031823p1b1803e3n41ccc737b63b271f@mail.gmail.com>
References: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com>
	 <20081003075220.GD10743@frodo>
	 <200810030136.33838.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59908 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYJDBX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 21:23:29 -0400
Received: by gxk9 with SMTP id 9so3360396gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 18:23:28 -0700 (PDT)
In-Reply-To: <200810030136.33838.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 3, 2008 at 1:36 AM, David Brownell <david-b@pacbell.net> wrote:
>> > Unfortunately, without the patch, USB host doesn't work on the BeagleBoard.
>
> I see it working ... there's a bit of oddness in a host-only config,
> devices have to be plugged in after boot, but "doesn't work" seems
> pretty wrong.

The secret is to unplug the A cable from the mini-AB port on the
Beagleboard.  I was un/replugging my cable from the hub repeatedly,
thinking it was broken.  But un/replugging from the mini-AB port makes
everything appear.  Thanks for the hint -- I was ready to give up.

- Nathan
