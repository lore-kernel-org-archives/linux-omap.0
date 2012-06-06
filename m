From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 6 Jun 2012 00:51:23 -0700 (PDT)
Message-ID: <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm15.bullet.mail.ne1.yahoo.com ([98.138.90.78]:25149 "HELO
	nm15.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751472Ab2FFHvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 03:51:24 -0400
In-Reply-To: <20120606071024.GP12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

Thanks again.=A0 I'm really starting to think the GPMC almost has to be=
 contributing.=A0 In our setup, we have 2 separate versions of a basebo=
ard for the TAM.=A0 One version has the LAN9221 as a secondary Ethernet=
, while the other does not.=A0 Otherwise, they're basically the same.=A0=
 I can run the same code on both.=A0 It seems from our testing that the=
 vast majority of the crashes occur on the module with the LAN9221. Eve=
n with the SMSC just idle, it seems the one with that extra port is mos=
t likely to fail.


As I mentioned previously, I'm far from a GPMC expert.=A0 I posted a th=
read to the TI E2E forums asking them for comments on my LAN9221 GPMC s=
ettings (http://e2e.ti.com/support/dsp/sitara_arm174_microprocessors/f/=
416/p/172157/690750.aspx#690750). I began to question what I had after =
some Google searches pulled up other patches which showed disparities b=
etween what I'm using and what others are using.


Do you folks know of a good reference for properly calculating these GP=
MC settings?=A0 When I did the EMIF4 stuff, I was very pleased to find =
TI had a great set of resources online (http://processors.wiki.ti.com/i=
ndex.php/Setting_up_AM35x_SDRC_registers), including an Excel spreadshe=
et that helped generate the register values for me.=A0 I've found the f=
ollowing links on the GPMC, but have not been nearly as impressed as I =
was with the information on the EMIF4:
http://processors.wiki.ti.com/index.php/AM3517/05_GPMC_Subsystem

http://processors.wiki.ti.com/index.php/Ethernet_Connectivity_via_GPMC

http://e2e.ti.com/support/dsp/sitara_arm174_microprocessors/f/416/t/493=
94.aspx


The only other thing I know I have on the GPMC is the NAND flash, and i=
t is taking the default settings along with several other boards in the=
 AM35xx family (<x-loader>/include/asm/arch-omap3/mem.h):
/* for L3 =3D 165MHz & 16-bit NAND */
# define M_NAND_GPMC_CONFIG1 0x00001800
# define M_NAND_GPMC_CONFIG2 0x00080800
# define M_NAND_GPMC_CONFIG3 0x00080800
# define M_NAND_GPMC_CONFIG4 0x06000600
# define M_NAND_GPMC_CONFIG5 0x00070808
# define M_NAND_GPMC_CONFIG6 0x000003cf
# define M_NAND_GPMC_CONFIG7 0x00000848

Any thoughts on that?

Thanks again.=A0 Your help is *greatly* appreciated.



----- Original Message -----
=46rom: Tony Lindgren <tony@atomide.com>
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: CF Adad <cfadad@rocketmail.com>; "linux-omap@vger.kernel.org" <linu=
x-omap@vger.kernel.org>
Sent: Wednesday, June 6, 2012 3:10 AM
Subject: Re: Please help! AM35xx mm/slab.c BUG

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120605 23:41]:
>=20
> I don't know the AMXX architecture that well but looking at the
> crash-log, am not sure GPMC should play in role here.
> What I think is, it is mostly memory corruption and can be caused by
> many reasons as Tony outlined.

Bad GPMC timings can cause corruption on the smsc fifo, which can
cause random oopses especially with nfsroot.

I was seeing that on my zoom3 with nfsroot with bad muxing for GPMC
until we applied bce492c0 (ARM: OMAP2+: UART: Fix incorrect population =
of
default uart pads). That's easy to test by leaving out GPMC.

> To ensure that, your memory is in good state, can you run memtester
> for long duration and see that you
> are not getting any memory failures. Try to give the maximum memory
> size as a an input to memtester.

Yes and that should be left running for a few weeks on a group of
devices to verify things work once you think you have all the issues
fixed.

Regards,

Tony


> You can download one from [1]
>=20
> Regards
> Santosh
> [1] http://pyropus.ca/software/memtester/

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
