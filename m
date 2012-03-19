From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 10:54:01 -0600
Message-ID: <4F6764A9.8090907@wwwdotorg.org>
References: <4F22DEF2.5000807@ti.com> <201203191501.10232.arnd@arndb.de>
 <4F674BC4.2070802@wwwdotorg.org> <201203191545.40933.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201203191545.40933.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/19/2012 09:45 AM, Arnd Bergmann wrote:
> On Monday 19 March 2012, Stephen Warren wrote:
>>> Maybe one can use named properties in a new device node in that case,
>>> like this:
>>>
>>>       bus {
>>>               dma: dma-controller {
>>>                       #dma-cells = <1>;
>>>               };
>>>
>>>               device {
>>>                       compatible = "device";
>>>                       channel: dma-channel {
>>>                               type = <0x1>;
>>>                               name = "foo";
>>>                               number = <23>;
>>>                               direction = <3>;
>>>                       };
>>>                       dma-requests = <&dma &channel>;
>>>               };
>>>       };
>>
>> For reference, this is very similar to how the pinctrl bindings work,
>> except that they require the "channel" node to be a child of the DMA
>> controller, and hence "dma-requests" doesn't contain <&dma &channel>,
>> just <&channel>, since "dma" is the parent (or grand-parent) of "channel".
> 
> Right, but the difference beytween the pinctrl binding and what I
> describe here is that the channel description would be part of the
> dma engine driver specific binding, not the generic binding that
> is visible to device drivers.

That's actually true for pinctrl as well: Common pinctrl bindings cover
the content/format of "dma-requests" and a requirement for a
"dma-channel" node, whereas the per-pin-controller bindings define the
content of node "dma-channel".
