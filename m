From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 1/3] mtd: nand: omap2: Update nerrors using ecc.strength
Date: Mon, 10 Dec 2012 06:44:02 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA1FA1B@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-2-git-send-email-avinashphilip@ti.com>
 <50BF3819.9010200@ti.com>
 <518397C60809E147AF5323E0420B992E3EA1139B@DBDE01.ent.ti.com>
 <50C1C784.4040209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50C1C784.4040209-l0cyMroinI0@public.gmane.org>
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
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 07, 2012 at 16:10:04, Nori, Sekhar wrote:
> On 12/5/2012 6:13 PM, Philip, Avinash wrote:
> > On Wed, Dec 05, 2012 at 17:33:37, Nori, Sekhar wrote:
> >> Hi Avinash,
> >>
> >> On 11/29/2012 5:16 PM, Philip, Avinash wrote:
> >>> Update number of errors using nand ecc strength.
> >>> Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX
> >>
> >> Can you please describe why the original method of setting nerrors was
> >> incorrect? Was it causing any issues in any particular configuration?
> > 
> > It affects the reusability of the code. For example BCH8 with AM335x RBL 
> > compatibility requires  14 bytes instead of 13 byte. So setting nerrors
> > with
> > 	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
> > will break am335x RBL compatibility.
> 
> This should be summarized in the patch description so the motivation is
> clear to those who read the history later.

Ok I will add the details in patch description in next version.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
