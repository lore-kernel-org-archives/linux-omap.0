From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Tue, 20 Nov 2012 11:26:45 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9E94FE@DBDE01.ent.ti.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
 <1353338956-19420-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45903 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab2KTL1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 06:27:55 -0500
In-Reply-To: <1353338956-19420-4-git-send-email-zonque@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Mon, Nov 19, 2012 at 20:59:16, Daniel Mack wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
...
> +
> +	if (of_get_property(child, "ti,nand-ecc-use-elm", NULL))
> +		gpmc_nand_data->is_elm_used = 1;

Can you set to bool value (true) here.

Thanks
Avinash

