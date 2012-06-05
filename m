From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help!  AM35xx mm/slab.c BUG
Date: Tue, 5 Jun 2012 09:29:15 -0700 (PDT)
Message-ID: <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm22-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.60]:44269 "HELO
	nm22-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752160Ab2FEQgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 12:36:07 -0400
In-Reply-To: <20120605070853.GE12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

Thanks so much for the response!=C2=A0 All good suggestions.

#1.) Missing retention/off idle workarounds
I'm highly suspect of this one.=C2=A0 I've seen a lot of patches addres=
sing things in this category come out recently for the Sitara series, a=
nd we've tried to incorporate everything we've seen.=C2=A0 We also reba=
sed our tree off the linux-omap masteras recently as May 17th.=C2=A0 As=
 I mentioned in the first post, I hope to do this again soon, perhaps t=
oday even, to pull in all the good work you folks have done bringing us=
 up to the RCs of 3.5.


Since we discovered the "nohlt" option, we've added it to our default k=
ernel command line and have been using with it.=C2=A0 For a while, I th=
ought maybe that had fixed the glitch, but then yesterday came along...=
=C2=A0 That crash from the first message occured with 'nohlt' enabled.


#2.) Broken Memory
We really hammered this one as well, as TechNexion delivered our boards=
 with 256MB of NANYA NT5TU64M16GG=E2=80=93AC RAM.=C2=A0 Since we were u=
nfamiliar with that part, we rolled up our sleeves and evaluated every =
timing and configuration paramter in x-loader using the EMIF4 settings =
calculator spreadsheet provided by TI.=C2=A0 We also have been running =
cycles of "memtester 200M" calls, and the board seems to hold up fine u=
nder that with both the default, very conservative timings and the more=
 optimized ones we determinded with the TI sheet.

I'll give your suggestion of limiting the memory a shot and see if that=
 makes a difference.=C2=A0 Several of our older captures were run with =
SLAB_DEBUG set, but it seemed at the time that we weren't getting any m=
ore info out of that so we disabled it.=C2=A0 I'll re-enable.

#3.) Software bugs
We're certainly not opposed to the idea that we're doing something wron=
g.=C2=A0 :)=C2=A0 In fact, that would almost seem likely at this point.

A few other things that may be helpful:

* Could these issues be related to our GPMC?
We're using the SMSC LAN9221 on our board, not the slower LAN9220 that =
it seems all the AM35xx dev. kits are using.=C2=A0 Frankly, the fastest=
 we could get with that chip was ~40Mbps with a ~1-2% packet loss.=C2=A0=
 :-(=C2=A0 So, we stepped up to the faster LAN9221 that's used by Gumst=
ix and several others on the OMAP series.=C2=A0 It's running super-well=
 right now (> 80Mbps with 0% loss) with the faster GPMC timings and con=
figuration provided with the Gumstix source.=C2=A0 Is there perhaps a r=
eason all the AM35xx boards were using the LAN9220 instead?=C2=A0 We as=
sumed the AM35xx GPMC was essentially as capable as the OMAP's.=C2=A0 W=
as that a faulty assumption?

Speaking of GPMC, our NAND that Technexion is delivering requires a 4-b=
it ECC.=C2=A0 As support for that seems spotty at the moment in the var=
ious bootloader and kernel configurations, we finally punted and simply=
 used Micron's on-die engine to do it.=C2=A0 It appears stable, and we'=
ve done various filesystem burn-in tests to stress it.=C2=A0 At little =
while back we also rigged a combination nandtest + iperf across the SMS=
C to really stress the GPMC.=C2=A0 This too ran fine for several iterat=
ions.

*DaVinci EMAC?:
Perhaps it's just my latest thought-of-the-day, but since I saw so many=
 of these things yesterday while focusing on Ethernet work, after seein=
g none for the past several days doing other work, I can't help but thi=
nk it may be related to the networks somehow.=C2=A0 Some of our TAM3517=
's do not have the SMSC hooked up to them.=C2=A0 They are just using th=
eir EMAC adapters, but they have exhibited these SLAB crashes too.=C2=A0=
 So, maybe it's the EMAC?


We've noticed that when we run bandwdith tests between a pair of EMACs =
using iperf, we get a pretty reduced data rate, maybe 60Mbps.=C2=A0 The=
re is also the occasional dropped packet.=C2=A0 When we connect and EMA=
C to another port, say a laptop or a Gumstix SMSC, we get blazing perfo=
rmance.=C2=A0 That seems very odd.=C2=A0 It's like the driver is more t=
han capable of producing those high-class speeds, but when two of them =
get together they agree to dog it.=C2=A0 Could this maybe be related???


Thanks again for you time and help!




----- Original Message -----
=46rom: Tony Lindgren <tony@atomide.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Sent: Tuesday, June 5, 2012 3:08 AM
Subject: Re: Please help!  AM35xx mm/slab.c BUG

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
>=C2=A0 consistent about it.=C2=A0 After probably 2 weeks without seein=
g one, I saw 3 today.
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

=C2=A0  You can test this one by booting with nohlt cmdline option and
=C2=A0  seeing if that helps.

2. Broken memory

=C2=A0  I've seen at least one case of this where things would work
=C2=A0  fine if only half of the memory was in use and devices would
=C2=A0  oops at random point within a week. To test for this you can
=C2=A0  pass cmdline options to artifically partition the memory and
=C2=A0  leave out some chunks to see if that helps. Or boot with
=C2=A0  mem=3DxxxM set to half of the physical memory. And run your tes=
ts
=C2=A0  with SLAB_DEBUG set.

3. Software bugs

=C2=A0  My experience is that things are behaving very reliably regardi=
ng
=C2=A0  cache and highmem, so I would check #1 and #2 fist.

Regards,

Tony=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
