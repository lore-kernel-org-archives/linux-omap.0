From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add Omnivision OV9640 sensor support.
Date: Mon, 1 Dec 2008 18:21:46 +0530
Message-ID: <5d5443650812010451o321e76e6s2681b3486e7c3c24@mail.gmail.com>
References: <5d5443650811280216r450c6f02v3fb0db2e1580594a@mail.gmail.com>
	 <200812011334.41306.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:29529 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLAMvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 07:51:47 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2652122wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 04:51:46 -0800 (PST)
In-Reply-To: <200812011334.41306.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>

Hi Hans,

>
> I reviewed this sensor driver and it's fine except for one thing:
> setting the default registers from outside the driver. This is a really
> bad idea. I2C drivers should be self-contained. I've made the same
> comment in the tvp514x driver review which I'm copying below (with some
> small edits):

I knew that you are going to comment on that, and I agree on those
points. I will pull in that register initialization to the driver.

>
> I noticed that the tcm825x.c driver takes exactly the same wrong
> approach, BTW.

Yes, because ov9640 was the first sensor driver on OMAP2 ;)

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
