From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
Date: Thu, 30 May 2013 09:24:24 +0200
Message-ID: <51A6FEA8.5030704@ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com> <20130508235404.GX32546@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C320D@DBDE04.ent.ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C5629@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C5629@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "zonque@gmail.com" <zonque@gmail.com>, "Philip,
 Avinash" <avinashphilip@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Pekon,

On 05/20/2013 06:44 AM, Gupta, Pekon wrote:
>  
>>>>>
>>>>>  	am33xx_pinmux: pinmux@44e10800 {
>>>>>  		pinctrl-names = "default";
>>>>> -		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
>>>>> +		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
>>>>> +			&nandflash_pins_s0>;
>>>>
>>>> Why add this to the board level fallback (called pinctrl hogs, I think)?
>>>> This can be part of nand node you added below so that the pinctrl will
>>>> take effect when nand gets probed instead of all the time.
>>>
>>> Yes we should have all the pinctrl entries under the related drivers.
>>> This makes it easy remux pins during runtime if needed, and also
>>> allows unloading pinctrl-single.ko for development.
>>>
>> Yes, accepted. This has been already fixed in v3 of this patch set.
>> If all fine, then please pull this for next merge..
>>
>> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046712.html
>>
>> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046814.html
>>
>> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046710.html
>>
>>
>> with regards, pekon
> 
> Request you to please accept | provide feedbacks on this patch series.
> These are waiting acceptance since Jan-2013, and are necessary for 
> DT based configs for board having NAND support.
> 
> with regards, pekon

Sorry, I missed that series.

I'm applying it right now.

Thanks,
Benoit
