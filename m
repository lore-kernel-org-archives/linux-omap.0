From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Thu, 29 Nov 2012 12:36:05 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
 <1354121939-11246-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354121939-11246-5-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 28, 2012 at 22:28:59, Daniel Mack wrote:
[...]
> +	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> +		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
> +			if (!strcasecmp(s, nand_ecc_opts[val])) {
> +				gpmc_nand_data->ecc_opt = val;
> +				break;
> +			}
> +
> +		/*
> +		 *  AM335x RBL compatibility mode - dependns on runtime
> +		 * detection of the error location module.
> +		 */
> +		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> +			gpmc_nand_data->is_elm_used = true;

Remove is_elm_used from struct omap_nand_platform_data. Now this data
populated as part of run time detection of elm module. So please remove
The usage of is_elm_used;

http://www.spinics.net/lists/arm-kernel/msg210549.html

Thanks
Avinash 
> 
