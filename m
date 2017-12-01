From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 1/4] omapdrm: panel: fix compatible vendor string for
 td028ttec1
Date: Fri, 1 Dec 2017 10:18:18 +0200
Message-ID: <da3ce573-1593-3377-1243-ff500e9522b3@ti.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
 <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, letux-kernel@openphoenux.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/12/17 03:57, Rob Herring wrote:

>> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> index 0a38a0e8c925..a0dfa14f4fab 100644
>> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> @@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
>>  }
>>  
>>  static const struct of_device_id td028ttec1_of_match[] = {
>> +	{ .compatible = "omapdss,tpo,td028ttec1", },
> 
> Why the omapdss part?

This driver is omapdrm specific. But I don't want the dts file to have
omapdrm specific compatible strings, so that the dts files do not have
to be changed when in the future we move to common DRM panel drivers

So:

- In the .dts, we have compatible = "tpo,td028ttec1"
- At early boot time, we append "omapdss," to compatible strings for
panels connected to the DSS node.
- The omapdrm specific drivers match to "omapdss,tpo,td028ttec1"

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
