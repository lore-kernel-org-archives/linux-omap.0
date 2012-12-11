From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 2/3] mtd: devices: elm: Add support for ELM error
 correction
Date: Tue, 11 Dec 2012 12:55:21 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA285C0@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-3-git-send-email-avinashphilip@ti.com>
 <20121211090356.8D3D93E076D@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121211090356.8D3D93E076D@localhost>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 11, 2012 at 14:33:56, Grant Likely wrote:
> On Thu, 29 Nov 2012 17:16:33 +0530, "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org> wrote:
> > The ELM hardware module can be used to speedup BCH 4/8/16 ECC scheme
> > error correction.
> > For now only 4 & 8 bit support is added
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
> > ---
> > Changes since v2:
> > 	- Remove __devinit & __devexit annotations
> > 
> > Changes since v1:
> > 	- Change build attribute to CONFIG_MTD_NAND_OMAP_BCH
> > 	- Reduced indentation using by passing elm_info , offset
> > 	  to elm_read & elm_write
> > 	- Removed syndrome manipulation functions.
> > 
> > :000000 100644 0000000... b88ee83... A	Documentation/devicetree/bindings/mtd/elm.txt
> > :100644 100644 395733a... 369a194... M	drivers/mtd/devices/Makefile
> > :000000 100644 0000000... d2667f3... A	drivers/mtd/devices/elm.c
> > :000000 100644 0000000... d4fce31... A	include/linux/platform_data/elm.h
> >  Documentation/devicetree/bindings/mtd/elm.txt |   17 +
> >  drivers/mtd/devices/Makefile                  |    4 +-
> >  drivers/mtd/devices/elm.c                     |  418 +++++++++++++++++++++++++
> >  include/linux/platform_data/elm.h             |   54 ++++
> >  4 files changed, 493 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
> > new file mode 100644
> > index 0000000..b88ee83
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/elm.txt
> > @@ -0,0 +1,17 @@
> > +Error location module
> > +
> > +Required properties:
> > +- compatible: Must be "ti,elm"
> 
> Compatible string is too generic. Need to specify a specific SoC here.
> ie: "ti,omap3430-elm"

I will change to "ti,am33xx-elm" in next version.

Thanks
Avinash


> 
> Otherwise the binding looks fine. I haven't reviewed the code though.
> 
> g.
> 
> 
