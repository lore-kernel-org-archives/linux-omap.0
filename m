From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] [OMAPZOOM] OMAP: DISPLAY: Code Clean up Trailing Whitespace
Date: Tue, 25 Nov 2008 12:14:21 +0530
Message-ID: <5d5443650811242244y75091863y247781f99a4fbc72@mail.gmail.com>
References: <b293b9830811241019m5817d1f3jc99cd09c99ea964a@mail.gmail.com>
	 <5d5443650811242209q34b207fu752566274b5741af@mail.gmail.com>
	 <b293b9830811242241i39414b1et60d7fd97cc2616f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:28389 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYKYGoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 01:44:22 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2633674wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 22:44:21 -0800 (PST)
In-Reply-To: <b293b9830811242241i39414b1et60d7fd97cc2616f8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ogeid Alavaz <omzatru@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ogeid,

On Tue, Nov 25, 2008 at 12:11 PM, Ogeid Alavaz <omzatru@gmail.com> wrote:
> Hi Soni,
>
> the video/omap directory is at omapzoom.org kernel, from master branch,
> it has been removed from linux-omap kernel and pass it to v4l2 kernel,
> thats what I had understand.
>

>>>  drivers/media/video/omap/Makefile          |    2 +-
>>>  drivers/media/video/omap/omap24xxlib.c     |   64 +++---
>>>  drivers/media/video/omap/omap24xxlib.h     |    4 +-
>>>  drivers/media/video/omap/omap24xxvout.c    |  294 ++++++++++++++--------------
>>>  drivers/media/video/omap/omap24xxvout.h    |    6 +-
>>>  drivers/media/video/omap/omap24xxvoutdef.h |   32 ++--
>>>  6 files changed, 201 insertions(+), 201 deletions(-)

Not really. Some one need to submit omap24xxcam and omap16xxcam driver
to v4l2-list, not one has done this yet. Also I don't remember when
this omap24xxlib.[ch] and vout.[ch] was accepted in the linux-omap?

I am taking liberty to CC linux-omap list.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
