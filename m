From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] pwm: Remove pwm-twl6030 driver
Date: Mon, 26 Nov 2012 10:11:46 +0100
Message-ID: <50B33252.3060709@ti.com>
References: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com> <1353405382-9226-2-git-send-email-peter.ujfalusi@ti.com> <20121123150548.GC16810@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123150548.GC16810@avionic-0098.adnet.avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 11/23/2012 04:05 PM, Thierry Reding wrote:
> On Tue, Nov 20, 2012 at 10:56:20AM +0100, Peter Ujfalusi wrote:
>> This driver only supported the Charging indicator LED.
>> New set of drivers going to provide support for both PWMs and LEDs f=
or twl4030
>> and twl6030 series of PMICs.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/pwm/Kconfig       |   9 ---
>>  drivers/pwm/Makefile      |   1 -
>>  drivers/pwm/pwm-twl6030.c | 184 -----------------------------------=
-----------
>>  3 files changed, 194 deletions(-)
>>  delete mode 100644 drivers/pwm/pwm-twl6030.c
>=20
> I think I'd rather see this patch as the last in the series to make s=
ure
> that no functionality is dropped across the series.

Sure, I will move it as a last patch.

--=20
P=E9ter
