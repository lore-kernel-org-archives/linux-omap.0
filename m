From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: v4l2_device/v4l2_subdev: please review
Date: Tue, 25 Nov 2008 12:57:29 +0530
Message-ID: <5d5443650811242327gc204050lf232dfac48ae4f1@mail.gmail.com>
References: <200811242309.37489.hverkuil@xs4all.nl>
	 <5d5443650811242251g5ddda028q9413b0ff47fc08a8@mail.gmail.com>
	 <200811250810.01767.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:35740 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbYKYH1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 02:27:30 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2647510wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 23:27:29 -0800 (PST)
In-Reply-To: <200811250810.01767.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org

Hi Hans,

>
> I'm not going to spam the list with these quite big patches. Just go to
> http://linuxtv.org/hg/~hverkuil/v4l-dvb-ng/ and click on the 'raw' link
> after each change to see the patch. Most of these changes are just
> boring i2c driver conversions.

It is hard to review these patches from this link, as if you submit
the patch to ML then someone can just give inline comments to your
patch, otherwise reviewer has to copy that code which he/she wants to
comment while replying and not easy to track too. I don't know size
limit of this v4l2 ML, but linux-kernel ML can receive somewhat big
patches I believe.

>
> We are adding to the v4l core, but the changes do not affect existing
> v4l drivers let alone other subsystems. Although I should probably have
> added the omap list.

OMAP + soc-camera + v4l2-int-* community would be more interested to
see these patches as they need to change their sensor/controller
drivers to adapt your changes.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
