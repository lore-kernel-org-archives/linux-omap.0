From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 07 Nov 2012 10:48:37 +0100
Message-ID: <509A2E75.5060307@gmail.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-5-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
 <5097B7EE.3000508@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9DC1F1-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05.11.2012 14:29, Philip, Avinash wrote:
> On Mon, Nov 05, 2012 at 18:28:22, Daniel Mack wrote:
>> On 05.11.2012 12:03, Philip, Avinash wrote:
>>> On Fri, Nov 02, 2012 at 20:55:56, Daniel Mack wrote:
>>>> This patch adds basic DT bindings for OMAP GPMC.
>>>>
>>>> The actual peripherals are instanciated from child nodes within the GPMC
>>>> node, and the only type of device that is currently supported is NAND.
>>>>
>>>> Code was added to parse the generic GPMC timing parameters and some
>>>> documentation with examples on how to use them.
>>>>
>>>> Successfully tested on an AM33xx board.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> [...]
>>>> +
>>>> +		nand@0,0 {
>>>> +			reg = <0 0 0>; /* CS0, offset 0 */
>>>> +			nand-bus-width = <16>;
>>>> +			nand-ecc-mode = "none";
>>>> +
>>>> +			gpmc,sync-clk = <0>;
>>>> +			gpmc,cs-on = <0>;
>>>> +			gpmc,cs-rd-off = <36>;
>>>> +			gpmc,cs-wr-off = <36>;
>>>> +			gpmc,adv-on = <6>;
>>>> +			gpmc,adv-rd-off = <24>;
>>>> +			gpmc,adv-wr-off = <36>;
>>>> +			gpmc,we-off = <30>;
>>>> +			gpmc,oe-off = <48>;
>>>> +			gpmc,access = <54>;
>>>> +			gpmc,rd-cycle = <72>;
>>>> +			gpmc,wr-cycle = <72>;
>>>> +			gpmc,wr-access = <30>;
>>>> +			gpmc,wr-data-mux-bus = <0>;
>>>> +
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +
>>>
>>> Can you take the timings (for example) from arago tree. The timings is tested in am335x-evm
>>> So the timings can be directly used to populate GPMC timings. Timings can found at
>>>
>>> http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;
>>> h=66bfbd2c5b35dc81edce0c24843c476161ab5978;hp=370630359cb8db711cf0941cd2a242e28ccfb61e
>>>
>>> [...]
>>>> +static int gpmc_probe_dt(struct platform_device *pdev)
>>>
>>> Can you take care of the following section mismatch.
>>> WARNING: vmlinux.o(.text+0x1e2d0): Section mismatch in reference
>>> from the function gpmc_probe_dt() to the function .init.text:gpmc_nand_init().
>>
>> Sore, both fixed for v4.
>>
>>> [...]
>>>> +
>>>> +		val = of_get_nand_ecc_mode(child);
>>>> +		if (val >= 0)
>>>> +			gpmc_nand_data->ecc_opt = val;
>>>
>>> This will fail for BCH. Index of "soft_bch" is 5 & also don't have selection
>>> option between for BCH4 & BCH8 also.
>>> Can you use the of_property_read_u32 (as done early) to pass the ecc selection
>>> from dt file. This will help selection of BCH4 & BCH8 ecc options.
>>
>> Hmm. Shouldn't we rather teach of_get_nand_ecc_mode() that two modes and
>> bring the enum in sync?
> 
> ecc_opt is for selecting different ecc layout and not for selecting ecc mode.
> 
> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
> 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> 	OMAP_ECC_BCH4_CODE_HW
> 	OMAP_ECC_BCH8_CODE_HW
> 
> So selection of ecc layout data should come from DT not ecc mode.

Ok, I see. I would still like to set them by string rather than magic
numbers that map to enum entries. Valid values would be "none", "hw",
"hw-romcode", "bch4" and "bch8". Are you ok with that?


Thanks,
Daniel
