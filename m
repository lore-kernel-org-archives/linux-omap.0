From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Delete an unnecessary kfree() call in
 omap_hsmmc_pdata_init()
Date: Mon, 26 Aug 2019 09:20:50 -0700
Message-ID: <20190826162050.GX52127@atomide.com>
References: <69025c8c-8d84-6686-138b-cde59467b802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69025c8c-8d84-6686-138b-cde59467b802@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Balaji T K <balajitk@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Markus Elfring <Markus.Elfring@web.de> [190826 06:31]:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 26 Aug 2019 15:05:31 +0200
> 
> A null pointer would be passed to a call of the function "kfree" directly
> after a call of the function "kzalloc" failed at one place.
> Remove this superfluous function call.
> 
> This issue was detected by using the Coccinelle software.

Applying into omap-for-v5.4/soc thanks.

Tony
