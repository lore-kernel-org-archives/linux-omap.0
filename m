From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Wed, 3 Dec 2008 15:11:28 +0530
Message-ID: <5d5443650812030141r431371fco58501c8f241a37c7@mail.gmail.com>
References: <5d5443650812022248p28f42ce4n513dceb18adadeab@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E90E6E06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:9988 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYLCJl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 04:41:29 -0500
Received: by qb-out-0506.google.com with SMTP id e12so5890510qbe.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Dec 2008 01:41:28 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E6E06@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

Hi Vaibhav,

> [Hiremath, Vaibhav] I can tell you that for OMAP3 we do have lot of files coming in, and it really brings more confusion if we have OMAP1 and OMAP2 lying outside and OMAP3 code (Display + capture) say under omap/ or omap3/.
>

If you want OMAP3 directory I am fine with that but I still don't see
need of omap2 and omap1 files under omap directory.

> It makes sense to have omap/ directory, and all the versions/devices of OMAP get handled from omap/Kconfig and omap/Makefile. Even if they have single file it would be nice to follow directory layers.
>
> Hans, Sakari or Mauro can provide their opinion on this, and decide how to handle this.
>
> I am just providing details, so that it would be easy to take decision -
>
> OMAP1 - (I have listed names from old O-L tree)
>        - omap16xxcam.c
>        - camera_core.c
>        - camera_hw_if.h
>        - omap16xxcam.h
>        - camera_core.h

In the long run (??) this will reduce to...

omap1cam.c
omap1cam.h

as there is not need to creating this hw_if as the only user of this
interface is omap16xx. I don't see any need cam_core abstraction at
all.

>
> OMAP2 - (I have listed names from old O-L tree)
>        - omap24xxcam.c
>        - omap24xxcam-dma.c
>        - omap24xxcam.h

This is already accepted by Hans and going to be mainlined once merge
window opens.

>
> In future may be display will add here.
>
> OMAP3 -
>        Display - (Posted twice with old DSS library)
>                - omap_vout.c
>                - omap_voutlib.c
>                - omap_voutlib.h
>                - omap_voutdef.h
>        Camera - (Will come soon)
>                - omap34xxcam.c
>                - omap34xxcam.h
>        ISP - (Will come soon)
>                - Here definitely we will plenty number of files.

ISP block would be generic enough to be used on other silicons also,
right? What if it is on Davinci line of processors?


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
