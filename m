From: "arun c" <arun.edarath@gmail.com>
Subject: Re: omapfb driver support of DSS rotation and mirroring
Date: Fri, 14 Mar 2008 15:21:06 +0530
Message-ID: <c656a4d20803140251u6627c393qdb6280d317983c2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:31261 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYCNJvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2008 05:51:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so4194734wxd.4
        for <linux-omap@vger.kernel.org>; Fri, 14 Mar 2008 02:51:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, Mar 14, 2008 at 12:07 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>
>  Hi Arun,
>
>

Thanks khasim for the reply.

>  > I am working on 2430 SDP and using the latest git kernel.
>  >
>  > I tried to rotate the framebuffer by setting the following in the bootargs
>  > video=omapfb:rotate:90
>  > video=omapfb:rotate:180
>  > video=omapfb:rotate:270
>  >
>
>  I think it is video=omapfb:rotate=270
I tried this too but not working. I rotated the console using
fbcon, but this has nothing to do with framebuffer rotation

I had a look at the sources of omapfb_main.c

       if (fbdev->ctrl->set_rotate != NULL)
               if((r = fbdev->ctrl->set_rotate(var->rotate)) < 0)
                       return r;

There is no set_rotate defined in dispc.c so the framebuffer is
not rotated at all, am i correct?

>  But I don't see VRFB support for rotation in GIT version of
> FB driver. With DMA based rotation you will end in FIFO
> underflow as it will not be able to meet the bandwidth
> requirement, you can try to port VRFB support to GIT, it
> might look bit complex, I can help you out in understanding
> (if  required).

I will try porting it to git ( Surely help is needed because i am
new), does any body tried it alredy?

Regards,
Arun C
