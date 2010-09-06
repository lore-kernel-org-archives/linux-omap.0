From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
Date: Mon, 6 Sep 2010 21:42:41 +0200
Message-ID: <AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
	<AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
	<20100906120716.GE20903@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20100906120716.GE20903@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roger Quadros <roger.quadros@nokia.com>, Ido Yariv <ido@wizery.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

W dniu 6 wrze=B6nia 2010 14:07 u=BFytkownik Russell King - ARM Linux
<linux@arm.linux.org.uk> napisa=B3:
> On Sat, Sep 04, 2010 at 02:23:19PM +0200, Micha=B3 Miros=B3aw wrote:
>> 2010/9/1 Ohad Ben-Cohen <ohad@wizery.com>:
>> > Add a simple mechanism to pass platform data to the
>> > SDIO instances of wl12xx.
[cut patch]
>> Why do you need all that copying? Isn't the data constant?
>
> The first copy is to allow platforms to have their data marked with
> __initdata. =A0The second copy probably isn't necessary, but avoids
> problems where the driver may decide to modify the platform data.

Sorry for pushing at this, but why would you mark data that's meant to
be used after init phase as __initdata?

Best Regards,
Micha=B3 Miros=B3aw
