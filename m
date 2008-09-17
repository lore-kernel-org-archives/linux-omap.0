From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Wed, 17 Sep 2008 09:47:05 +0100
Message-ID: <yw1xy71rupkm.fsf@thrashbarg.mansr.com>
References: <1221144955.12281.6.camel@tubuntu> <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com> <20080912152937.GP31563@intune.research.nokia.com> <92846148-6506-47F1-8643-7333FB5E146A@student.utwente.nl> <yw1xbpyr3egz.fsf@thrashbarg.mansr.com> <1221480334.6312.54.camel@tubuntu> <yw1xljxtxl8t.fsf@thrashbarg.mansr.com> <1221636762.6312.117.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57078 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbYIQIr3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 04:47:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kfsh0-0003dU-FD
	for linux-omap@vger.kernel.org; Wed, 17 Sep 2008 08:47:22 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 08:47:22 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 08:47:22 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: video4linux-list@redhat.com

Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:

> On Mon, 2008-09-15 at 20:27 +0100, ext M=E5ns Rullg=E5rd wrote:
>> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
>>=20
>> > On Sat, 2008-09-13 at 22:47 +0100, ext M=E5ns Rullg=E5rd wrote:
>> >> Koen Kooi <k.kooi@student.utwente.nl> writes:
>> >
>> >> What I don't like about the patch posted is its size.  I'm sure t=
he
>> >> transition could be done in a sequence of smaller patches.  At th=
e
>> >> very least, it should be possible to move existing functionality =
to
>> >> the new architecture, then add the new parts afterwards.  I also =
see
>> >> little value in keeping the old model around, as is done in the p=
atch.
>> >
>> > I don't like the size either. However, I have no idea how the old =
driver
>> > could be transformed to include this functionality with a reasonab=
le
>> > effort. The implementations are quite different.
>> >
>> > Any suggestions how I could approach this task? Only thing that co=
mes to
>> > my mind is that there are very similar low level functions in both=
 DSS1
>> > and DSS2 (for dispc and rfbi), that I could remove from the old pl=
ace
>> > and move to arch/arm/plat-omap/dss/, but that doesn't take us very=
 far.
>>=20
>> Are the patches you posted your latest version of the code?  Do you
>> have this code in a public git repo?  I'd like to take a closer look
>> at what you've done.
>
> They are not the very latest, but they are recent enough. Unfortunate=
ly
> I don't have them on a public git. Nokia is still a bit lacking in th=
at
> area =3D). They should apply to linux-omap kernel from last Thursday =
(I
> think the commit id is mentioned in the series file).

I don't like working on old code.  It inevitably leads to wasting time
re-doing things that have already been done in the latest version.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
