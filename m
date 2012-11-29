From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Thu, 29 Nov 2012 15:24:13 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA0BBA1@DBDE01.ent.ti.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
 <1354121939-11246-5-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com>
 <50B75806.8030501@gmail.com>
 <518397C60809E147AF5323E0420B992E3EA0BB4B@DBDE01.ent.ti.com>
 <50B77A28.8080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50B77A28.8080608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 29, 2012 at 20:37:20, Daniel Mack wrote:
> On 29.11.2012 15:59, Philip, Avinash wrote:
> > On Thu, Nov 29, 2012 at 18:11:42, Daniel Mack wrote:
> >> On 29.11.2012 13:36, Philip, Avinash wrote:
> >>> On Wed, Nov 28, 2012 at 22:28:59, Daniel Mack wrote:
> >>> [...]
> >>>> +	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> >>>> +		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
> >>>> +			if (!strcasecmp(s, nand_ecc_opts[val])) {
> >>>> +				gpmc_nand_data->ecc_opt = val;
> >>>> +				break;
> >>>> +			}
> >>>> +
> >>>> +		/*
> >>>> +		 *  AM335x RBL compatibility mode - dependns on runtime
> >>>> +		 * detection of the error location module.
> >>>> +		 */
> >>>> +		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
> >>>> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> >>>> +			gpmc_nand_data->is_elm_used = true;
> >>>
> >>> Remove is_elm_used from struct omap_nand_platform_data. Now this data
> >>> populated as part of run time detection of elm module. So please remove
> >>> The usage of is_elm_used;
> >>
> >> So why do we need "bch8-am335xrbl-compatible" as special case then?
> >>
> >> I thought the whole idea here is to tell the driver we want bch8 *and*
> >> the usage of the elm, instead of falling back to the (incompatible)
> >> software mode? If I remove that assignment, "bch8-am335xrbl-compatible"
> >> is the same than "bch8".
> >>
> > 
> > Here we have different problems present. 
> > 1. GPMC-NAND DT binding support.
> > 2. Compatible ECC layout between kernel, boot loader.
> > 3. Support for hardware accelerator, i.e ELM for error correction.
> > 
> > So priority should go for GPMC DT binding support. 
> > Can you please proceed with GPMC-NAND DT bindings without considering
> > ELM so that driver features existing can be obtained with DT.
> > 
> > I will take care of ECC layout (or RBL) compatibility along with ELM
> > series. I will make ELM series on top of your changes. This way we can
> > avoid circular dependency
> 
> Ok, fair enough. I'll drop "bch8-am335xrbl-compatible" from the list
> again and only care for those that are present in the enum.
> 
> Before I send the patches again, could you quickly state which
> repository they will go through? I'll make sure there are no conflicts
> when applying.

I believe it should go through the OMAP trees.

Thanks
Avinash

> 
> >> Which detail am I missing? :)
> > 
> > I think what you need is NAND ECC layout to be common across Kernel and
> > boot loader. Strictly speaking ELM is not a necessity for it. The common
> > layout can be obtained even without presence of ELM, ELM is only a hardware
> > accelerator for error correction. If ELM is not used, we can rely on software
> > error correction, at least theoretically. But the way software error correction
> > is handled currently in omap nand driver will not help us as ecc layout assumed
> > is different.
> 
> Yes, understood, hence I need some workaround for now, which I can
> happily keep in my local branch.
> 
> 
> Thanks,
> Daniel
> 
> 
