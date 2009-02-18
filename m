From: Dongsoo Kim <dongsoo.kim@gmail.com>
Subject: Re: [RFC] How to pass camera Orientation to userspace
Date: Thu, 19 Feb 2009 05:45:57 +0900
Message-ID: <D6F0719F-FEEC-49A2-A05E-4E2051594DC0@gmail.com>
References: <200902180030.52729.linux@baker-net.org.uk> <5e9665e10902171810v45d0f454ucad4c1c10deca8c4@mail.gmail.com> <499C1CEC.5030705@redhat.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=EUC-KR;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:27922 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbZBRUqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 15:46:05 -0500
In-Reply-To: <499C1CEC.5030705@redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adam Baker <linux@baker-net.org.uk>, linux-media@vger.kernel.org, Jean-Francois Moine <moinejf@free.fr>, Hans Verkuil <hverkuil@xs4all.nl>, kilgota@banach.math.auburn.edu, Olivier Lorin <o.lorin@laposte.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, Trent Piepho <xyzzy@speakeasy.org>, linux-omap@vger.kernel.org

Hello Hans.

I went too far.
Just forgot what we can do through porting job.
You are right. That should be board specific item.
Cheers,

Nate

2009. 02. 18, =BF=C0=C8=C4 11:36, Hans de Goede =C0=DB=BC=BA:

>
>
> DongSoo(Nathaniel) Kim wrote:
>> Hello Adam,
>> I've been thinking exactly the same issue not usb but SoC based =20
>> camera.
>> I have no idea about how usb cameras work but I am quite curious =20
>> about
>> is it really possible to make proper orientation with only querying
>> camera driver.
>> Because in case of SoC based camera device, many of camera ISPs are
>> supporting VFLIP, HFLIP register on their own, and we can read =20
>> current
>> orientation by reading those registers.
>> But the problem is ISP's registers are set as not flipped at all but
>> it physically mounted upside down, because the H/W  vendor has packe=
d
>> the camera module upside down. (it sounds ridiculous but happens
>> sometimes)
>
> That happens a lot with webcams too. Given that these SoC systems =20
> will come with some board specific config anyways, all that is =20
> needed is to pass some boardconfig in to the camera driver (through =20
> platform data for example) which tells the camera driver that on =20
> this board the sensor is mounted upside down.
>
>> So in that case when we query orientation of camera, it returns not
>> flipped vertically or horizontally at all but actually it turns out =
=20
>> to
>> be upside down. Actually we are setting camera device to be flipped
>> for default in that case.
>
> Ack, but the right thing to do is not to set the vflip and hflip =20
> video4linux2 controls on by default, but to invert their meaning, so =
=20
> when the sensor is upside down, the hflip and vflip controls as seen =
=20
> by the application through the v4l2 API will report not flipping, =20
> but the hwcontrols will actually be set to flipping, and when an app =
=20
> enables flipping at the v4l2 API level it will actually gets =20
> disables at the HW level, this way the upside downness is 100% =20
> hidden from userspace. So your problem does not need any of the new =20
> API we are working on. The new API is for when the hardware cannot =20
> flip and we need to tell userspace to correct for this in software.
>
> Regards,
>
> Hans



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
