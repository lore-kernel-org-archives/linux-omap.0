From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Is the OMAP patch process badly flawed?
Date: Wed, 18 Nov 2009 00:07:42 +0200
Message-ID: <94a0d4530911171407r6e1f378al9acb3b985196158b@mail.gmail.com>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
	 <4B0213AC.6050502@blueyonder.co.uk>
	 <4B02A583.8090602@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:37005 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbZKQWHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 17:07:36 -0500
Received: by iwn8 with SMTP id 8so401431iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 14:07:42 -0800 (PST)
In-Reply-To: <4B02A583.8090602@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Nov 17, 2009 at 3:30 PM, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> I'm curious - I download, build and test kernels on x86 and x86_64
> platforms, -rc, -rc-git and -git all build and run.

[...]

> I would expect patches sent upstream would result in all the basics for
> long established platforms to be fully covered. Appreciating that
> development is quite fast paced with mods and supporting new platforms.
> Could someone please enlighten me?

Previously all the linux-omap work had to be queued through the
linux-arm tree, that made it a bit difficult to push things to the
mainline, but now Tony is sending the pull requests directly to Linus,
so maybe kernels post 2.6.32 will be much better.

However, the only way to make sure that there's good OMAP support in
Linux is for the community to actively test the mainline and make sure
the patches are properly pushed and queued, and regressions are found
quickly, not only on the linux-omap tree, but linux-usb, fbdev, etc.
Unfortunately we haven't done such a great job on that, perhaps
because many people use old "stable" aka "frozen" kernels, but things
are improving.

Cheers.

-- 
Felipe Contreras
