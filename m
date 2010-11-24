From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 11/11] OMAP: GPIO: Remove omap_gpio_init()
Date: Wed, 24 Nov 2010 15:28:24 -0800
Message-ID: <20101124232824.GY31536@atomide.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
 <1290524213-395-12-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57920 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab0KXX2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 18:28:31 -0500
Content-Disposition: inline
In-Reply-To: <1290524213-395-12-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com

* Varadarajan, Charulatha <charu@ti.com> [101123 06:47]:
> Remove the usage of omap_gpio_init() from all omap board files
> since omap_gpio_init() does nothing, after gpio is implemented
> as a platform device.

Great, glad to see these go!

Tony
