From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add Omnivision OV9640 sensor support.
Date: Tue, 23 Dec 2008 14:28:06 +0530
Message-ID: <5d5443650812230058j1d316ef6w9397437798a3984a@mail.gmail.com>
References: <5d5443650812070140w423d6fe9ua2f0ff9d2974bbd7@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E90E768D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:3322 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYLWI6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 03:58:08 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2573837wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 23 Dec 2008 00:58:06 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E768D@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>

Hi Vaibhav,

>
>
> [Hiremath, Vaibhav] I just had quick walk through of code and I think you may want to take look at the review comments received for TVP514x driver (Especially for I2C).
>

I will not go for smbus_read/write APIs as of now. I will look at rest
of the comments.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
