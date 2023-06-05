Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD5C77B73
	for <linux-omap@archiver.kernel.org>; Mon,  5 Jun 2023 12:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjFEMZR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 5 Jun 2023 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjFEMZP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jun 2023 08:25:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE3F9ED;
        Mon,  5 Jun 2023 05:25:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2D9F380FE;
        Mon,  5 Jun 2023 12:25:13 +0000 (UTC)
Date:   Mon, 5 Jun 2023 15:25:11 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230605122511.GZ14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com>
 <20230605061511.GW14287@atomide.com>
 <ZH3Gxwb7/VYzIW3r@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3Gxwb7/VYzIW3r@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230605 11:28]:
> On Mon, Jun 05, 2023 at 09:15:11AM +0300, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [230603 06:35]:
> 
> ...
> 
> >  	/* wait until UART in idle status */
> >  	while
> > -		(serial_in(up, MTK_UART_DEBUG0));
> > +		(mtk8250_read(data, MTK_UART_DEBUG0));
> 
> In case you go with this, make it a single line.

OK makes sense thanks.

Tony
