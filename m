From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Mon, 15 Sep 2008 23:24:44 +0300
Message-ID: <94a0d4530809151324x1dc3069at8f6163188267676f@mail.gmail.com>
References: <94a0d4530809150738v7638988bnd12901d147a42d1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:14525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbYIOUYp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 16:24:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2315380rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Sep 2008 13:24:45 -0700 (PDT)
In-Reply-To: <94a0d4530809150738v7638988bnd12901d147a42d1e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 5:38 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I've been trying to get the yuv overlay to work, but without success.
> I'm trying to do what Mans Rullgard is doing on omapfbplay[1], but I
> don't see anything happening.
>
> The normal RGB plane is working fine, I'm attaching a test that writes
> data to the whole framebuffer.
>
> This is the output:
> # /tmp/fb_test
> main: size=720x400, 16bpp
> overlay: size=720x400, 16bpp
> panel: enabled=0
> panel: 0x0 - 720x400
> # /tmp/fb_test
> main: size=720x400, 16bpp
> overlay: size=720x400, 16bpp
> panel: enabled=1
> panel: 0x0 - 720x400

Nevermind, this patch fixed the issue:
http://gitweb.openembedded.net/?p=org.openembedded.dev.git;a=blob;f=packages/linux/linux-omap2-git/beagleboard/03-enable-overlay-opt.diff;h=9fa749f5fc00a711afc6f31781d45efa885b4ccf;hb=HEAD

Now I'm getting a bunch of these errors apparently when shuffling
memory too fast:
irq -33, desc: c0335cf8, depth: 0, count: 0, unhandled: 0
->handle_irq():  c00744e0, handle_bad_irq+0x0/0x22c
->chip(): 00000000, 0x0
->action(): 00000000

-- 
Felipe Contreras
