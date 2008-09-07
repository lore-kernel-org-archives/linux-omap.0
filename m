From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sun, 07 Sep 2008 16:19:18 +0100
Message-ID: <yw1xsksc7zm1.fsf@thrashbarg.mansr.com>
References: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com> <200809062223.10845.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40258 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbYIGPTa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Sep 2008 11:19:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KcM2y-0007WK-LG
	for linux-omap@vger.kernel.org; Sun, 07 Sep 2008 15:19:28 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2008 15:19:28 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2008 15:19:28 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Saturday 06 September 2008, Steve Sakoman wrote:
>> On Fri, Sep 5, 2008 at 10:52 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Steve Sakoman <sakoman@gmail.com> [080905 10:24]:
>> >> > Hmm, is the musb broken now?
>> >>
>> >> It is on Overo if I base my patches against current top of tree
>> >> (a376251519ced5831ed07ed234430725230ed93a)
>> >>
>> >> Doesn't crash, just quietly doesn't work.  I hear from Beagle fol=
k
>> >> that musb doesn't work there either.  ...
>
> A while back I tried a patch making the rc3-omap code match mainline
> (more or less) on Beagle, and it failed ... so I've been tracking
> down various RC3 issues.
>
> I don't have all of them yet, but various "used to work" (on DaVinci
> and TUSB6010) scenarios -- plugging/unplugging the B side of a cable
> (Beagle =3D=3D host), reboot with cable connected (Beagle =3D=3D peri=
pheral)
> are being trouble.
>
> There's also a notification issue with CDC Ethernet ... if the usb0
> interface (Beagle =3D=3D peripheral) is brought up before the host ge=
ts
> connected, the host can't talk to it.  I just sent that patch in:
>
>   http://marc.info/?l=3Dlinux-usb&m=3D122076214105934&w=3D2

That explains what I've been seeing.  I've applied it to my tree, but
not tested yet.

>> Mans has a patch in his git:
>>=20
>> http://git.mansr.com/?p=3Dlinux-omap;a=3Dcommitdiff;h=3D1e5bc41773bb=
981b3a89bd762becf98c72be5e4c
>>=20
>> Neither of us understand musb details enough to propose this as *the=
*
>> fix, but it seems likely to be the issue.
>
> Missing that should probably make trouble, yes.

I've also had to revert the "usb: musb: pass configuration specifics
via pdata" commits:

  ffd60d49c70b31d26430a1098edf0eef5e4dfac8 in linux-omap
  ca6d1b1333bc2e61e37982de1f28d8604c232414 in mainline

I suspect there are simply some tables missing for the Beagle board,
but I haven't a clue what should go in them.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
