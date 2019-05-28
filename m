From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Tue, 28 May 2019 02:39:52 -0700
Message-ID: <20190528093952.GM5447@atomide.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
 <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [190528 09:19]:
> On 27/05/2019 14:21, Tony Lindgren wrote:
> 
> >> Looks good to me. For some reason I can't boot 5.2-rc2 (on x15) so I haven't
> >> been able to test yet. I'll pick the series up in any case, and I'll test it
> >> when I get the kernel booting.
> > 
> > Great good to have these merged finally :)
> > 
> > Hmm I wonder if some x15 models are affected by the SoC variant
> > changes queued in my fixes branch?
> 
> This is what I see with earlycon, on linux-omap fixes branch. I think this looks
> similar to what I saw with dra76 _without_ the fixes.

OK sounds like we need to use some different SoC specific .dtsi file,
is this maybe x15 rev c?

You can detect which modules fail based on the module base address
for revision register seen with the following debug patch. Then
those need to be tagged with status = "disabled" at the module
level in the SoC specific dtsi file.

Regards,

Tony

8< --------------
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2069,6 +2069,8 @@ static int sysc_probe(struct platform_device *pdev)
 	struct sysc *ddata;
 	int error;
 
+	dev_info(&pdev->dev, "probing device\n");
+
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
