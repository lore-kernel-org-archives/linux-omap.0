From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 06/17] OMAP2,3 DSS2 Move DSS driver register from
 board file to devices.c
Date: Wed, 05 Jan 2011 12:51:16 +0200
Message-ID: <1294224676.14254.40.camel@tubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-7-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:17823 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab1AEKvW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 05:51:22 -0500
In-Reply-To: <1294059069-26737-7-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Hi,

On Mon, 2011-01-03 at 18:20 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> omap_display_init function is introduced in devices.c to do the DSS driver
> registration.  So replace platform_device_register or platform_add_devices of
> DSS with omap_display_init().

This and two previous patches are missing a color in the subject.

I'm also ok with Kevin's suggestion to put display code in separate
file. There's other stuff to add there also at some point, like changing
pinmuxing.

Also, I think it would be cleaner to first add the new code to devices.c
(or display.c) and display.h in one patch, then in another patch change
the board files to use this new display init.

 Tomi


