From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Thu, 14 Jun 2012 21:23:25 -0700 (PDT)
Message-ID: <1339734205.13855.YahooMailNeo@web125205.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com> <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com> <1339694935.87093.YahooMailNeo@web125203.mail.ne1.yahoo.com> <CAGGh5h2MJ87By16j4VZEObNjF21TaH_h=Zveheo6c8eLwZOROw@mail.gmail.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm13-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.62]:36096 "HELO
	nm13-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750915Ab2FOEX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 00:23:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Jean-Philippe,

Thanks for the notes. I agree whole-heartedly with the idea that we're =
having a hardware issue. I'm just trying to eliminate any other softwar=
e-related issues if I can. Since I'm really just a software engineer, I=
 have to leave the hardware work to the hardware folks. All I can do is=
 try to make sure the software is as rock solid as i can. Frankly howev=
er, I think we're running out of places to look in software, provided y=
ou folks do not know of any outstanding issues similar to ours in the c=
ore AM35xx support at the moment.

The *only* thing that seems to stand in contrast to the notion of this =
being a hardware problem is that we have *finally* managed to see a few=
 of these crashes on our development kit. Since that kit contains none =
of our hardware, that was pretty surprising. That platform however, is =
certainly _exponentially_ more stable than ours at the moment, which do=
es support the idea of this being mostly or perhaps completely a hardwa=
re issue.

Our design is using a COM developed by another vendor and a custom base=
board. As noted in another post, our power has been "glitchy" since our=
 first prototype baseboards arrived. Our board uses a standard, PC-grad=
e power supply that we selected from a very reputable brand due to its =
very low stated minimum loads. Obviously AM35xx processors, even with a=
 load of attachements, do not demand much relative to a standard PC. We=
 expected that power to be clean due to the reputation of the supply ma=
nufacturer and the fact we met the minimum specs. So we basically wired=
 its 5V and 3.3V rails directly into our board and the AM3517-based COM=
 with only customary decoupling, nothing special. The trouble has been =
that those vendor specs appear to be a bit "dreamy" to say the least. W=
e've measured a number of variances in the supply, and have had to inst=
all some loading resistors on the rails for now just to ease an otherwi=
se very nasty ripple. So we do have all that
 going on and expect that could the core of this. More recently, we als=
o started detecting high frequency transients that seem to show up on a=
ll the rails at 20 - 30 minute intervals or during heavy usage. These s=
ignals are in the 80 - 100MHz range, and exist for only a few pulses. T=
hough the board appears to keep trucking when they occur, there's no wa=
y those can be good. We've yet to determine where those are coming from=
=2E So, all those things are being looked at very closely right now.

To answer your questions:=A0 We do have a few boards in the hands of a =
few engineers, and all of them are seeing similar stability and perform=
ance issues, again very sporadically. Since they appear for a while and=
 then disappear for a much longer while, it's been incredibly hard to c=
haracterize in any sense of the word. Regarding adding capacitance or o=
ther filtering, our hardware engineer is looking at that right now. As =
far as the voltages are concerned, I don't believe we have a lot of con=
trol over the 5V, 3.3V, etc. as they are basically just sourced directl=
y from the supply.

Regarding the EMAC:=A0 Has anyone else got an pair of AM3517-based some=
things laying around that they may have run iperf between?=A0 If direct=
 connected with either a crossover cable or a decent 100Mbps switch, ca=
n anyone get the full expected 85+Mbps one would expect with good TCP o=
n a 100Mbps link?=A0 As noted in the other post, the best we can do bet=
ween our EMACs is rough 50 - 70Mbps. If we connect that same EMAC, thro=
ugh the same switch, to a non-EMAC NIC, we fly right up to the full 85+=
Mbps mark and stay there. It's incredibly odd... I'd be very interested=
 in knowing what others are seeing.

Thanks again for your comments!




----- Original Message -----
=46rom: jean-philippe francois <jp.francois@cynove.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>; "linux-omap@vger.kernel.org" <lin=
ux-omap@vger.kernel.org>; Tony Lindgren <tony@atomide.com>; "Shilimkar,=
 Santosh" <santosh.shilimkar@ti.com>
Sent: Thursday, June 14, 2012 3:10 PM
Subject: Re: Please help! AM35xx mm/slab.c BUG

2012/6/14 CF Adad <cfadad@rocketmail.com>:
> An update:
>
> *LAN9221 and GPMC off the hook?*
>
> We've isolated the GPMC away from this I believe by disabling the LAN=
9221 in both our bootloaders and the kernel and by booting everything o=
ff the SD cards only.=A0 By removing it's initialization code from the =
respective board files, I *hope* we've basically removed it from conten=
tion.=A0 Obviously the chip is still wired up, but I don't expect the b=
ootloaders or kernel to be trying to talk to it.=A0 Likewise, the NAND =
is being initialized, but we're not mouting or using it at all.
>
> With these changes we're still seeing these crashes, albeit with the =
same incredible lack of frequency.
>
> *EMAC now _partially_ on the hook?*
> I posted a seperate thread on what I think may be a related subject, =
potential Davinci EMAC problems, here:=A0 http://www.spinics.net/lists/=
linux-omap/msg71833.html.
>
> As you can see from the crashes posted there, there seems to be a bit=
 of whining from the EMAC driver.=A0 Since performance in the EMAC <=3D=
> EMAC case has always been questionable anyway, any chance there is a =
tiny memory leak or something similar that could be contributing?
>
> What about configuring this EMAC from within u-boot?=A0 Could that in=
itialization do something bad when we get into Linux?=A0 I've not touch=
ed these drivers.=A0 I've simply called them like other boards in the f=
amily are doing.
>
> Just this morning, I upgraded to the latest linux-omap 3.5-rc2, but s=
till saw one of these crashes pretty quickly...
>
> *Power stability?*
>
> We're learning through all of this that our boards do appear to have =
some funny transients running through the power circuits every so often=
=2E=A0 The ones we've captured on the scope have not caused crashes or =
hard lockups, but they are there.=A0 This could be a dumb question, but=
 could power issues create a slab error like this???=A0 I guess I'm mor=
e accustomed to seeing power issues result in more hard lock ups than a=
 nicely worded dump with the kernel sometimes still somewhat functionin=
g.
>
>
I am following this bug with interest, because we often go the "custom
hardware" way, and have faced situation like these.
In my opinion, random memory corruption is more than often the sign of =
an
hardware design issue. EMAC here is perhaps only a symptom, because
it provides the proper memory bandwith and power consumption pattern th=
at
triggers the glitch.

How many board do you have ? Are some more stable than others ?
Can you solder additional caps on top of your power decoupling caps ?
Can you tweak the voltages ?

> Can anyone suggest to me anything I may not have tried to get more in=
formation out of these crashes when they occur?
>
> Thanks again to all!
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
