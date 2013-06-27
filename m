From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Thu, 27 Jun 2013 09:47:28 +0530
Message-ID: <51CBBCD8.5030600@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
 <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, "Balbi,
 Felipe" <balbi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Rini,
 Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul,
On Wednesday 26 June 2013 10:56 PM, Paul Walmsley wrote:
> On Wed, 26 Jun 2013, Rajendra Nayak wrote:
>
>> Apart from confirming if you are manually enabling these options, can you also give some
>> details on how you append the dtb to the kernel image?
>>
>> Most of us use an out-of-tree patch from Grant to do this, which I have shared below [2]
>>
>> Even without the patch with the below commands [1] to append the dtb, it still works, so it
>> would be good to know what steps you follow to append the dtb to the kernel image.
>
> Here's how I do it:
>
> ARCH=arm CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX} nice make -j$CORES zImage am335x-bone.dtb
>
> cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
Here is the catch..
Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb was 
generated in arch/arm/boot).
You are using very old dtb file. Please delete all your dtb files in 
arch/arm/boot/ folder and check once.
Here is the patch from Grant Likely which does that.
https://patchwork.kernel.org/patch/1813321/
Can you please give a try updating this ..:)

Thanks and regards,
Lokesh
>
> scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux-' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone
>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
