From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Patch to fix swapping of front and back porches when reading from modedb.c
Date: Wed, 8 Sep 2010 06:38:59 -0700
Message-ID: <AANLkTikkrkVMv0gwx6f8TRGEV8A8yCS1QRg1p7izfadF@mail.gmail.com>
References: <4C87920F.9050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45429 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0IHNjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 09:39:00 -0400
Received: by qyk33 with SMTP id 33so45653qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 06:38:59 -0700 (PDT)
In-Reply-To: <4C87920F.9050005@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 8, 2010 at 6:39 AM, Tasslehoff Kjappfot <tasskjapp@gmail.com> wrote:
>
>
> Hi list :-)
>
> I had trouble getting a standard 800x600@60Hz VGA signal to display
> correctly on my monitors. Measuring the output showed that the front and
> back porches were swapped both for hsync and vsync. After reading the source
> I think I found the error in drivers/video/omap2/omapfb/omapfb-main.c. Patch
> attached.
>
> http://www.xfree86.org/3.3.6/fbdev6.html shows the way it should be, but
> todays code sets:
>
> hfp = left margin
> hbp = right margin
> vfp = upper margin
> vbp = lower margin
>
> I tested a patched kernel with 800x600@60Hz on two different monitors and a
> vga grabber, and it solved my issues.

This looks good. Before this came up, I also thought that front porch
meant left margin, and back porch meant margin, but margins are named
in relation to pixel data, and porches are named in relation to sync
pulses.

You might want to add a Signed-off-by line

Reviewed-by: Russ.Dill@gmail.com
