From: Georges Toth <georges.toth@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 06 Apr 2008 15:31:21 +0200
Message-ID: <47F8D0A9.40805@gmail.com>
References: <2a9ba570-9005-4eed-8f1a-f45c909f9fe3@m36g2000hse.googlegroups.com>  <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>  <0b2d3f9c-e29a-406a-ac8d-d8589d457a0f@m36g2000hse.googlegroups.com>  <0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com>  <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>  <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>  <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>  <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>  <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com> <47F87EA6.6050504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from terman.e-hosting.lu ([80.92.79.12]:56729 "EHLO
	terman.e-hosting.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYDFOBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 10:01:05 -0400
In-Reply-To: <47F87EA6.6050504@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

Hi,
> Great!
> Do you have some screenshots we can add to
> http://elinux.org/Android_on_OMAP#Screenshots
> ?
I've added 3 screenshots on that page :-)

> Anything else we should add/correct at
> http://elinux.org/Android_on_OMAP
> ?
I wanted to add some instructions for the maemo once I got it fully 
working :-).
Basically the differences from the wiki I had to use are:
- m3 or m5 kernel, but using binder.c in any case (not the original 
binder code from m3)
- backport the android patch, to the nokia kernel sources (2.6.21)
- use the android init instead of the mentioned a.sh script
- edit the init configuration and comment the qemu parts
- only the m3 userspace files currently work

The touchscreen doesn't work yet, but I hope we can figure that out too.
-> The driver works, there is output when one does a cat on 
/dev/input/event3, but android doesn't recognize it.

Some buttons don't work ... wrong mapping.
If anybody has an idea how to see what keycodes certain buttons are 
bound to and how to edit the mapping in android that would be great :-).


> Btw: Do you have any power management issues like
> http://elinux.org/Android_on_OMAP#Power_management
> ? We still don't know anything about them :(
No. It's just that the display rather quickly dims and shuts down (2-4s 
to dim, and another 2 secs to shutdown).
It doesn't work to shut the display down via the android menu, and 
android doesn't display the battery status.

Besides that there are no problems.


-- 
regards,

Georges Toth

