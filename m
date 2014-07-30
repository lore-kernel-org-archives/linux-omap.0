From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: ti: clk-7xx: Correct ABE DPLL configuration
Date: Wed, 30 Jul 2014 08:53:46 +0300
Message-ID: <53D8886A.5020600@ti.com>
References: <1396446525-20302-1-git-send-email-peter.ujfalusi@ti.com> <533C1AC2.1000307@ti.com> <533CFFB3.9070201@ti.com> <5358D534.2070205@ti.com> <535927DF.90404@ti.com> <5368E604.4040107@ti.com> <53C3AC94.5050904@ti.com> <20140729062748.4906.1529@quantum> <53D759E6.3060607@ti.com> <CAPtuhTjMAZcHecO0dr+3zDurCfQH32pmYUQ+zNXhRdS_+vJZsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPtuhTjMAZcHecO0dr+3zDurCfQH32pmYUQ+zNXhRdS_+vJZsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 07/29/2014 07:12 PM, Mike Turquette wrote:
>> Oh yea, seems this got lost into the myriad of branches I have. I ca=
n push
>> this on top of my for-v3.17/ti-clk-drv if you like.
>=20
> That is the easiest thing for me. I think that Peter wanted to take
> this as a fix for 3.16 though. Peter is that correct?

Yes, it would have been better to have it in 3.16 along with the DRA7 A=
TL
clock driver. W/O this patch the ATL will not going to be usable since =
the ABE
DPLL is set too high to be usable for it's purpose.

--=20
P=C3=A9ter
