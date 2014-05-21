From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [RFC PATCH 00/16] OMAP: GPMC: Restructure OMAP GPMC driver (NAND)
Date: Wed, 21 May 2014 13:08:18 -0300
Message-ID: <20140521160818.GA1150@arch.cereza>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, computersforpeace@gmail.com, pekon@ti.com, robertcnelson@gmail.com, jg1.han@samsung.com, dwmw2@infradead.org, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 21 May 02:20 PM, Roger Quadros wrote:
>=20
> For DT boot:
> - The GPMC controller node should have a chip select (CS) node for ea=
ch used
>   chip select. The CS node must have a child device node for each dev=
ice
>   attached to that chip select. Properties for that child are GPMC ag=
nostic.
>=20
>   i.e.
> 	gpmc {
> 		cs0 {
> 			nand0 {
> 			}
> 		};
>=20
> 		cs1 {
> 			nor0 {
> 			}
> 		}
> 		...
> 	};
>=20

While I agree that the GPMC driver is a bit messy, I'm not sure it's po=
ssible
to go through such a complete devicetree binding re-design (breaking ba=
ckwards
compatibility) now that the binding is already in production.

AFAIK, TI's SDK 7.0 is released, with a v3.8.x kernel which uses this G=
PMC
binding. And then you have the ISEE board too, using this binding.

Also, what's the problem with the current devicetree binding (not that =
I'm fan
of it)?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
