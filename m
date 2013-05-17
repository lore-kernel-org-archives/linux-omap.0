From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP5: select SCU
Date: Fri, 17 May 2013 07:16:23 +0000
Message-ID: <448912EABC71F84BBCADFD3C67C4BE527C6D42@DBDE04.ent.ti.com>
References: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net>
 <51938169.4060109@ti.com> <5194DAC5.9080203@ti.com>,<5194ED33.7050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5194ED33.7050502@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Stehle, Vincent" <v-stehle@ti.com>
Cc: =?iso-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@laposte.net>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Sorry for top posting. Can you just add static inlines functions in hea=
der file and #ifdef it for OMAP5.

Regards,
Santosh
________________________________________
=46rom: Stehle, Vincent
Sent: Thursday, May 16, 2013 7:59 PM
To: Shilimkar, Santosh
Cc: Vincent Stehl=E9; Tony Lindgren; linux-omap@vger.kernel.org; linux-=
kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP5: select SCU

So the exact commit breaking OMAP5 link for me is:

  883a106 ARM: default machine descriptor for multiplatform

The breakage seems to be a side effect of not selecting ARCH_VEXPRESS
any more, which causes HAVE_ARM_SCU to not be selected any more, too,
when compiling only for OMAP5. IMHO this only reveals a deeper issue.

Probably the ideal fix would be to remove all references to the scu_
functions for OMAP5, but those seem to exist in files and functions,
common to OMAP4 and 5 (sleep44xx.S, omap-smp.c).

How would you deal with that, please?

Best regards,

V.
