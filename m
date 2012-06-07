From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Thu, 7 Jun 2012 12:50:13 -0700 (PDT)
Message-ID: <1339098613.84700.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm32-vm3.bullet.mail.ne1.yahoo.com ([98.138.229.51]:47085 "HELO
	nm32-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753015Ab2FGTuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 15:50:14 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E995E3B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Afzal,

Thanks for the suggestion.=A0 This is something I was actually looking =
at just the other day.=A0 I contemplated changing it, but have not done=
 so yet.=A0 I left it alone because I believe the folks that did all th=
e core OMAP35x and LAN9221 timing and driver work knew way more than I =
about all this.=A0 Now, if there is a difference between the way the OM=
AP35x is clocked or setup and the way my AM35x is clocked or setup, the=
n I would expect these values to change.=A0 So far however, I've not se=
en a difference, and I have not seen anyone else trying to wire up a 92=
21 to an AM35xx.=A0 This confuses me.=A0 Is the AM35xx not capable of s=
upporting a 9221's timings for some reason?=A0 If it can support it, wh=
y would it seem everyone is still using the slower 9220?=A0 Even the TI=
 reference materials suggest the LAN9220, http://processors.wiki.ti.com=
/index.php./Ethernet_Connectivity_via_GPMC.


I've had a thread (http://e2e.ti.com/support/dsp/sitara_arm174_micropro=
cessors/f/416/p/172157/690750.aspx) sitting over at the TI E2E forums f=
or a while now on this subject of GPMC, OMAP35x vs. AM35x, and the LAN9=
221.=A0 So far, I've not received any feedback.=A0 :-(

Thanks for your thoughts!=A0 I may try fiddling a bit just to see if th=
at helps.



----- Original Message -----
=46rom: "Mohammed, Afzal" <afzal@ti.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>; Tony Lin=
dgren <tony@atomide.com>; "Shilimkar, Santosh" <santosh.shilimkar@ti.co=
m>
Sent: Thursday, June 7, 2012 5:32 AM
Subject: RE: Please help! AM35xx mm/slab.c BUG

Hi "",

On Wed, Jun 06, 2012 at 13:21:23, CF Adad wrote:

> Thanks again.=A0 I'm really starting to think the GPMC almost has to =
be contributing.

Does adding cycle2cycle delay / bus turnaround prevent the issue ?,

SMSC datasheet mentions about special restrictions on back to back read
and write-read, reading BYTE_TEST should take care of it, not sure whet=
her
driver takes care of all scenarios as per datasheet.

Perhaps cycle2cycledelay would help us achieve it if driver doesn't
take care of it.

Regards
Afzal

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
