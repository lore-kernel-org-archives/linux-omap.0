From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/4] omapdrm: fix compatible string for td028ttec1
Date: Thu, 9 Nov 2017 07:48:10 +0100
Message-ID: <5B14648B-6C00-4C0D-8DFD-0DA0605C35B2@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <2790033.EQlQQc1BPI@avalon>
 <C999B55A-771D-44AF-8072-2F30FE6B54B7@goldelico.com>
 <2337862.ufPI2HCsv4@avalon>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2337862.ufPI2HCsv4@avalon>
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

> Am 09.11.2017 um 07:35 schrieb Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> 
> Hi Nikolaus,
> 
> On Thursday, 9 November 2017 08:05:15 EET H. Nikolaus Schaller wrote:
>>> Am 09.11.2017 um 04:33 schrieb Laurent Pinchart:
>>> On Wednesday, 8 November 2017 23:09:29 EET H. Nikolaus Schaller wrote:
>>>> The vendor name was "toppoly" but other panels and the vendor list
>>>> have defined it as "tpo". So let's fix it in driver and bindings.
>>>> 
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} | 4 ++--
>>>> drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c           | 4
>>>> ++--
>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c  | 4
>>>> ++--
>>>> 3 files changed, 6 insertions(+), 6 deletions(-)
>>>> rename
>>>> Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt
>>>> =>
>>>> tpo,td028ttec1.txt} (84%)
>>>> 
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>>>> b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>>>> similarity index 84%
>>>> rename from
>>>> Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>>>> rename to
>>>> Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt index
>>>> 7175dc3740ac..ed34253d9fb1 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>>>> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>>>> @@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
>>>> ========================
>>>> 
>>>> Required properties:
>>>> -- compatible: "toppoly,td028ttec1"
>>>> +- compatible: "tpo,td028ttec1"
>>>> 
>>>> Optional properties:
>>>> - label: a symbolic name for the panel
>>>> @@ -14,7 +14,7 @@ Example
>>>> -------
>>>> 
>>>> lcd-panel: td028ttec1@0 {
>>>> -	compatible = "toppoly,td028ttec1";
>>>> +	compatible = "tpo,td028ttec1";
>>>> 
>>>> 	reg = <0>;
>>>> 	spi-max-frequency = <100000>;
>>>> 	spi-cpol;
>>>> 
>>>> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>>>> b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c index
>>>> 0a38a0e8c925..2dab491478c2 100644
>>>> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>>>> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>>>> @@ -452,7 +452,7 @@ static int td028ttec1_panel_remove(struct spi_device
>>>> *spi)
>>>> }
>>>> 
>>>> static const struct of_device_id td028ttec1_of_match[] = {
>>>> -	{ .compatible = "omapdss,toppoly,td028ttec1", },
>>>> +	{ .compatible = "omapdss,tpo,td028ttec1", },
>>> 
>>> Doesn't this break backward compatibility with existing DT ?
>> 
>> Yes, it does. But I am only aware of the GTA04 which uses it and
>> there is a separate fix).
> 
> DT is supposed to be an ABI. In theory at least, one could boot a GTA04 with 
> an existing DT and a new kernel, and no regression should be noticed.

Yes, indeed...

> There 
> could also be other devices using this panel that you are not aware of.
> 
> For how to apply the theory to real life, I'll defer to Tomi :-)

Yes, Tomi should decide if we should keep the old compatible string in
the driver (in second place so to avoid a speed penalty)...

BR and thanks,
Nikolaus Schaller
