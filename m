From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 09/17] OMAP2,3: DSS2: Move clocks from core driver
 to dss driver
Date: Fri, 07 Jan 2011 11:14:08 +0200
Message-ID: <1294391648.3968.27.camel@nubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-10-git-send-email-svadivu@ti.com>
	 <1294241755.14254.142.camel@tubuntu>
	 <AANLkTikeJX2qnhf-AmiDcb_9Dkmc1pQAFcj=WF9xo5R1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:42052 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab1AGJOQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 04:14:16 -0500
In-Reply-To: <AANLkTikeJX2qnhf-AmiDcb_9Dkmc1pQAFcj=WF9xo5R1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Semwal, Sumit" <sumit.semwal@ti.com>
Cc: ext Guruswamy Senthilvadivu <svadivu@ti.com>, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

On Thu, 2011-01-06 at 15:10 +0530, ext Semwal, Sumit wrote:
> Hi Tomi,
> 
> On Wed, Jan 5, 2011 at 9:05 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> > On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
> >> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >>
> >> clks are moved to dss platform driver.  clk_get/put APIs use dss device instead
> >> of core platform device. So the device name is changed from omap_display to
> >> omap_dss in 2420, 2430, 3xxx clock database files. Now teh core driver
> >> "omap_display" only takes care of panel registration with the custom bus.
> >> dss driver would take care of the clocks needed by DISPC, RFBI, DSI, VENC.
> >>
> >> TODO:  The clock content would be adapted to omap_hwmod in a seperate series.
> >>
> >> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > <snip>
> >
> >> @@ -508,14 +192,7 @@ static int omap_dss_probe(struct platform_device *pdev)
> >>       dss_init_overlay_managers(pdev);
> >>       dss_init_overlays(pdev);
> >>
> >> -     r = dss_get_clocks();
> >> -     if (r)
> >> -             goto err_clocks;
> >> -
> >> -     dss_clk_enable_all_no_ctx();
> >> -
> >> -     core.ctx_id = dss_get_ctx_id();
> >> -     DSSDBG("initial ctx id %u\n", core.ctx_id);
> >> +     dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> >>
> >>  #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> >>       /* DISPC_CONTROL */
> >> @@ -589,7 +266,7 @@ static int omap_dss_probe(struct platform_device *pdev)
> >>                       pdata->default_device = dssdev;
> >>       }
> >>
> >> -     dss_clk_disable_all();
> >> +     dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> >
> > Why are the calls dss_clk_enable_all_no_ctx() and dss_clk_disable_all()
> > changed?
> This came as an after-effect of moving all clk related stuff to dss.c;
> I think the idea is that all the new DSS IP platform drivers should
> use only the exposed clock mgmt APIs [dss_clk_enable() /
> dss_clk_disable()].

Ah, right.

> However, you are right; all the required clocks might not be getting
> enabled / disabled as required.
> I can (re)create the static dss_clk_disable_all() /
> dss_clk_enable_all_no_ctx() locally inside core.c - do you think
> that's ok, or should I export these functions too from dss.c?

Well... I think all the xxx_init() functions should enable the clocks
they require, so in that sense enabling the clocks is not needed at all.

But there's the (hackish) code for CONFIG_FB_OMAP_BOOTLOADER_INIT, which
requires normal dss clocks. Also if each xxx_init() call enables and
disables the clocks, and dss_probe doesn't keep the clocks enabled, then
we would get a ctx save/restore after every init, which would not be
nice.

So I think enabling just ICK and FCK1 would be enough, to get
CONFIG_FB_OMAP_BOOTLOADER_INIT work and to prevent ctx save/restore.

Perhaps there should be a comment above the dss_clk_enable, like "keep
clocks enabled to prevent context saves/restores during init".

 Tomi


