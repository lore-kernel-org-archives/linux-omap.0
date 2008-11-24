From: "Hans Verkuil" <hverkuil@xs4all.nl>
Subject: RE: [PATCH 2/2] TVP514x V4L int device driver support
Date: Mon, 24 Nov 2008 12:23:35 +0100 (CET)
Message-ID: <12803.62.70.2.252.1227525815.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:4818 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbYKXLYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 06:24:21 -0500
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
>> From: Hans Verkuil [mailto:hverkuil@xs4all.nl]
>> Sent: Monday, November 24, 2008 3:02 PM
>> To: Hiremath, Vaibhav
>> Cc: David Brownell; video4linux-list@redhat.com; linux-
>> omap@vger.kernel.org; davinci-linux-open-source-
>> bounces@linux.davincidsp.com
>> Subject: RE: [PATCH 2/2] TVP514x V4L int device driver support
>>
>> >
>> >
>> > Thanks,
>> > Vaibhav Hiremath
>> >
>> >> -----Original Message-----
>> >> From: video4linux-list-bounces@redhat.com [mailto:video4linux-
>> list-
>> >> bounces@redhat.com] On Behalf Of Hans Verkuil
>> >> Sent: Monday, November 24, 2008 1:24 PM
>> >> To: David Brownell
>> >> Cc: video4linux-list@redhat.com; linux-omap@vger.kernel.org;
>> >> davinci-linux-open-source-bounces@linux.davincidsp.com
>> >> Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
>> >>
>> >> On Monday 24 November 2008 07:32:31 David Brownell wrote:
>> >> > On Sunday 23 November 2008, Trilok Soni wrote:
>> >> > > > 2) Please use the media/v4l2-i2c-drv.h or
>> >> > > > media/v4l2-i2c-drv-legacy.h header to hide some of the i2c
>> >> > > > complexity (again, see e.g. saa7115.c). The i2c API tends
>> to
>> >> > > > change a lot (and some changes are upcoming) so
>> >> >
>> >> > What "changes" do you mean?  Since this is not a legacy-style
>> >> > driver (yay!), the upcoming changes won't affect it at all.
>> >>
>> >> Oops, sorry. I thought it was a legacy driver, but it isn't.
>> There
>> >> are
>> >> changes upcoming for legacy drivers, but not for new-style
>> drivers.
>> >>
>> >> > > > using this header will mean that i2c driver changes will be
>> >> > > > minimal in the future. In addition it will ensure that this
>> >> > > > driver can be compiled with older kernels as well once it
>> is
>> >> part
>> >> > > > of the v4l-dvb repository.
>> >> > >
>> >> > > I don't agree with having support to compile with older
>> kernels.
>> >> >
>> >> > Right.  Folk wanting legacy tvp5146 and tvp5140 support could
>> >> > try to use the legacy drivers from the DaVinci tree.
>> >>
>> >> The v4l-dvb mercurial tree at www.linuxtv.org/hg which is the
>> main
>> >> v4l-dvb repository can support kernels >= 2.6.16. Before new
>> stuff
>> >> is
>> >> merged with the git kernel all the compatibility stuff for old
>> >> kernels
>> >> is stripped out, so you don't see it in the actual kernel code.
>> >> Using
>> >> the media/v4l2-i2c-drv.h header makes it much easier to support
>> >> these
>> >> older kernels and it actually reduces the code size as well. Most
>> >> v4l
>> >> i2c drivers are already converted or will be converted soon. It's
>> a
>> >> v4l
>> >> thing.
>> >>
>> >> > > Even though I2C APIs change as lot it is for good, and
>> creating
>> >> > > abstractions doesn't help as saa7xxx is family of chips where
>> I
>> >> > > don't see the case here. Once this driver is mainlined if
>> >> someone
>> >> > > does i2c subsystem change which breaks this driver from
>> building
>> >> > > then he/she has to make changes to all the code affecting it.
>> >> >
>> >> > And AFAIK no such change is anticipated.  The conversion from
>> >> > legacy style I2C drivers to "new style" driver-model friendly
>> >> > drivers is progressing fairly well, so that legacy support can
>> >> > be completely removed.
>> >> >
>> >> > > I am not in favour of adding support to compile with older
>> >> kernels.
>> >> >
>> >> > My two cents:  I'm not in favor either.  In fact that's the
>> >> > general policy for mainline drivers, and I'm surprised to hear
>> >> > any maintainer suggest it be added.
>> >>
>> >> Again, it's specific to v4l drivers. You don't have to do it, but
>> it
>> >> makes it consistent with the other v4l i2c drivers and when the
>> >> driver
>> >> is in the v4l-dvb repository you get support for older kernels
>> for
>> >> free.
>> >>
>> > [Hiremath, Vaibhav] Again only to maintain consistency, supporting
>> legacy
>> > wrapper is not good practice (In my opinion). Why can't we have
>> new driver
>> > coming with new interface and old drivers still can have legacy
>> wrappers?
>>
>> It's no big deal for me, it was just a suggestion. We have noticed
>> that a
>> lot of people actually use the v4l-dvb repository to be able to get
>> the
>> latest v4l-dvb drivers for older kernels. Using these wrappers makes
>> it
>> trivial to provide that service, that's all. Just concentrate on
>> points 1
>> (trivial to fix) and 4 (the only really important and 'must fix'
>> issue).
>>
> [Hiremath, Vaibhav] Thanks Hans.
> Point 1 - I completely agree to your point and will fix this.
>
> Point 4 - If I understand it correctly, you are referring to parameters,
> functions exported from board specific file.
>
> Let me explain the TVP514x driver interface -
>
> Board specific file (for me arch/arm/mach-omap2/board-omap3evm-dc.c)
> exports Default register list (tvp514x_reg), input list supported
> (tvp514x_input_info), etc...
> The platform specific structure for tvp514x is looking like -
>
> static struct tvp514x_platform_data tvp5146_pdata = {
>         .power_set = tvp5146_power_set,
>         .priv_data_set = tvp5146_set_prv_data,
>         .ifparm = tvp5146_ifparm,
>
>         /* TVP5146 regsiter list, contains default values */
>         .reg_list = tvp5146_reg_list,
>
>         /* Number of supported inputs */
>         .num_inputs = TVP5146_NUM_INPUTS,
>         .input_list = tvp5146_input_list,
> };
>
>
> Are you talking about the dependency for default register list and input
> list on board specific file?

