From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 3/4] DTS: Pandora: fix panel compatibility string
Date: Thu, 9 Nov 2017 07:06:37 +0100
Message-ID: <06ED9040-933F-4EA8-A74A-B63423589651@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
 <1634573.IyLVzmLhWc@avalon>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1634573.IyLVzmLhWc@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 09.11.2017 um 04:36 schrieb Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> 
> Hi Nikolaus,
> 
> Thank you for the patch.
> 
> On Wednesday, 8 November 2017 23:09:31 EET H. Nikolaus Schaller wrote:
>> We can remove the "omapdss," prefix.
> 
> I agree but you should explain why.

I can add a sentence if someone helps me to formulate it correctly.
Or Tomi, please add when accepting the patch.

> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> b/arch/arm/boot/dts/omap3-pandora-common.dtsi index
>> 53e007abdc71..64d967ec8c58 100644
>> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
>> @@ -626,7 +626,7 @@
>> 
>> 	lcd: lcd@1 {
>> 		reg = <1>;	/* CS1 */
>> -		compatible =	"omapdss,tpo,td043mtea1";
>> +		compatible =	"tpo,td043mtea1";
>> 		spi-max-frequency = <100000>;
>> 		spi-cpol;
>> 		spi-cpha;
> 
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
