From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: [beagleboard] Re: USB EHCI problems
Date: Sat, 15 Aug 2009 15:02:18 -0700
Message-ID: <1250373738.30506.5.camel@gregoire-laptop>
References: <cc69eebf0907230459jb47f4e9pb1b5953a4819aa45@mail.gmail.com>
	 <cc69eebf0908130606l78849436j459f4bf4ceaecf7b@mail.gmail.com>
	 <4A85E7D0.2070807@gmail.com>
	 <200908152304.15249.siarhei.siamashka@gmail.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:32833 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZHOWCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 18:02:20 -0400
Received: by pxi34 with SMTP id 34so720632pxi.4
        for <linux-omap@vger.kernel.org>; Sat, 15 Aug 2009 15:02:21 -0700 (PDT)
In-Reply-To: <200908152304.15249.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: beagleboard@googlegroups.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On the Touch Book (which has the same transceiver as Beagleboard), we
experience a similar problem with high speed USB. I'm playing with thos=
e
various options and patches but it's not working so far. I'm then very
interested to get any help on this problem too. More documentation abou=
t
Smart Reflex would help,

Gr=C3=A9goire


On Sat, 2009-08-15 at 23:04 +0300, Siarhei Siamashka wrote:
> On Saturday 15 August 2009, Frantisek Dufka wrote:
> > Gerald Coley wrote:
> > > You need to enable Smart Reflex on VDD2 in the Kernel. I can't se=
em to
> > > get anyone around here to help me formalize exactly how to do thi=
s in
> > > the Kernel. So if you can figure it out, I would go ahead and do =
it. If
> > > you could please then post it to the community, that would be gre=
at.
> > >
> > > Gerald
> >
> > http://www.webos-internals.org/wiki/Patch_webOS_CPU_Frequency_or_Vo=
ltage_Sc
> >aling#Enable_SmartReflex
> >
> > the file is there but after running
> > echo -n 1 > /sys/power/sr_vdd2_autocomp
> > there is still zero in the file and in kernel log I see
> > OPP3 doesn't support SmartReflex
> > SR2: VDD autocomp not activated
> >
> > Maybe different kernel would do.
>=20
> Would it make sense to ask for help in the linux-omap mailing list?
> I guess Gerald has a reply from TI or a new errata list or something =
else
> which says that "enabling Smart Reflex on VDD2" can workaround EHCI p=
roblem.
>=20
> Now somebody knowledgeable about kernel internals, OMAP3, Smart Refle=
x
> and power management code in general could probably provide some hint=
s
> or even a patch to enable this bugfix in the kernel. Maybe the fix is=
 even
> sitting in somebody's branch already and we just don't know. Or maybe=
 a
> solution for EHCI problem has been explained in the list, but just wa=
s
> lost in the pile of other messages in linux-omap (it has quite a heav=
y
> traffic).
>=20
> It may make sense to look at the 'pm' branch:
> http://elinux.org/OMAP_Power_Management
>=20
> But this wiki page has comment:
> "Enables SmartReflex autocompensation on VDD2 (Note: This feature can=
 only be=20
> tested on a ES3.1 silicon):
> # echo 1 > /sys/power/sr_vdd2_autocomp"
>=20
> And AFAIK beagleboard revision C has ES3.0 silicon. So no luck here. =
Or can
> something still be done?
>=20
> The whole beagleboard EHCI story starts here:
> http://groups.google.com/group/beagleboard/browse_thread/thread/5b838=
5f0bb1f63da/d46625fe49783a8a
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
