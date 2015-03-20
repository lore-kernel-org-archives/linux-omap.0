From: Roger Quadros <rogerq@ti.com>
Subject: Re: am335x: GPMC: reading speed with prefetch mode
Date: Fri, 20 Mar 2015 16:05:04 +0200
Message-ID: <550C2910.8020604@ti.com>
References: <CAGm1_kvgLKxDt_Xy8tdVDfOk46sD0-ybycXZT3tUd-5-=mD8WA@mail.gmail.com>
 <550AD57A.4070701@zonque.org>
 <CAGm1_kvh9cSwjqM0VohXRLN5sTmWLqAjzdj8W0p47FcpM0cKrA@mail.gmail.com>
 <550AF1A8.8030402@gmail.com>
 <CAGm1_ksmOPhJ=esbHJWy1TwfUS0gv35E0pxpPyQw1sjthT93CA@mail.gmail.com>
 <550C146D.40709@ti.com>
 <CAGm1_kvn8Wf=2RX+877eVTZY7FAfK4WN0LOBcFWJZwHhQBZqUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-bounces@lists.denx.de>
In-Reply-To: <CAGm1_kvn8Wf=2RX+877eVTZY7FAfK4WN0LOBcFWJZwHhQBZqUA@mail.gmail.com>
List-Unsubscribe: <http://lists.denx.de/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <http://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <http://lists.denx.de/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
To: Yegor Yefremov <yegorslists@googlemail.com>, "tony@atomide.com" <tony@atomide.com>
Cc: Falco Hyfing <hyfinglists@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom Rini <trini@konsulko.com>, Daniel Mack <zonque@gmail.com>
List-Id: linux-omap@vger.kernel.org

+Tony and l-o