Yes. The basic rule is that only the i2c driver knows about what registers
to use. Bridge drivers should not care about that.

Things like input settings are done through the VIDIOC_INT_S_VIDEO_ROUTING
and VIDIOC_INT_S_AUDIO_ROUTING internal commands. The i2c driver header
provides high-level defines for that (which can actually map directly to
register values, but that's an implementation issue).

Again, the saa7115.c and media/saa7115.h files are very good examples of
this. And the ivtv-cards.c source is a good example of how it is used in
practice.

For the record, I'm using ivtv so often as an example because 1) I'm the
maintainer of that driver, but also because 2) it uses no less than 13 i2c
modules in various combinations and also gpio to control similar chips
that are not on the i2c bus. So that makes it an excellent non-trivial
example of how to use sub devices like tvp514x.

> I believe we can very well move it to tvp driver file, actually I found it
> easy to have complete default configuration list coming from board
> specific file instead of asking/taking some (required) params only.

It works great as long as there is only one user of tvp514x, but as soon
as a different board comes along then you run into problems.

It shouldn't be a big deal to move the default registers to the driver and
to add routing support to be able to select which inputs are used. Just
remember that the media/tvp514x.h header should be high-level and that
bridge drivers should not set registers directly. Knowledge of the
register map belongs to tvp514x.c only.

Regards,

        Hans

