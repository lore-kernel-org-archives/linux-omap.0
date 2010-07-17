From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Sat, 17 Jul 2010 15:51:44 +0200
Message-ID: <201007171551.44438.marek.vasut@gmail.com>
References: <201007150648.50521.marek.vasut@gmail.com> <20100715.090028.189718162.Hiroshi.DOYU@nokia.com> <201007150804.06217.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44962 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0GQNvw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jul 2010 09:51:52 -0400
Received: by fxm14 with SMTP id 14so1520034fxm.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Jul 2010 06:51:51 -0700 (PDT)
In-Reply-To: <201007150804.06217.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, Yoshiya.Hirase@nokia.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, teerth@ti.com, linux-pm@lists.linux-foundation.org

Dne =C8t 15. =E8ervence 2010 08:04:06 Marek Vasut napsal(a):
> Dne =C8t 15. =E8ervence 2010 08:00:28 Hiroshi DOYU napsal(a):
> > From: ext Marek Vasut <marek.vasut@gmail.com>
> > Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> > Date: Thu, 15 Jul 2010 07:56:11 +0200
> >=20
> > > Dne =C8t 15. =E8ervence 2010 07:39:31 Hiroshi DOYU napsal(a):
> > >> From: ext Marek Vasut <marek.vasut@gmail.com>
> > >> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation suppo=
rt
> > >> Date: Thu, 15 Jul 2010 06:48:50 +0200
> > >>=20
> > >> > Dne St 30. =E8ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
> > >> >> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >> >>=20
> > >> >> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
> > >> >>=20
> > >> >> Based on the original work from Romit and Raghu at TI. The or=
iginal
> > >> >> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
> > >> >>=20
> > >> >> *1: https://patchwork.kernel.org/patch/96442/
> > >> >>=20
> > >> >> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >> >=20
> > >> > Hey, can this also run on pre-v7 arms ? Or is there something =
I
> > >> > missed that'd make that impossible?
> > >>=20
> > >> What I verified is with OMAP3(Cortex A8) based board.
> > >>=20
> > >> cp15 part has to be modified, but it might work without this par=
t
> > >> itself, I guess.
> > >=20
> > > I see ... do I need any special support on the bootloader or user=
land
> > > side ?
> >=20
> > No, I don't think so. The resuming boot could set up most of states
> > basically.
>=20
> I'll test it on xscale/pxa270 ... if it works, I can test on various =
pxa3xx
> too.

Sorry I wasn't able to test this yet, I'm having trouble with my cross-
toolchain.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
