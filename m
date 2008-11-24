From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Sun, 23 Nov 2008 22:32:31 -0800
Message-ID: <200811232232.31646.david-b@pacbell.net>
References: <hvaibhav@ti.com> <200811232300.40530.hverkuil@xs4all.nl> <5d5443650811232216x6c9a77a4p2945f87e1ab65a67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:44607 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750795AbYKXGce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 01:32:34 -0500
In-Reply-To: <5d5443650811232216x6c9a77a4p2945f87e1ab65a67@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: video4linux-list@redhat.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com

On Sunday 23 November 2008, Trilok Soni wrote:
> > 2) Please use the media/v4l2-i2c-drv.h or media/v4l2-i2c-drv-legacy.h
> > header to hide some of the i2c complexity (again, see e.g. saa7115.c).
> > The i2c API tends to change a lot (and some changes are upcoming) so

What "changes" do you mean?  Since this is not a legacy-style
driver (yay!), the upcoming changes won't affect it at all.


> > using this header will mean that i2c driver changes will be minimal in
> > the future. In addition it will ensure that this driver can be compiled
> > with older kernels as well once it is part of the v4l-dvb repository.
> 
> I don't agree with having support to compile with older kernels.

Right.  Folk wanting legacy tvp5146 and tvp5140 support could
try to use the legacy drivers from the DaVinci tree.


> Even though I2C APIs change as lot it is for good, and creating
> abstractions doesn't help as saa7xxx is family of chips where I don't
> see the case here. Once this driver is mainlined if someone does i2c
> subsystem change which breaks this driver from building then he/she
> has to make changes to all the code affecting it.

And AFAIK no such change is anticipated.  The conversion from
legacy style I2C drivers to "new style" driver-model friendly
drivers is progressing fairly well, so that legacy support can
be completely removed.


> I am not in favour of adding support to compile with older kernels.

My two cents:  I'm not in favor either.  In fact that's the
general policy for mainline drivers, and I'm surprised to hear
any maintainer suggest it be added.

- Dave
