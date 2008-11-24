From: "Hans Verkuil" <hverkuil@xs4all.nl>
Subject: RE: [PATCH 2/2] TVP514x V4L int device driver support
Date: Mon, 24 Nov 2008 10:32:23 +0100 (CET)
Message-ID: <24968.62.70.2.252.1227519143.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3649 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYKXJco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 04:32:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>

>
>
> Thanks,
> Vaibhav Hiremath
>
>> -----Original Message-----
>> From: video4linux-list-bounces@redhat.com [mailto:video4linux-list-
>> bounces@redhat.com] On Behalf Of Hans Verkuil
>> Sent: Monday, November 24, 2008 1:24 PM
>> To: David Brownell
>> Cc: video4linux-list@redhat.com; linux-omap@vger.kernel.org;
>> davinci-linux-open-source-bounces@linux.davincidsp.com
>> Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
>>
>> On Monday 24 November 2008 07:32:31 David Brownell wrote:
>> > On Sunday 23 November 2008, Trilok Soni wrote:
>> > > > 2) Please use the media/v4l2-i2c-drv.h or
>> > > > media/v4l2-i2c-drv-legacy.h header to hide some of the i2c
>> > > > complexity (again, see e.g. saa7115.c). The i2c API tends to
>> > > > change a lot (and some changes are upcoming) so
>> >
>> > What "changes" do you mean?  Since this is not a legacy-style
>> > driver (yay!), the upcoming changes won't affect it at all.
>>
>> Oops, sorry. I thought it was a legacy driver, but it isn't. There
>> are
>> changes upcoming for legacy drivers, but not for new-style drivers.
>>
>> > > > using this header will mean that i2c driver changes will be
>> > > > minimal in the future. In addition it will ensure that this
>> > > > driver can be compiled with older kernels as well once it is
>> part
>> > > > of the v4l-dvb repository.
>> > >
>> > > I don't agree with having support to compile with older kernels.
>> >
>> > Right.  Folk wanting legacy tvp5146 and tvp5140 support could
>> > try to use the legacy drivers from the DaVinci tree.
>>
>> The v4l-dvb mercurial tree at www.linuxtv.org/hg which is the main
>> v4l-dvb repository can support kernels >= 2.6.16. Before new stuff
>> is
>> merged with the git kernel all the compatibility stuff for old
>> kernels
>> is stripped out, so you don't see it in the actual kernel code.
>> Using
>> the media/v4l2-i2c-drv.h header makes it much easier to support
>> these
>> older kernels and it actually reduces the code size as well. Most
>> v4l
>> i2c drivers are already converted or will be converted soon. It's a
>> v4l
>> thing.
>>
>> > > Even though I2C APIs change as lot it is for good, and creating
>> > > abstractions doesn't help as saa7xxx is family of chips where I
>> > > don't see the case here. Once this driver is mainlined if
>> someone
>> > > does i2c subsystem change which breaks this driver from building
>> > > then he/she has to make changes to all the code affecting it.
>> >
>> > And AFAIK no such change is anticipated.  The conversion from
>> > legacy style I2C drivers to "new style" driver-model friendly
>> > drivers is progressing fairly well, so that legacy support can
>> > be completely removed.
>> >
>> > > I am not in favour of adding support to compile with older
>> kernels.
>> >
>> > My two cents:  I'm not in favor either.  In fact that's the
>> > general policy for mainline drivers, and I'm surprised to hear
>> > any maintainer suggest it be added.
>>
>> Again, it's specific to v4l drivers. You don't have to do it, but it
>> makes it consistent with the other v4l i2c drivers and when the
>> driver
>> is in the v4l-dvb repository you get support for older kernels for
>> free.
>>
> [Hiremath, Vaibhav] Again only to maintain consistency, supporting legacy
> wrapper is not good practice (In my opinion). Why can't we have new driver
> coming with new interface and old drivers still can have legacy wrappers?

It's no big deal for me, it was just a suggestion. We have noticed that a
lot of people actually use the v4l-dvb repository to be able to get the
latest v4l-dvb drivers for older kernels. Using these wrappers makes it
trivial to provide that service, that's all. Just concentrate on points 1
(trivial to fix) and 4 (the only really important and 'must fix' issue).

Regards,

        Hans

