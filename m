From: CF Adad <cfadad@rocketmail.com>
Subject: "Broken" McBSP1 on AM3517?
Date: Mon, 16 Jul 2012 10:56:33 -0700 (PDT)
Message-ID: <1342461393.69195.YahooMailNeo@web125205.mail.ne1.yahoo.com>
References: <1341961350.32611.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1342459273.74158.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm23-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.183]:24692 "HELO
	nm23-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752658Ab2GPR7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 13:59:17 -0400
In-Reply-To: <1342459273.74158.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've tried getting this to the alsa-devel list, but have been a bit sty=
mied.=A0 Perhaps it would be relevant here too since this is directly r=
elated to the OMAP world.=A0 As noted below, I suspect that recent chan=
ges from March in the handling of McBSP1 (6-wire interface) on the omap=
2/3 are what is causing me issues.=A0 However, I've yet to figure out h=
ow to correct it on my platform.=A0 Is detection of AM35xx perhaps part=
 of my issue here?


----- Forwarded Message -----

All,

Over the past several months, we have been successfully interfacing wit=
h multiple digital audio devices using McBSPs 2, 3, and 4 on an AM3517 =
processor using a basic, custom digital audio driver.=A0 (What we're us=
ing now is just a newer vesion of to what we shared back in February: h=
ttp://www.mail-archive.com/linux-omap@vger.kernel.org/msg63844.html.)=A0=
 Recently we've had an opportunity to try to use McBSP1 as well.=A0 So,=
 I followed our standard formula, added it to our driver and started tr=
ying to use it.=A0 What I'm seeing is that my transmit side functions r=
easonably, but my receive side does not.=A0 I have put an o-scope on it=
, and I can see data coming back along the receive data line.=A0 So I k=
now there is stuff there.=A0 However, I cannot arecord it.=A0 I've chec=
ked my pinmux in u-boot, and:

=A0=A0=A0 MUX_VAL(CP(MCBSP1_CLKR),=A0=A0=A0 (IEN=A0 | PTD | DIS | M0)) =
\
=A0=A0=A0 MUX_VAL(CP(MCBSP1_FSR),=A0=A0=A0 =A0=A0=A0 (IEN=A0 | PTU | DI=
S | M0)) \
=A0=A0=A0 MUX_VAL(CP(MCBSP1_DX),=A0=A0=A0 =A0=A0=A0 (IDIS | PTD | DIS |=
 M0)) \
=A0=A0=A0 MUX_VAL(CP(MCBSP1_DR),=A0=A0=A0 =A0=A0=A0 (IEN=A0 | PTD | DIS=
 | M0)) \
=A0=A0=A0 MUX_VAL(CP(MCBSP1_FSX),=A0=A0=A0 =A0=A0=A0 (IEN=A0 | PTD | DI=
S | M0)) \
=A0=A0=A0 MUX_VAL(CP(MCBSP1_CLKX),=A0=A0=A0 (IEN=A0 | PTD | DIS | M0)) =
\

Since I'm not changing anything in the pinmux in Linux, that should be =
good.

We are using a very recent linux-omap kernel (3.5.0-rc4), and I'm 99.99=
99% sure the issue is something simple, likely from the recently patche=
d up omap-mcbsp/mcbsp driver(s).=A0 Our connection is 4-wire only, and =
I suspect I'm stuck in 6-wire mode.=A0 Historically, folks were instruc=
ted to insert the following into their drivers to switch McBSP1 to 4-wi=
re config (http://mailman.alsa-project.org/pipermail/alsa-devel/2009-Au=
gust/020771.html):


-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------

=A0=A0=A0 /* set cpu CLKR & FSR as inputs (unused) */
=A0=A0=A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_C=
LKX, 0,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_CLOCK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set CPU system clock OMAP_MC=
BSP_CLKR_SRC_CLKX\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }

=A0=A0=A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FS=
X, 0,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SND_SOC_CLOCK_IN);
=A0=A0=A0 if (ret < 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't set CPU system clock OMAP_MC=
BSP_FSR_SRC_FSX\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }


-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------
However, when I enable that code now, I now get ret < 0 and the error m=
essages.

I suspect all this has to do with the patches from March of this year, =
as it appears several changes were incorporated recently to this.=A0 My=
 problem is I cannot figure out what I'm missing.=A0 Digging through th=
e code, it looks to me like I should still be able to make this call.=A0=
 However, it fails.=A0 If things have changed, what is the new procedur=
e for using McBSP1 on an AM35xx in a 4-pin config?=A0 My driver matches=
 very closely to the sound/soc/omap/am3517evm.c at least in this compon=
ent.=A0 I notice that it has not been altered.=A0 Is that a "bug", or d=
oes it work fine over there?

Any ideas on how to "fix" this, presuming this is the problem I'm havin=
g with my record path?

Thanks!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
