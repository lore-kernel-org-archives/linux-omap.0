From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 5/5] of: Modify c_can binding documentation
Date: Mon, 3 Sep 2012 04:35:39 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA23AA5@DBDE01.ent.ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-6-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA234C7@DBDE01.ent.ti.com>
 <5042BE3E.8040808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5042BE3E.8040808-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

Thanks for the review,

On Sun, Sep 02, 2012 at 07:32:38, Stephen Warren wrote:
> On 09/01/2012 12:05 AM, AnilKumar, Chimata wrote:
> > On Fri, Aug 31, 2012 at 14:59:21, AnilKumar, Chimata wrote:
> >> Modify c_can binding documentation according to recent review comments
> >> on device tree data addition patches.
> 
> >> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> >> index a43f083..90a70be 100644
> >> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> >> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> >> @@ -8,6 +8,8 @@ Required properties:
> >>  			  registers map
> >>  - interrupts		: property with a value describing the interrupt
> >>  			  number
> >> +- status		: describes the node status either "disabled" or
> >> +			  "okay"
> 
> That's a standrd property that applies to any node, and doesn't describe
> data required by the device itself (as do regs/interrupts) by simply
> whether the node is activated; I'm not sure it's worth mentioning it in
> a device-specific binding.
> 
> A similar comment exists for the pre-existing description of
> interrupt-parent below.
> 
> >>  Optional properties:
> >>  - interrupt-parent	: The parent interrupt controller
> 

Then, I will remove these properties from the doc.

Thanks
AnilKumar