On 20/03/15 15:37, Yegor Yefremov wrote:
> On Fri, Mar 20, 2015 at 1:37 PM, Roger Quadros <rogerq@ti.com> wrote:
>> On 20/03/15 13:24, Yegor Yefremov wrote:
>>> On Thu, Mar 19, 2015 at 4:56 PM, Daniel Mack <zonque@gmail.com> wrote:
>>>> On 03/19/2015 04:13 PM, Yegor Yefremov wrote:
>>>>> Strange. Have tried with "nand read" command, but still the same
>>>>> result with and without CONFIG_NAND_OMAP_GPMC_PREFETCH :
>>>>>
>>>>> [2.150655 0.001006] NAND read: device 0 offset 0x260000, size 0x1200000
>>>>> [15.978943 13.828288]  18874368 bytes read: OK
>>>>
>>>> What about adding some debug prints to the prefetch setup function and
>>>> see if it is executed at all?
>>>
>>> I2C:   ready
>>> DRAM:  256 MiB
>>> NAND: prefetch enabled
>>> NAND: 256 MiB
>>> MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
>>> Using default environment
>>>
>>> I've added "NAND: prefetch enabled" output for:
>>>
>>> #ifdef CONFIG_NAND_OMAP_GPMC_PREFETCH
>>>         else {
>>>                 printf("NAND: prefetch enabled\n");
>>>                 nand->read_buf = omap_nand_read_prefetch8;
>>>         }
>>> #else
>>>
>>> I've also put printf() into omap_nand_read_prefetch8() just to make
>>> sure it is called - it was called.
>>>
>>> Further ideas?
>>>
>>>>> Daniel, do you have the numbers? Images size and load time? What can I expect?
>>>>
>>>> I don't currently have the setup at hand, sorry. But the number I recall
>>>> from an email conversation back then is: The time from power-on, loading
>>>> SPL, loading U-Boot, leeching a 6MB uImage, jumping into it waiting for
>>>> the console to start dumping the kernel boot messages was less than 5
>>>> seconds in total.
>>>
>>> I Linux I had ti,nand-xfer-type = "polled";. After replacing it with
>>> ti,nand-xfer-type = "prefetch-polled"; I now get
>>>
>>> # dd if=/dev/mtdblock5 of=/dev/null bs=2M count=8
>>> 8+0 records in
>>> 8+0 records out
>>> 16777216 bytes (17 MB) copied, 2.58744 s, 6.5 MB/s
>>>
>>> instead of:
>>>
>>> # dd if=/dev/mtdblock5 of=/dev/null bs=2M count=8
>>> 8+0 records in
>>> 8+0 records out
>>> 16777216 bytes (17 MB) copied, 6.05157 s, 2.8 MB/s
>>>
>>> Do I see it right, that DMA support is not implemented in am33xx.dtsi?
>>
>> DMA support will have to be enabled in the board dts. e.g. am335x-bone.dts.
>>
>> if ti,nand-xfer-type is not specified (like in mainline kernel) then it
>> defaults to prefetch-polled
> 
> I get following error:
> 
> omap-gpmc 50000000.gpmc: GPMC revision 6.0
> nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
> nand: Micron MT29F2G08ABAEAWP
> nand: 256MiB, SLC, page size: 2048, OOB size: 64
> omap2-nand omap2-nand.0: DMA engine request failed
> 
> Kernel: 3.18.1
> 
> GPMC config:
> 
> &gpmc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&nandflash_pins_s0>;
>         ranges = <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
>         status = "okay";
> 
>         nand@0,0 {
>                 reg = <0 0 4>; /* CS0, offset 0 */
>                 nand-bus-width = <8>;
>                 ti,nand-ecc-opt = "bch8";
>                 ti,nand-xfer-type = "prefetch-dma";
> 
>                 gpmc,device-nand = "true";
>                 gpmc,device-width = <1>;
>                 gpmc,sync-clk-ps = <0>;
>                 gpmc,cs-on-ns = <0>;
>                 gpmc,cs-rd-off-ns = <44>;
>                 gpmc,cs-wr-off-ns = <44>;
>                 gpmc,adv-on-ns = <6>;
>                 gpmc,adv-rd-off-ns = <34>;
>                 gpmc,adv-wr-off-ns = <44>;
>                 gpmc,we-on-ns = <0>;
>                 gpmc,we-off-ns = <40>;
>                 gpmc,oe-on-ns = <0>;
>                 gpmc,oe-off-ns = <54>;
>                 gpmc,access-ns = <64>;
>                 gpmc,rd-cycle-ns = <82>;
>                 gpmc,wr-cycle-ns = <82>;
>                 gpmc,wait-on-read = "true";
>                 gpmc,wait-on-write = "true";
>                 gpmc,bus-turnaround-ns = <0>;
>                 gpmc,cycle2cycle-delay-ns = <0>;
>                 gpmc,clk-activation-ns = <0>;
>                 gpmc,wait-monitoring-ns = <0>;
>                 gpmc,wr-access-ns = <40>;
>                 gpmc,wr-data-mux-bus-ns = <0>;
> 
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 elm_id = <&elm>;
>         };
> };
> 
> Any idea?
> 
> Btw. where DMA support should be configured? GPMC config has no "dmas"
> like other components like mmc, uart, USB etc.

I've never tested dma on omap-nand in mainline. We've been solely relying on
prefetch-polled mode there.

someone needs to work on it and test dma support.

looks like the driver is hardcoding the DMA channel
                sig = OMAP24XX_DMA_GPMC;
                info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);

this will have to be fixed.
I'm not sure what else is missing on DMA side. But you could try to use a
free channel and see if it works?

Tony any insights?

cheers,
-roger

> 
>                 gpmc: gpmc@50000000 {
>                         compatible = "ti,am3352-gpmc";
>                         ti,hwmods = "gpmc";
>                         ti,no-idle-on-init;
>                         reg = <0x50000000 0x2000>;
>                         interrupts = <100>;
>                         gpmc,num-cs = <7>;
>                         gpmc,num-waitpins = <2>;
>                         #address-cells = <2>;
>                         #size-cells = <1>;
>                         status = "disabled";
>                 };
> 
> 
> Yegor
> 
