From: Cliff Brake <cliff.brake@gmail.com>
Subject: kernel mode splash screen
Date: Tue, 3 Dec 2013 07:41:49 -0500
Message-ID: <CAOd_LFyGVBXGBuN1bZK=n2jSnLSNkBmgbo1ZQi_s1Jj6EiK=Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58308 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3LCMlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 07:41:50 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so14660306oag.6
        for <linux-omap@vger.kernel.org>; Tue, 03 Dec 2013 04:41:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

> Hello,
>
> We are working on an embedded system where we need immediate feedback
> on the screen in response to power button events, etc.  We also need
> to be able to display the splash screen whenever kernel is running.
> User space splash screens get killed too early on shutdown, etc.
>
> Does anyone know of a kernel mode splash screen that will:
>
> 1) display an image
> 2) display status messages
> 3) display progress bar (nice to have, but not required)
> 4) can be accessed from kernel and user space
> 5) when enabled, will disable writes from user space
> 6) FB based

I'm currently porting
http://git.yoctoproject.org/cgit/cgit.cgi/psplash/ to the linux
kernel.  So far, its going fairly well.  Psplash is fairly clean and
minimal.  Two questions:

1) is there kernel function to write pixels to the framebuffer?  I've
been looking at fb_fillrect()

2) what is the format of the color parameter in the following data
structure (gets passed to fb_fillrect():

struct fb_fillrect {
__u32 dx; /* screen-relative */
__u32 dy;
__u32 width;
__u32 height;
__u32 color;
__u32 rop;
};

3) We are using the omap2 frame buffer driver.  By default its
configured to provide 3 frame-buffers.  I'm not sure what this means,
but I thinking that perhaps we can use one for the splash screen, and
one for the normal frame buffer used by userspace?  The issue is I
want to disable user space from drawing to the framebuffer instantly,
and switch to the splash screen when the user presses the power switch
(instant feedback).  What is the purpose of multiple frame buffers,
and is this a reasonable use of them?

Thanks,
Cliff

-- 
=================
http://bec-systems.com
