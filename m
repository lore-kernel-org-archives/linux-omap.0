From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Thu, 14 Jun 2012 10:28:55 -0700 (PDT)
Message-ID: <1339694935.87093.YahooMailNeo@web125203.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com> <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm28-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.158]:42996 "HELO
	nm28-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755962Ab2FNR24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 13:28:56 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9980CC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

An update:

*LAN9221 and GPMC off the hook?*

We've isolated the GPMC away from this I believe by disabling the LAN92=
21 in both our bootloaders and the kernel and by booting everything off=
 the SD cards only.=A0 By removing it's initialization code from the re=
spective board files, I *hope* we've basically removed it from contenti=
on.=A0 Obviously the chip is still wired up, but I don't expect the boo=
tloaders or kernel to be trying to talk to it.=A0 Likewise, the NAND is=
 being initialized, but we're not mouting or using it at all.

With these changes we're still seeing these crashes, albeit with the sa=
me incredible lack of frequency.

*EMAC now _partially_ on the hook?*
I posted a seperate thread on what I think may be a related subject, po=
tential Davinci EMAC problems, here:=A0 http://www.spinics.net/lists/li=
nux-omap/msg71833.html.

As you can see from the crashes posted there, there seems to be a bit o=
f whining from the EMAC driver.=A0 Since performance in the EMAC <=3D> =
EMAC case has always been questionable anyway, any chance there is a ti=
ny memory leak or something similar that could be contributing?

What about configuring this EMAC from within u-boot?=A0 Could that init=
ialization do something bad when we get into Linux?=A0 I've not touched=
 these drivers.=A0 I've simply called them like other boards in the fam=
ily are doing.

Just this morning, I upgraded to the latest linux-omap 3.5-rc2, but sti=
ll saw one of these crashes pretty quickly...

*Power stability?*

We're learning through all of this that our boards do appear to have so=
me funny transients running through the power circuits every so often.=A0=
 The ones we've captured on the scope have not caused crashes or hard l=
ockups, but they are there.=A0 This could be a dumb question, but could=
 power issues create a slab error like this???=A0 I guess I'm more accu=
stomed to seeing power issues result in more hard lock ups than a nicel=
y worded dump with the kernel sometimes still somewhat functioning.


Can anyone suggest to me anything I may not have tried to get more info=
rmation out of these crashes when they occur?

Thanks again to all!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
