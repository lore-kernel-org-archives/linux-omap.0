From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/7] picodlp projector driver
Date: Tue, 03 May 2011 22:06:22 +0300
Message-ID: <1304449582.26126.41.camel@deskari>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55649 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754582Ab1ECTG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 15:06:27 -0400
Received: by mail-ey0-f180.google.com with SMTP id 24so120626eyg.25
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 12:06:25 -0700 (PDT)
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> picodlp projector is supported by OMAP.
> OMAP4430 SDP and EVM boards have an on board projector called as picodlp projector.
> picodlp would be connected to display sub system as a display panel.
> It has a dlp processor dpp2600.
> 
> The panel would be connected using 24 bit parallel interface.
> It is a WVGA panel with 864 X 480 resolution.
> 
> To know more about picodlp please visit:
> http://omappedia.org/wiki/PicoDLP_projector_guide

I think patches 3, 4, 5, 7 can be squashed into one. panel-picodlp.c is
not that big of a file, and the division is quite artificial to my eyes.
In theory the dss part and the i2c part could be in separate patches,
but that doesn't make much sense here as the dss part won't function
without the i2c part.

It's much easier to review one whole patch, than pieces of the whole.

 Tomi


