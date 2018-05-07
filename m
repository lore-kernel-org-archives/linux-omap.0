From: "Reizer, Eyal" <eyalr@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
 support
Date: Mon, 7 May 2018 06:55:03 +0000
Message-ID: <a4dd3009f0f5492d8756f42c11590423@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <20180502145100.GK98604@atomide.com>
 <5cc906da15da45ab96e06957f878b65b@ti.com>
 <20180503141759.GP98604@atomide.com>
 <f0ea5260b3e2413aab4780b203ff24a4@ti.com>
 <20180506165621.GL98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180506165621.GL98604@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eyal Reizer <eyalreizer@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loewy, Chen" <c-loewy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>=20
> Yeah my guess is that the reason for the separate GPIO interrupt was
> that on omap3 we did not have SDIO interrupt working for years. This was
> because of the issues related to padconf interrupts for off mode.
>=20
> We now have Linux generic wakeirq support working with SDIO and it has
> been confirmed to work also for off mode with mwifiex at least. So
> there should be no reason to not also use the SDIO interrupt.
>=20

There is more to this than just the padconf.
Using in-band interrupt instead of the out of band one requires
Supporting a feature called "Asynchronous interrupts in 4Bit mode"
Which is part of SDIO 3.0 spec:
https://www.sdcard.org/downloads/pls/pdf/index.php?p=3DPartE1_SDIO_Simplifi=
ed_Specification_Ver3.00.jpg&f=3DPartE1_SDIO_Simplified_Specification_Ver3.=
00.pdf&e=3DEN_SSE1

Take a look at page 41 at the bottom part of the table.
Wilink8 supports this feature but AFAIK this support is still not part of t=
he=20
mmc/sdio core in the Linux kernel.
If we want wilink8 to trigger a host wakeup using the in-band interrupt ins=
tead=20
Of the wlan_irq pin we would need to enable/use this feature.

I did use it internally in the past and was able to patch the Ubuntu kernel=
=20
(3.5.0 at that time) to use wilink8 in a standard SD Card slot of an Ubuntu=
 Laptop=20
while removing the use of wlan_irq pin completely.
However this was an experimental patch set written by a third party=20
that was not up-steamtable at that time.
I do have this patch set somewhere...

It is similar to the following patch which is not  upstream as well for som=
e reason:
https://gitlab.com/k2wl/g2_kernel/commit/5c4970fdaa50422d7ea7220efa20fb3514=
8a4bca
It is not the only patch needed, there are a couple of additional patches n=
eeded=20
for fully using it from driver.
I did check latest Linux-next and don't see this support there. Not sure wh=
y.

Best Regards,
Eyal
