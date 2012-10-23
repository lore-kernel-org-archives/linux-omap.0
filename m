From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP2: gpmc: Add support for BCH ECC scheme
Date: Tue, 23 Oct 2012 10:18:02 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9D29C8@DBDE01.ent.ti.com>
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
	<1349274589-11389-4-git-send-email-avinashphilip@ti.com>
 <87vcebvaf5.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87vcebvaf5.fsf@macbook.be.48ers.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 16, 2012 at 00:18:30, Peter Korsgaard wrote:
> >>>>> Philip, Avinash <avinashphilip@ti.com> writes:
> 
>  > Add support for BCH ECC scheme to gpmc driver and also enabling multi
>  > sector read/write. This helps in doing single shot NAND page read and
>  > write.
> 
>  > ECC engine configurations
>  > BCH 4 bit support
>  > 1. write => ECC engine configured in wrap mode 6 and with ecc_size0 as 32.
>  > 2. read  => ECC engine configured in wrap mode 1 and with ecc_size0 as
>  > 13 and ecc_size1 as 1.
> 
>  > BCH 8 bit support
>  > 1. write => ECC engine configured in wrap mode 6 and with ecc_size0 as 32.
>  > 2. read  => ECC engine configured in wrap mode 1 and with ecc_size0 as
>  > 26 and ecc_size1 as 2.
> 
>  > Note: For BCH8 ECC bytes set to 14 to make compatible with RBL.
> 
> On what device? In the am335x TRM (spruh73f.pdf) figure 26-15 (pg 4273)
> the rom code is documented to not use any padding on the ECC bytes
> (E.G. oob 2..53):
> 
> http://www.ti.com/litv/pdf/spruh73f
> 
> I see the driver in the u-boot-am33x tree (ti81xx_nand.c) seems to use
> 4x14 bytes as well though, so perhaps that's a bug in the documentation
> instead?

Yes, RBL uses 4x14 bytes.

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> 
