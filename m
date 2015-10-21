From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 21 Oct 2015 11:31:37 +0300
Message-ID: <56274D69.1090402@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com> <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com> <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com> <5613A256.8000105@ti.com>
 <20151006110134.GO23801@atomide.com> <5613ABEF.9000904@ti.com>
 <20151016212510.GF24370@atomide.com> <562496DB.4050803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562496DB.4050803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com
List-Id: linux-omap@vger.kernel.org

On 19/10/15 10:08, Roger Quadros wrote:
> On 17/10/15 00:25, Tony Lindgren wrote:
>> * Roger Quadros <rogerq@ti.com> [151006 04:13]:
>>>
>>> Fine. The updated series is now at
>>>
>>> git@github.com:rogerq/linux.git
>>>  * [new branch]      for-v4.4/gpmc-v4
>>
>> Looks like it produces some build errors, this with RMKs 3430 and 44=
30
>> only .configs:
>>
>> drivers/memory/omap-gpmc.c:2035:43: error: =E2=80=98struct gpio_chip=
=E2=80=99 has no
>> member named =E2=80=98irqdomain=E2=80=99
>> drivers/memory/omap-gpmc.c:2116:8: error: implicit declaration of
>> function =E2=80=98gpiochip_irqchip_add=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>>
>=20
> Good catch. We'll have to select GPIOLIB_IRQCHIP for this driver.
>=20
>> Maybe run randconfig builds on it for overnight?
>=20
> OK. I'll do that.

I couldn't run randconfig beyond few iterations as it keeps failing
everywhere. How do we limit the randconfig options to OMAP only
platforms?

cheers,
-roger
