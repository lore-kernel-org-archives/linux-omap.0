From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help!  AM35xx mm/slab.c BUG
Date: Tue, 5 Jun 2012 00:08:53 -0700
Message-ID: <20120605070853.GE12766@atomide.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65447 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2FEHIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 03:08:55 -0400
Content-Disposition: inline
In-Reply-To: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* CF Adad <cfadad@rocketmail.com> [120604 23:47]:
> All,
>=20
> I'm **really** hoping someone out there can help us with this.
>=20
> My team has been working with the AM3517 for several months now, and =
we seem to be plagued every so often by what we have termed the "slab b=
ug".=C2=A0 In short, it looks something like the pasted bootlog below.=C2=
=A0 This has been an *incredibly* hard bug to figure out.=C2=A0 We have=
 a couple of different AM3517-based platforms at our disposal, but the =
one we see the issue on almost exclusively is a custom, prototype baseb=
oard designed around the TechNexion TAM3157.=C2=A0 Over the last severa=
l months, we have tried several versions of the Linux off the linux-oma=
p tree, with loads of different configurations, and even different boot=
loader versions and combinations.=C2=A0 We've spent most of our time wi=
th a linux-omap snapshot that was a 3.2-rc6, and more recently a 3.4-rc=
6 from late a week or two back.=C2=A0 (Tomorrow I anticipate pulling th=
e latest 3.5 now that I see it's out.)=C2=A0 In all cases, since we swi=
tched to 3.0+, we've seen these errors.
>=20
> They are *very* inconsistent in when they occur, but they happen ofte=
n enough to be very frustrating.=C2=A0 Consequently, our team has had a=
n incredibly difficult time tracking what's causing them.=C2=A0 They se=
em to occur at random, perhaps on average once every handful of days.=C2=
=A0 We've messed with everything we can think of from tweaking kernel o=
ptions (like enabling/disabling preemption), to disabling various drive=
rs and userspace components, to reviewing every single line in any of o=
ur board files.=C2=A0 We have tried different versions and combinations=
 of the OS and both bootloaders (x-loader & u-boot), and even went so f=
ar as to do a full analysis of the RAM timings in the EMIF4.=C2=A0 Unfo=
rtunately, nothing so far has worked.=C2=A0 The error occurs when opera=
ting off both the SD/MMC and the NAND devices, with or without the Ethe=
rnets (LAN9221 & EMAC) up and/or running, with or without PREEMPT, unde=
r heavy load and sometimes just idling, ...=C2=A0 There is simply nothi=
ng
>  consistent about it.=C2=A0 After probably 2 weeks without seeing one=
, I saw 3 today.
>=20
> Though the error's occurence is inconistent, the error itself is.=C2=A0=
 It always throws an internal OOPs at the following section of code in =
mm/slab.c:
> ---
> /*
> * The slab was either on partial or free list so
> * there must be at least one object available for
> * allocation.
> */
> BUG_ON(slabp->inuse >=3D cachep->num);
> ---
> (It appears this was patched in eons ago: https://lkml.org/lkml/2007/=
2/19/20.=C2=A0=C2=A0So it's nothing new.)

I can think of at least three issues causing errors like this:

1. Missing retention/off idle workarounds

   You can test this one by booting with nohlt cmdline option and
   seeing if that helps.

2. Broken memory

   I've seen at least one case of this where things would work
   fine if only half of the memory was in use and devices would
   oops at random point within a week. To test for this you can
   pass cmdline options to artifically partition the memory and
   leave out some chunks to see if that helps. Or boot with
   mem=3DxxxM set to half of the physical memory. And run your tests
   with SLAB_DEBUG set.

3. Software bugs

   My experience is that things are behaving very reliably regarding
   cache and highmem, so I would check #1 and #2 fist.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
