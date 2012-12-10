From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 2/3] mtd: devices: elm: Add support for ELM error
 correction
Date: Mon, 10 Dec 2012 06:43:17 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA1FA14@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-3-git-send-email-avinashphilip@ti.com>
 <50C1C6E3.5020300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50C1C6E3.5020300-l0cyMroinI0@public.gmane.org>
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
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 07, 2012 at 16:07:23, Nori, Sekhar wrote:
> On 11/29/2012 5:16 PM, Philip, Avinash wrote:
> > The ELM hardware module can be used to speedup BCH 4/8/16 ECC scheme
> > error correction.
> > For now only 4 & 8 bit support is added
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>

[...]
/**
> > + * elm_config - Configure ELM module
> > + * @info:	elm info
> > + */
> > +static void elm_config(struct elm_info *info)
> 
> This is called "config", but there is no configuration information
> passed which looks odd..

The config information is bch_type, encapsulated in struct elm_info.

> 
> > +{
> > +	u32 reg_val;
> > +
> > +	reg_val = (info->bch_type & ECC_BCH_LEVEL_MASK) | (ELM_ECC_SIZE << 16);
> > +	elm_write_reg(info, ELM_LOCATION_CONFIG, reg_val);
> > +}
> 
> Is there a use case where BCH type needs to be changed after NAND has
> been probed?

No, I think kernel handles the entire NAND part with a single ecc layout.
Hence there is no run time BCH switching. But ELM driver should support BCH
4 & 8. Selection of BCH information comes from DT of NAND driver.

As NAND driver supporting BCH4 & 8 ecc scheme ELM module support
configuration of both.  Configuration of ELM module should done as part
of NAND driver probing.


> You will have to erase any existing data written to NAND if
> you change the ECC type. That sounds destructive enough to avoid such a
> thing.

There is no support for BCH switching after NAND driver probing.

[...]
> > +struct device *elm_request(enum bch_ecc bch_type)
> > +{
> > +	struct elm_info *info;
> > +
> > +	list_for_each_entry(info, &elm_devices, list) {
> > +		if (info && info->dev) {
> > +				info->bch_type = bch_type;
> > +				elm_config(info);
> > +				return info->dev;
> > +		}
> > +	}
> 
> This will always return the first ELM device probed since you never
> remove the allocated device from the list.

But now I realized that, there is no mechanism of freeing the requested
resource.

So I will add mechanism to request ELM module successfully only if ELM
module is not requested already and add mechanism to free it, on NAND
driver module unload (loadable module support). This way ELM driver
can achieve multi instance support.

> I wonder why you really need a list?

The prime motivation for the list is the driver should support multi
instances of ELM by removing global symbols.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
