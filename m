From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] [OMAPZOOM] OMAP: DISPLAY: Code Clean up Trailing
 Whitespace
Date: Tue, 25 Nov 2008 12:18:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E682A9@dbde02.ent.ti.com>
References: <5d5443650811242244y75091863y247781f99a4fbc72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36452 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYKYGsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 01:48:47 -0500
In-Reply-To: <5d5443650811242244y75091863y247781f99a4fbc72@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Ogeid Alavaz <omzatru@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Trilok Soni
> Sent: Tuesday, November 25, 2008 12:14 PM
> To: Ogeid Alavaz
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] [OMAPZOOM] OMAP: DISPLAY: Code Clean up
> Trailing Whitespace
> 
> Hi Ogeid,
> 
> On Tue, Nov 25, 2008 at 12:11 PM, Ogeid Alavaz <omzatru@gmail.com>
> wrote:
> > Hi Soni,
> >
> > the video/omap directory is at omapzoom.org kernel, from master
> branch,
> > it has been removed from linux-omap kernel and pass it to v4l2
> kernel,
> > thats what I had understand.
> >
> 
> >>>  drivers/media/video/omap/Makefile          |    2 +-
> >>>  drivers/media/video/omap/omap24xxlib.c     |   64 +++---
> >>>  drivers/media/video/omap/omap24xxlib.h     |    4 +-
> >>>  drivers/media/video/omap/omap24xxvout.c    |  294
> ++++++++++++++--------------
> >>>  drivers/media/video/omap/omap24xxvout.h    |    6 +-
> >>>  drivers/media/video/omap/omap24xxvoutdef.h |   32 ++--
> >>>  6 files changed, 201 insertions(+), 201 deletions(-)
> 
> Not really. Some one need to submit omap24xxcam and omap16xxcam
> driver
> to v4l2-list, not one has done this yet. Also I don't remember when
> this omap24xxlib.[ch] and vout.[ch] was accepted in the linux-omap?
> 
[Hiremath, Vaibhav] under omap-linux, there is no support for DSS driver, the files you are referring to are part of omapzoom. Don't get confused between two trees, both the trees are different and has different set of features/code-base supported.

> I am taking liberty to CC linux-omap list.
> 
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

