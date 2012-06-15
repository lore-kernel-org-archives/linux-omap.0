From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 15 Jun 2012 06:11:59 -1000
Message-ID: <4FDB5ECF.3000701@firmworks.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206150900.50866.arnd@arndb.de>
 <Pine.LNX.4.64.1206151107480.11729@axis700.grange>
 <201206151127.24386.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201206151127.24386.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6/15/2012 1:27 AM, Arnd Bergmann wrote:
> On Friday 15 June 2012, Guennadi Liakhovetski wrote:
>>> In the common case, you could have one device connected to the third
>>> slave ID of the first controller but the fifth slave ID of the
>>> second controller. In this case, you really have to specify each
>>> controller with its slave ID separately, even if that means a lot
>>> of duplicate data for shmobile.
>>
>> So, you don't think it's worth making a short-cut possible to specify a
>> DMAC type instead of each instance phandle? It really would mean __a lot__
>> of duplication - with 3 generic controllers on (some) current chips and
>> possibly more on those, that I'm not aware about.
>
> It's certainly possible to make that short-cut, but I'm not convinced
> if it's worth it. One thing you can do is create a meta-device for
> all of the identical DMA controllers, and refer to that one from the
> devices, but make it a separate device node from the actual controllers,
> of which you can have more than one. This makes the binding for your
> dma controller more complex but reduces the amount of data required
> in the other device nodes.
>
> In case of sh7372, this could look something like
>
> 	dma: dmac-mux {
> 		compatible = "renesas,sh-dma-mux";
> 		#dma-cells =<4>; /* slave-id, addr, chcr, mid-rid */
> 		#address-cells =<1>;
> 		#size-cells =<1>;
> 		ranges;

In light of the reg entries below, perhaps #size-cells=0 ?
>
>
> 		dmae@0xfe008020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe008020 0xfe00828f
> 				0xfe009000 0xfe00900b>
> 			interrupts =<0x20c0 0x2000 0x2020 0x2040 0x2060 0x2080 0x20a0>;
> 		};
>
> 		dmae@0xfe018020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe018020 0xfe01828f
> 				0xfe019000 0xfe01900b>
> 			interrupts =<0x21c0 0x2100 0x2120 0x2140 0x2160 0x2180 0x21a0>;
> 		};
>
> 		dmae@0xfe028020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe028020 0xfe02828f
> 				0xfe029000 0xfe02900b>
> 			interrupts =<0x22c0 0x2200 0x2220 0x2240 0x2260 0x2280 0x22a0>;
> 		};
> 	};
>
> This way, a slave would refer to the dmac-mux node and while
> the device driver binds to the child nodes.
>
>>> I'm not sure I understand what the "configuration register values"
>>> above are.
>>
>> As I explained in an earlier mail, those include transfer size and other
>> parameters, but cannot be completely calculated in device drivers, because
>> they also vary between SoCs.
>
> Yes, but they can be part of the device tree source, because when writing
> that, you know both the requirements of the device and the capabilities
> of the controller.
>
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
