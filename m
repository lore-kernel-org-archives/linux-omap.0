From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 4/4] omapdss: fix problem enabling VDDS_DSI on OMAP3530
 (OpenPandora)
Date: Thu, 9 Nov 2017 07:12:29 +0100
Message-ID: <0E72D0DA-6868-48DB-8F6B-B5C8E6172BFC@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <b94c5e773994ee55df9225fc84825bacb3fcb256.1510175371.git.hns@goldelico.com>
 <3397395.9drm9Essi0@avalon>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3397395.9drm9Essi0@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, letux-kernel@openphoenux.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

> Am 09.11.2017 um 04:45 schrieb Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> 
> Hi Nikolaus,
> 
> Thank you for the patch.
> 
> On Wednesday, 8 November 2017 23:09:32 EET H. Nikolaus Schaller wrote:
>> commit d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI feature to
>> dpi code")
>> 
>> introduced a new match table which turned out to be wrong, at least
>> for the 600 MHz OpenPandora using the OMAP3530.
>> 
>> The effect was strange: only the Blue channel of the RGB panel was
>> driven while Red and Green stayed black. So a coloured picture turned
>> into blue/black.
>> 
>> The GTA04 with DM3730 didn't show the effect.
>> 
>> It turned out that VDDS_DSI was not properly initialized on OMAP3530,
>> because the .family string is just "OMAP3" for these processors and
>> not "OMAP3xxx".
>> 
>> Therefore we match the .machine attribute.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> I've already submitted a similar patch (but without the problem pointed out 
> below) in the mail thread where we discussed the issue. It is customary to use 
> the first patch posted (unless it is utterly broken of course).

Ah sorry. My workflow isn't well prepared for that and I already had committed
something to my private branch...

> Could you thus 
> please include it in this series in replacement of this patch ?

Well, you can as well reject my patch (it is just a proposal) and take yours
as a replacement. Especially as you better understand all the potential values
for .family and .machine than me.

Should be less work for both of us.

> 
>> ---
>> drivers/gpu/drm/omapdrm/dss/dpi.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c
>> b/drivers/gpu/drm/omapdrm/dss/dpi.c index 4ed5fde11313..aae3626910bb 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dpi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
>> @@ -566,8 +566,7 @@ static int dpi_verify_pll(struct dss_pll *pll)
>> }
>> 
>> static const struct soc_device_attribute dpi_soc_devices[] = {
>> -	{ .family = "OMAP3[456]*" },
>> -	{ .family = "[AD]M37*" },
>> +	{ .machine = "OMAP3[456]*" },
> 
> You also need 
> 
> 	{ .machine = "[AD]M37*" },
> 
> otherwise there will be no match for the OMAP3-like AM37xx and DM37xx SoCs.

Ah, ok. I wasn't aware that there are some AM37 and DM37 chips with and
some without OMAP3 prefix.

> 
> Another option would be to match on { .family = "OMAP3*" } but there could be 
> spurious matches, even though I haven't identified any.
> 
>> 	{ /* sentinel */ }
>> };
> 

BR and thanks,
Nikolaus Schaller
