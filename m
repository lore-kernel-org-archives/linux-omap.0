From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent OMAP git broken on Beagle
Date: Sat, 10 May 2008 21:19:30 +0200
Message-ID: <4825F542.1040906@googlemail.com>
References: <48254562.7000006@googlemail.com> <20080510180935.GA8121@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:4345 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYEJTT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 15:19:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1238039fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2008 12:19:26 -0700 (PDT)
In-Reply-To: <20080510180935.GA8121@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com

Tony Lindgren wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [080509 23:49]:
>=20
>>I tried latest OMAP git (2.6.26-rc1-omap1, git from today, HEAD =3D=3D=
 =20
>>42fa072e237427675752bb9da05bf406bff19719, "OMAP3 EVM: enable ethernet=
 =20
>>support")  on OMAP3 based BeagleBoard and it immediately stops after =
=20
>>output of Kernel command line (with CONFIG_DEBUG_LL enabled):
>>
>>...
>>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
32512
>><5>Kernel command line: console=3DttyS2,115200n8 ...
>>
>>No later output or crash, nothing.
>>
>>On an older 2.6.25-omap1 kernel next output is
>>
>>...
>>Kernel command line: console=3DttyS2,115200n8 ...
>>Clocking rate (Crystal/DPLL/ARM core): 26.0/266/381 MHz
>>GPMC revision 5.0
>>...
>>
>>Assuming that it might be related to recent clock or powerdomain chan=
ges=20
>>[1] I switched back to HEAD =3D=3D "Fix remaining sparse warnings in=20
>>arch/arm/mach-omap2" (git-checkout =20
>>cdda2a9adbc5421f4857e0313afc6c189f422e25) and system now boots again.
>>
>>Any idea?
>=20
>=20
> Can you try git-bisect to see which one breaks booting on beagle?

-- cut --
 > git bisect bad
757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac is first bad commit
commit 757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac
Author: Paul Walmsley <paul@pwsan.com>
Date:   Fri May 9 14:45:24 2008 -0700

     powerdomain: convert pwrdm_mutex to rwsem

     Convert pwrdm_mutex to pwrdm_rwsem to avoid trying to relock=20
mutex in the
     event that the pwrdm_for_each() callback function calls something=20
that
     triggers a pwrdm_lookup().  Problem found by Jouni H=F6gander
     <jouni.hogander@nokia.com>

     Signed-off-by: Paul Walmsley <paul@pwsan.com>
     Signed-off-by: Tony Lindgren <tony@atomide.com>

:040000 040000 833450098951bb58b4753d0ec641e8b1e767c419=20
eb7329d713ff74ae46d0a8145f80cd4a259b8fc8 M arch
-- cut --

http://source.mvista.com/git/?p=3Dlinux-omap-2.6.git;a=3Dcommitdiff;h=3D=
757f0b4ad6b0fd4377c2ee512fc595b5778aa3ac

Anybody with Beagle can confirm this?

Many thanks

Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
