From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] gpio: Enable pcf857x GPIO expander for Device Tree
Date: Tue, 27 Aug 2013 09:58:05 +0200
Message-ID: <1469857.rVNB2R9T3s@avalon>
References: <1370527523-1030-1-git-send-email-archit@ti.com> <7142087.DRSP8TfuKN@avalon> <521C4E82.9040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <521C4E82.9040309@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Archit,

On Tuesday 27 August 2013 12:30:18 Archit Taneja wrote:
> On Tuesday 27 August 2013 12:17 PM, Laurent Pinchart wrote:
> > On Tuesday 27 August 2013 05:20:45 Linus Walleij wrote:
> >> On Mon, Aug 26, 2013 at 8:21 AM, Archit Taneja <archit@ti.com> wrote:
> >>> Add code to parse the GPIO expander Device Tree node and extract
> >>> platform
> >>> data out of it, and populate the struct 'pcf857x_platform_data'
> >>> maintained by the driver. This enables devices to reference the gpio
> >>> expander from Device Tree.
> >>> 
> >>> Add DT binding info in Documentation.
> >>> 
> >>> Signed-off-by: Archit Taneja <archit@ti.com>
> >>> ---
> >>> - v2 posted after quite a while, sorry for the delay!
> >>> 
> >>> Changes in v2:
> >>> - second gpeio-cell description corrected in Documentation
> >>> - interrupt controller description removed for now, will be added in a
> >>> 
> >>>    follow up patch
> >>> 
> >>> - n_latch description updated
> > 
> > And it seems that the patch conflicts with
> > 
> > https://lkml.org/lkml/2013/8/26/248
> > 
> > :-/
>
> :/
>
> > If we end up merging this one, I'd like to at least rename the DT n-latch
> > property to pin-initial-states as in my patch and update the
> > documentation, as I find it more explicit.
> 
> I think your patch is cleaner and more descriptive.

Thank you.

> The only thing which I am not clear about in your patch is the extra work
> done in getting ngpio, that should be available in i2c_device_id pointer
> argument in probe(id points to the array pcf857x_id already available in the
> driver with the number of gpios for each chip variant).

You're right. I'll fix that and repost.

-- 
Regards,

Laurent Pinchart

