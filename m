From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 1/4] omapdrm: panel: fix compatible vendor string for
 td028ttec1
Date: Fri, 1 Dec 2017 08:46:04 +0100
Message-ID: <22438EE8-C13C-4808-8CE2-F87D708610EE@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
 <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 01.12.2017 um 02:57 schrieb Rob Herring <robh@kernel.org>:
> 
> On Tue, Nov 28, 2017 at 04:48:54PM +0100, H. Nikolaus Schaller wrote:
>> The vendor name was "toppoly" but other panels and the vendor list
>> have defined it as "tpo". So let's fix it in driver and bindings.
>> 
>> We keep the old definition in parallel to stay compatible with
>> potential older DTB setup.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
>> drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 3 +++
>> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 3 +++
>> 3 files changed, 8 insertions(+), 2 deletions(-)
>> rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)
>> 
>> diff --git a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>> similarity index 84%
>> rename from Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>> rename to Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>> index 7175dc3740ac..ed34253d9fb1 100644
>> --- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>> @@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
>> ========================
>> 
>> Required properties:
>> -- compatible: "toppoly,td028ttec1"
>> +- compatible: "tpo,td028ttec1"
>> 
>> Optional properties:
>> - label: a symbolic name for the panel
>> @@ -14,7 +14,7 @@ Example
>> -------
>> 
>> lcd-panel: td028ttec1@0 {
>> -	compatible = "toppoly,td028ttec1";
>> +	compatible = "tpo,td028ttec1";
>> 	reg = <0>;
>> 	spi-max-frequency = <100000>;
>> 	spi-cpol;
>> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> index 0a38a0e8c925..a0dfa14f4fab 100644
>> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> @@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
>> }
>> 
>> static const struct of_device_id td028ttec1_of_match[] = {
>> +	{ .compatible = "omapdss,tpo,td028ttec1", },
> 
> Why the omapdss part?

I think because they are (currently and still) omapdrm
(omapdss) specific since SoC specific drivers for the
same panel may exist in parallel.

All panel drivers in drivers/gpu/drm/omapdrm/displays
have and need this prefix.

As far as I understand, the omapdss driver takes the
DTS compatible string, adds "omapdss," and then looks for
a panel driver to probe.

See also: Sebastian Reichel's comment to "[PATCH v3 4/4] DTS: Pandora: fix panel compatibility string"

BR,
Nikolaus Schaller
