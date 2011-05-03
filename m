From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Tue, 03 May 2011 21:44:53 +0300
Message-ID: <1304448293.26126.29.camel@deskari>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-5-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56306 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754317Ab1ECSo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 14:44:58 -0400
Received: by eye13 with SMTP id 13so119081eye.3
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 11:44:56 -0700 (PDT)
In-Reply-To: <1304347971-1504-5-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> The configurations and data transfer with picodlp panel happens through i2c.
> An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> 
> dpp2600 requires 4 gpio lines for interfacing it with any processor,
> phy_reset, ready_reset, park, display_select

Hmm, so what is dpp2600? It's mentioned here for the first time, the
documentation doesn't mention it.

If it means the picodlp, just use the same name all the time. If not,
you could tell what it is first.

 Tomi


