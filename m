From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 4/4] ARM: dts: AM33xx: updated default ECC scheme in
 nand-ecc-opt
Date: Thu, 26 Sep 2013 11:28:19 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA16D3D@DBDE04.ent.ti.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-5-git-send-email-pekon@ti.com>
 <20130925191559.GF23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130925191559.GF23337-bU/DPfM3abD4WzifrMjOTkcViWtcw2C0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rob Herring (robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org)" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Mark Rutland (mark.rutland-5wv7dgnIgG8@public.gmane.org)" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Brian Norris [mailto:computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> 
> On Thu, Sep 12, 2013 at 05:20:19PM +0530, Pekon Gupta wrote:
> > DT property values for OMAP based gpmc-nand have been updated
> > to match changes in commit:
> > 	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC
> schemes
> 
> Whose commit ID is this? Your patch is not merged yet, so don't use a
> commit ID.
> 
> > Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> >
> > Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/am335x-evm.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts
> b/arch/arm/boot/dts/am335x-evm.dts
> > index e8ec875..e28a2ac 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -268,7 +268,7 @@
> >  			nand@0,0 {
> >  				reg = <0 0 0>; /* CS0, offset 0 */
> >  				nand-bus-width = <8>;
> > -				ti,nand-ecc-opt = "bch8";
> > +				ti,nand-ecc-scheme = "bch8";
> >  				gpmc,device-nand = "true";
> >  				gpmc,device-width = <1>;
> >  				gpmc,sync-clk-ps = <0>;
> 
> This change should probably go in patch 1 anyway, when you break the
> ABI.
> 
As this patch series touches three different trees.. 
(1) arch/arm/boot/dts/..  maintained by Benoit Cousson (benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org)
(2) arch/arm/mach-omap2/.. maintained by Tony Lindgren (tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org)
(3) driver/mtd/nand/.. maintained by Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It was observed that there were conflicts usually during final merge,
Hence I separated out the patches.
However, if all are in sync and the series gets committed in above trees
simultaneously, then this conflicts can be avoided.
So, if Tony & Benoit are ok then I'll merge this [PATCH 4/4] in [PATCH 1/4].

with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
