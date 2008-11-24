From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Mon, 24 Nov 2008 14:13:29 +0530
Message-ID: <5d5443650811240043g37402af2l4a3da662621dd1e8@mail.gmail.com>
References: <hvaibhav@ti.com> <200811232300.40530.hverkuil@xs4all.nl>
	 <5d5443650811232216x6c9a77a4p2945f87e1ab65a67@mail.gmail.com>
	 <200811240904.12758.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:1310 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYKXIna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 03:43:30 -0500
Received: by wf-out-1314.google.com with SMTP id 24so2137237wfg.15
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 00:43:29 -0800 (PST)
In-Reply-To: <200811240904.12758.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: video4linux-list@redhat.com, linux-omap@vger.kernel.org, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hi Hans,

>
> The v4l2-int-device.h stuff should never have been added. Ditto for
> parts of the soc-camera framework that duplicates v4l2-int-device.h. My
> new v4l2_subdev support will replace the three methods of using i2c
> devices (or similar) that are currently in use. It's exactly to reduce
> the confusion that I'm working on this.
>
> It's been discussed before on the v4l mailinglist and the relevant
> developers are aware of this. It's almost finished, just need to track
> down a single remaining oops.

Right, I will wait for your updates.

I am planning to send omap24xxcam and ov9640 drivers (now deleted)
available from linux-omap tree after syncing them with latest
linux-2.6.x tree, and the whole driver and the sensor is written using
v4l2-int-device framework. I am going to send it anyway, so that it
can have some review comments.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
