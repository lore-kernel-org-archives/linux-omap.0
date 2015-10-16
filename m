From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Fri, 16 Oct 2015 14:25:10 -0700
Message-ID: <20151016212510.GF24370@atomide.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com>
 <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com>
 <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com>
 <5613A256.8000105@ti.com>
 <20151006110134.GO23801@atomide.com>
 <5613ABEF.9000904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5613ABEF.9000904@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [151006 04:13]:
>=20
> Fine. The updated series is now at
>=20
> git@github.com:rogerq/linux.git
>  * [new branch]      for-v4.4/gpmc-v4

Looks like it produces some build errors, this with RMKs 3430 and 4430
only .configs:

drivers/memory/omap-gpmc.c:2035:43: error: =E2=80=98struct gpio_chip=E2=
=80=99 has no
member named =E2=80=98irqdomain=E2=80=99
drivers/memory/omap-gpmc.c:2116:8: error: implicit declaration of
function =E2=80=98gpiochip_irqchip_add=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]

Maybe run randconfig builds on it for overnight?

Other than that your series seems to behave for me now, so feel
free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
