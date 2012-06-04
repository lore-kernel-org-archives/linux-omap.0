From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: latest kernel for am35xx
Date: Mon, 4 Jun 2012 09:51:23 +0200
Message-ID: <20120604075123.GA13523@localhost.localdomain>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
 <CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
 <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
 <4FC7338E.4080502@visionsystems.de>
 <20120604072823.GA7053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:34913 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab2FDHvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 03:51:40 -0400
Received: (from localhost user: 'ladis' uid#521 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1903626Ab2FDHvi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 4 Jun 2012 09:51:38 +0200
Content-Disposition: inline
In-Reply-To: <20120604072823.GA7053@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jun 04, 2012 at 09:28:23AM +0200, Ladislav Michl wrote:
> does USB work for you? I forward ported support for TechNexion's TAM-3517 on
> Twister board to current master, but so far no luck with mass storage
> support (patch for reference http://ladislav.michl.sweb.cz/tam3517.patch).

patch updated, so now does not contain random clock changes, so output changes:
omap_hwmod: am35x_otg_hs: cannot be enabled for reset (3)
...
usbhs_omap: alias fck already exists
...
Switching to clocksource 32k_counter
usbhs_omap usbhs_omap: xclk60mhsp1_ck set parentfailed error:-22
...
musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
musb-hdrc musb-hdrc: musb_init_controller failed with status -19

It would be nice to update master branch :-)

	ladis
