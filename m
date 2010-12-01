From: Srinidhi Kasagar <srinidhikasagar@gmail.com>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
Date: Wed, 1 Dec 2010 11:51:42 +0530
Message-ID: <AANLkTi=WHBqq5U8OzkMaprk=vzphZBV0HhLEDF-uAZxW@mail.gmail.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
	<20101130233204.GB14383@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20101130233204.GB14383@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Jamie Iles <jamie.iles@picochip.com>, Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 1, 2010 at 5:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 08:16:58PM +0300, Anton Vorontsov wrote:

[...]

>> + =A0 =A0 sub =A0 =A0 r4, r4, r5
>> + =A0 =A0 add =A0 =A0 r6, r6, r4
>> +#if __LINUX_ARM_ARCH__ >=3D 7
>> + =A0 =A0 dsb
>> +#endif
>
> Another question though - probably for Linus though - why is the u850=
0
> code needing this dsb whereas other ARMv7 implementations don't appea=
r
> to require it?

No strong reason, we can safely ignore this now.

srinidhi
