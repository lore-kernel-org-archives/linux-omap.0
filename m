From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] Add Omnivision OV9640 sensor support.
Date: Mon, 8 Dec 2008 09:54:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E90E768D@dbde02.ent.ti.com>
References: <5d5443650812070140w423d6fe9ua2f0ff9d2974bbd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50404 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765AbYLHEZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 23:25:32 -0500
In-Reply-To: <5d5443650812070140w423d6fe9ua2f0ff9d2974bbd7@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>

Hi Soni,

Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Trilok Soni
> Sent: Sunday, December 07, 2008 3:11 PM
> To: Hans Verkuil
> Cc: v4l; linux-omap@vger.kernel.org Mailing List; Sakari Ailus
> Subject: Re: [PATCH] Add Omnivision OV9640 sensor support.
> 
> Hi Hans,
> 
> On Mon, Dec 1, 2008 at 6:21 PM, Trilok Soni <soni.trilok@gmail.com>
> wrote:
> > Hi Hans,
> >
> >>
> >> I reviewed this sensor driver and it's fine except for one thing:
> >> setting the default registers from outside the driver. This is a
> really
> >> bad idea. I2C drivers should be self-contained. I've made the
> same
> >> comment in the tvp514x driver review which I'm copying below
> (with some
> >> small edits):
> >
> > I knew that you are going to comment on that, and I agree on those
> > points. I will pull in that register initialization to the driver.
> >
> 
> Attached the updated ov9640 sensor patch.
> 


[Hiremath, Vaibhav] I just had quick walk through of code and I think you may want to take look at the review comments received for TVP514x driver (Especially for I2C).

> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
