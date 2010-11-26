From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 26 Nov 2010 08:38:55 +0000
Message-ID: <yw1xeia81nts.fsf@unicorn.mansr.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com> <1290589057.13243.22.camel@tubuntu> <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com> <20101124163100.GB5681@nokia.com> <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57164 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab0KZIjN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 03:39:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PLtpo-0001pl-9c
	for linux-omap@vger.kernel.org; Fri, 26 Nov 2010 09:39:12 +0100
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 26 Nov 2010 09:39:12 +0100
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 26 Nov 2010 09:39:12 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
>> Sent: Wednesday, November 24, 2010 10:01 PM
>> To: Hiremath, Vaibhav
>> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
>> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>>=20
>> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav wrot=
e:
>> >
>> > > -----Original Message-----
>> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
>> > > Sent: Wednesday, November 24, 2010 2:28 PM
>> > > To: Hiremath, Vaibhav
>> > > Cc: linux-omap@vger.kernel.org
>> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>> > >
>> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
>> > > > Hi,
> <snip>
>> >
>> > > Changing it to WAITFORGO would alter the behaviour. Sometimes it=
 would
>> > > not wait at all, sometimes it could wait for multiple vsyncs.
>> > [Hiremath, Vaibhav] I am quite not sure, whether it makes sense fr=
om
>> application point of view to wait for vsync if config is not changed=
=2E What
>> could be the use-case for such requirement, where application won't =
change
>> anything but still would like to wait on vsync?
>> >
>> > And as far as wait on multiple vsync is concerned, it does make se=
nse to
>> coat "WAITFORVSYNC ioctl makes sure that your change got applied to =
HW".
>> >
>> > I am not aware of other architectures, but I believe this is somet=
hing
>> OMAP specific stuff. And for other platforms, WAITFORVSYNC means cha=
nges
>> applied to HW (why does apps care about whether it is vsync or anyth=
ing
>> else?).
>>=20
>> WAITFORVSYNC waits for the next vsync (or actually vblank in many
>> cases).=20
> [Hiremath, Vaibhav] Please note that this doesn't include VFP
> (vertical front porch), since you are going to get VSYNC only after
> VFP.
>
>> That's it. I don't see any point in trying to shoehorn
>> other functionality into it.
>>=20
>> If you want to standardise WAITFORGO type of stuff then just add
>> another standard ioctl for it.
>>=20
> [Hiremath, Vaibhav] I still believe we should not only look at the
> name of IOCTL (WAITFORVSYNC) and define what it should do, it may
> change based on your platform/HW to get the desired functionality
> out of it.

It is impossible to know what every user expects from it.  A user may
very well be using WAITFORVSYNC for timing purposes.  If it then were
to sometimes wait more than one vsync, it would be useless.

> In OMAP there is chance of miss-match between user application and
> Display HW if user uses FBIO_WAITFORVSYNC ioctl in multi-buffer
> use-case.
>
> while (1) {
> 	Update/Create the next buffer
> 	FBIO_PAN
> 	FBIO_WAITFORVSYNC //assuming HW-SW stay in sync (which is not)
> }
>
> There is definitely an issue with above use-case which has been
> un-doubtfully conformed now.

The bug could still be argued to be in the application.

> At least in case of OMAP, WAITFORVSYNC is useless in multiple
> buffering use-case, application has to use WAITFORGO.

Why does it take so long for the changes to reach the hardware?  Once
written to the registers, the values are latched at the next vsync, so
the delay is higher up the stack.  Is there any way it could be
eliminated?  This would not only fix the "bug" under discussion here,
but also reduce the latency of page flipping.

> As far as WAITFORGO is concerned, I think GO bit concept is
> something OMAP notion/term and doesn't make sense to standardize
> it. Atleast I am not aware of any other architecture having GO bit.

Naming is minor detail.  Feel free to suggest a better one.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
