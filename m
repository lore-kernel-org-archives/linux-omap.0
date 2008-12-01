From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb
Date: Mon, 1 Dec 2008 19:43:58 +0100
Message-ID: <200812011943.58519.hverkuil@xs4all.nl>
References: <200812011451.06156.hverkuil@xs4all.nl> <5d5443650812011014q55a96540gc8a4b97be951f2fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:2651 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYLASok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 13:44:40 -0500
In-Reply-To: <5d5443650812011014q55a96540gc8a4b97be951f2fd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, v4l <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 01 December 2008 19:14:52 Trilok Soni wrote:
> Hi Hans,
>
> On Mon, Dec 1, 2008 at 7:21 PM, Hans Verkuil <hverkuil@xs4all.nl> 
wrote:
> > Hi Mauro,
> >
> > Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb for
> > the following:
>
> I don't understand "hg" version control tool, but commit shows your
> name as author of this patch, whereas the patch I had sent was having
> --author field as Sakari Ailus. Could you please check this? Thanks.
>
> author	Hans Verkuil <hverkuil@xs4all.nl>
> Mon Dec 01 14:49:58 2008 +0100 (4 hours ago)
> changeset 9768	2b81e03d16ed
> manifest	2b81e03d16ed
> parent 9767	7100e78482d7
> tag	tip

The hg author field is just whoever committed it into the mercurial 
repository, but what will show up when merged into the kernel are the 
From: and SoB fields. Actually, those were wrong as I had you as author 
(From:) instead of Sakari. I've changed that now.

It looks like this now:

 omap2: add OMAP2 camera driver.
 
 From: Sakari Ailus <sakari.ailus@nokia.com>
 
 Add a driver for the OMAP2 camera block. OMAP2 is used in e.g. Nokia
 N800/N810 internet tablet.
 
 This driver uses the V4L2 internal ioctl interface.
 
 Priority: normal
 
 Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
 Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
 Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

Should be fine now, thanks for the heads up.

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
