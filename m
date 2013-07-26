From: NeilBrown <neilb@suse.de>
Subject: Re: omap2430 regression due to "usb: musb: fix incorrect usage of
 resource pointer"
Date: Sat, 27 Jul 2013 08:15:34 +1000
Message-ID: <20130727081534.4c0758a9@notabene.brown>
References: <20130726191445.1b2aaef7@notabene.brown>
	<20130726102008.GE2970@radagast>
	<20130726222458.3324ddd9@notabene.brown>
	<20130726135108.GB9795@radagast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/lUTZ4qbIsHu36BAnlepj4vG"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47689 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab3GZWPt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 18:15:49 -0400
In-Reply-To: <20130726135108.GB9795@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org

--Sig_/lUTZ4qbIsHu36BAnlepj4vG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2013 16:51:08 +0300 Felipe Balbi <balbi@ti.com> wrote:

> On Fri, Jul 26, 2013 at 10:24:58PM +1000, NeilBrown wrote:
> > On Fri, 26 Jul 2013 13:20:08 +0300 Felipe Balbi <balbi@ti.com> wrote:
> >=20
> > > On Fri, Jul 26, 2013 at 07:14:45PM +1000, NeilBrown wrote:
> > > >=20
> > > > Hi,
> > > >  the commit:
> > > >=20
> > > > commit 09fc7d22b024692b2fe8a943b246de1af307132b
> > > > Author: Felipe Balbi <balbi@ti.com>
> > > > Date:   Wed Apr 24 17:21:42 2013 +0300
> > > >=20
> > > >     usb: musb: fix incorrect usage of resource pointer
> > > >    =20
> > > >     We can't simply pass the resource pointer from our
> > > >     device down to our children, otherwise module
> > > >     reinsertion will not work as the resource will
> > > >     continue to be marked as busy.
> > > >    =20
> > > >     Fix it by building a proper struct resource for
> > > >     our child musb device.
> > > > =20
> > > >=20
> > > > (even with the subsequent compile fix applied) breaks my USB-OTG po=
rt on my
> > > > GTA04.
> > > >=20
> > > > I must admit that I don't see the point of the patch at all.
> > > > Instead of passing one array to platform_device_add_resources()
> > > > which will copy it into malloced space, it copies bits of the array=
 onto
> > > > the stack on passes that for platform_device_add_resources to copy.
> > > > What is the value of the second copy??
> > >=20
> > > if you don't do that, the resource will already be busy and ioremap w=
ill
> > > fail on second modprobe.
> >=20
> > Ahhh... the parent/sibling/child linkage - got it.
> >=20
> > >=20
> > > > But that isn't the real problem.  The real problem is that in omap2=
430_probe,
> > > > on my board at least, pdev->num_resources =3D=3D 3.  But only the f=
irst 2 entries
> > > > in the array are copied.
> > > >=20
> > > > If I make the array one entry larger and copy the extra entry it wo=
rks.  Of
> > > > course that might break for someone else who only has 2 resources t=
o copy....
> > > >=20
> > > > Can we go back to just leaving it to platform_device_add_resources =
to do the
> > > > copying it have I missed something?  (I can't see where the new old=
 code
> > > > would mark something as 'busy' that the new code won't mark as busy=
...)
> > >=20
> > > patches already in Greg's queue
> > >=20
> >=20
> > Thanks.=20
> > Doesn't seem to be in the usb-next or usb-linus branches of=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> > Can you give me a pointer?
>=20
> hmmm, looks like this is not in greg/usb-linus indeed. I'll send him
> another pull request on monday. If you wanna try, use my 'fixes' branch
> on kernel.org.

Thanks.  I found that one, pulled it in, and can confirm that it fixed my U=
SB
problem.

Thanks,
NeilBrown

--Sig_/lUTZ4qbIsHu36BAnlepj4vG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUfL1Bjnsnt1WYoG5AQIg4w//f/EmFl7+fPGpyaZuZluBCgsVlgA651tF
p5pVetKyx26SgIZPI6ed6cXCgCPHKIKS1OUIGJiVqC2nXG5BPsVgQ9cqqt2hBjYk
ICQz1ZpgI8BsNfO9LZBtHrJeXeA4ZZ3sqPWj5oiRNauadeF1gzyqR+9aUAmWY3zm
JHWskJhBA6UmFgSJ2foPtpWAUq4IVJTKgdyMjfZPaJD+lWO4M3GyoVAHuOWtJXJP
+mvK0HK3OmHuf+T8rtFyc09Rdp1kfvKeggg0KZ+3B3zwqJSuOzIidDOl5Jql5t8+
kyFqyBA8bYXdGy3UNeFrasFFN0sfOYCo07xk5NrBt4/6BuSf3lQaSWGcnqoC2TqQ
udVagSrPxGggCk49rcujel01vF4+naUQaQix8mBv2FY1wA7Ov0bQBE3zw23IOqAb
yHwgC2B5dB417E7S5UkFi3DZsehnBpCuY7oT7Y+7omdl7ib7ZvLqy4oeBD09/sXo
DBYzhsIZa6pl5crr/z/WgQUYD85U1y8KTc+n103/PJPCYbnypaRZky26hNmdqf6c
rt6Ms86tCjVNDZwterSWAHVX6m8b1vvTo8agzUlkMqgOvxa2WYvYP8+ZNCIPsjLX
4IDFuHhCQqV+oMjw1AzNTlgavfgFNMR97WBEWqifgUHZGhY3fJZld6bKaH4w1X2m
/86dXaNptlk=
=XmQF
-----END PGP SIGNATURE-----

--Sig_/lUTZ4qbIsHu36BAnlepj4vG--
