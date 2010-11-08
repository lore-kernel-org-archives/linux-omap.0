From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH] arm: fix compilation warning during compilation
Date: Mon, 8 Nov 2010 12:59:06 +0100
Message-ID: <AANLkTinmQtrLJcjxRSwbHARrgE-4FEaJeDt4R8C2tLHY@mail.gmail.com>
References: <4CD51A9B.7010806@gmail.com>
	<20101108091302.GO16938@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101108091302.GO16938@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

2010/11/8 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Sat, Nov 06, 2010 at 10:06:35AM +0100, Marco Stornelli wrote:
>> From: Marco Stornelli <marco.stornelli@gmail.com>
>>
>> During compilation of 2.6.36 for Beagle board, there a are a couple =
of warnings. This patch fix them.
> Please break lines for commit logs at around 76 chars and mention the
> exact compiler warning being fixed.
>

My compiler version is gcc 4.4.1. Two warning: variable gpio_mux may
be used not initialized (false positive, I agree); second: compiler
fix the void lack in the inline function with an int. Obviously there
is a lack of return type that it must be void.

Regards,

Marco
