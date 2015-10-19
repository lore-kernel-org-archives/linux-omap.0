From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 19 Oct 2015 10:08:11 +0300
Message-ID: <562496DB.4050803@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com> <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com> <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com> <5613A256.8000105@ti.com>
 <20151006110134.GO23801@atomide.com> <5613ABEF.9000904@ti.com>
 <20151016212510.GF24370@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151016212510.GF24370-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 17/10/15 00:25, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151006 04:13]:
>>
>> Fine. The updated series is now at
>>
>> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git
>>  * [new branch]      for-v4.4/gpmc-v4
>=20
> Looks like it produces some build errors, this with RMKs 3430 and 443=
0
> only .configs:
>=20
> drivers/memory/omap-gpmc.c:2035:43: error: =E2=80=98struct gpio_chip=E2=
=80=99 has no
> member named =E2=80=98irqdomain=E2=80=99
> drivers/memory/omap-gpmc.c:2116:8: error: implicit declaration of
> function =E2=80=98gpiochip_irqchip_add=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
>=20

Good catch. We'll have to select GPIOLIB_IRQCHIP for this driver.

> Maybe run randconfig builds on it for overnight?

OK. I'll do that.

>=20
> Other than that your series seems to behave for me now, so feel
> free to add:
>=20
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Thanks for the tests :)

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
