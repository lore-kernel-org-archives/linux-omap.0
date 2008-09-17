From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Wed, 17 Sep 2008 10:32:42 +0300
Message-ID: <1221636762.6312.117.camel@tubuntu>
References: <1221144955.12281.6.camel@tubuntu>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com>
	 <20080912152937.GP31563@intune.research.nokia.com>
	 <92846148-6506-47F1-8643-7333FB5E146A@student.utwente.nl>
	 <yw1xbpyr3egz.fsf@thrashbarg.mansr.com> <1221480334.6312.54.camel@tubuntu>
	 <yw1xljxtxl8t.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21631 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYIQHeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 03:34:11 -0400
In-Reply-To: <yw1xljxtxl8t.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org, video4linux-list@redhat.com

On Mon, 2008-09-15 at 20:27 +0100, ext M=C3=A5ns Rullg=C3=A5rd wrote:
> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
>=20
> > On Sat, 2008-09-13 at 22:47 +0100, ext M=C3=A5ns Rullg=C3=A5rd wrot=
e:
> >> Koen Kooi <k.kooi@student.utwente.nl> writes:
> >
> >> What I don't like about the patch posted is its size.  I'm sure th=
e
> >> transition could be done in a sequence of smaller patches.  At the
> >> very least, it should be possible to move existing functionality t=
o
> >> the new architecture, then add the new parts afterwards.  I also s=
ee
> >> little value in keeping the old model around, as is done in the pa=
tch.
> >
> > I don't like the size either. However, I have no idea how the old d=
river
> > could be transformed to include this functionality with a reasonabl=
e
> > effort. The implementations are quite different.
> >
> > Any suggestions how I could approach this task? Only thing that com=
es to
> > my mind is that there are very similar low level functions in both =
DSS1
> > and DSS2 (for dispc and rfbi), that I could remove from the old pla=
ce
> > and move to arch/arm/plat-omap/dss/, but that doesn't take us very =
far.
>=20
> Are the patches you posted your latest version of the code?  Do you
> have this code in a public git repo?  I'd like to take a closer look
> at what you've done.

They are not the very latest, but they are recent enough. Unfortunately
I don't have them on a public git. Nokia is still a bit lacking in that
area =3D). They should apply to linux-omap kernel from last Thursday (I
think the commit id is mentioned in the series file).

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
