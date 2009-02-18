From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC] How to pass camera Orientation to userspace
Date: Wed, 18 Feb 2009 15:36:28 +0100
Message-ID: <499C1CEC.5030705@redhat.com>
References: <200902180030.52729.linux@baker-net.org.uk> <5e9665e10902171810v45d0f454ucad4c1c10deca8c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34263 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZBROih (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2009 09:38:37 -0500
In-Reply-To: <5e9665e10902171810v45d0f454ucad4c1c10deca8c4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Cc: Adam Baker <linux@baker-net.org.uk>, linux-media@vger.kernel.org, Jean-Francois Moine <moinejf@free.fr>, Hans Verkuil <hverkuil@xs4all.nl>, kilgota@banach.math.auburn.edu, Olivier Lorin <o.lorin@laposte.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, Trent Piepho <xyzzy@speakeasy.org>, linux-omap@vger.kernel.org



DongSoo(Nathaniel) Kim wrote:
> Hello Adam,
> 
> I've been thinking exactly the same issue not usb but SoC based camera.
> I have no idea about how usb cameras work but I am quite curious about
> is it really possible to make proper orientation with only querying
> camera driver.
> Because in case of SoC based camera device, many of camera ISPs are
> supporting VFLIP, HFLIP register on their own, and we can read current
> orientation by reading those registers.
> 
> But the problem is ISP's registers are set as not flipped at all but
> it physically mounted upside down, because the H/W  vendor has packed
> the camera module upside down. (it sounds ridiculous but happens
> sometimes)

That happens a lot with webcams too. Given that these SoC systems will come 
with some board specific config anyways, all that is needed is to pass some 
boardconfig in to the camera driver (through platform data for example) which 
tells the camera driver that on this board the sensor is mounted upside down.

> So in that case when we query orientation of camera, it returns not
> flipped vertically or horizontally at all but actually it turns out to
> be upside down. Actually we are setting camera device to be flipped
> for default in that case.

Ack, but the right thing to do is not to set the vflip and hflip video4linux2 
controls on by default, but to invert their meaning, so when the sensor is 
upside down, the hflip and vflip controls as seen by the application through 
the v4l2 API will report not flipping, but the hwcontrols will actually be set 
to flipping, and when an app enables flipping at the v4l2 API level it will 
actually gets disables at the HW level, this way the upside downness is 100% 
hidden from userspace. So your problem does not need any of the new API we are 
working on. The new API is for when the hardware cannot flip and we need to 
tell userspace to correct for this in software.

Regards,

Hans
