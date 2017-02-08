From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: dss: Handle return error in dss_init_ports.
Date: Wed, 08 Feb 2017 15:21:43 +0100
Message-ID: <1645625.BTpumnS8aX@amdc3058>
References: <CGME20170203122444epcas2p3e0d5ed32cac85fd86d900a62dbeb03a4@epcas2p3.samsung.com>
 <c0063f69-e6f8-ce91-8069-308fe4ddb86a@gmail.com> <25198769.WjcufK8OeX@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <25198769.WjcufK8OeX@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, February 08, 2017 11:25:47 AM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, February 07, 2017 05:41:37 PM Arvind Yadav wrote:
> > Hi,
> > 
> > In dss_init_ports, There is no need to add dss_uninit_ports before 
> > returning.
> > Because it's already take care in dss_bind. dss_bind  is handling
> > dss_uninit_ports in error path.
> 
> It doesn't handle cleanup of partially initialized ports,

BTW by "partially initialized ports" here I mean cases like
i.e. dpi port fully initialized and sdi one not initialized

> please look at the code:
> 
> ...
> 	r = dss_init_ports(pdev);
> 	if (r)
> 		goto err_init_ports;
> ...
> err_runtime_get:
> 	pm_runtime_disable(&pdev->dev);
> 	dss_uninit_ports(pdev);
> err_init_ports:
> 	if (dss.video1_pll)
> 		dss_video_pll_uninit(dss.video1_pll);
> ...
> 
> dss_uninit_ports() is not called on partially initialized

ditto

> ports (when dss_init_ports() returns an error we go straight
> into err_init_ports label and skip dss_uninit_ports())
> 
> > -Arvind
> > 
> > 
> > On Monday 06 February 2017 08:58 PM, Bartlomiej Zolnierkiewicz wrote:
> > > dpi_uninit_port() & sdi_uninit_port() skip not fully
> > > initialized port

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
