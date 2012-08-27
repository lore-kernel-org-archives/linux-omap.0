From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: AM33XX: clock: Add dcan clock aliases for
 device-tree
Date: Mon, 27 Aug 2012 17:20:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1208271717420.26953@utopia.booyaka.com>
References: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36525 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab2H0RUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 13:20:14 -0400
In-Reply-To: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robherring2@gmail.com>

Hi

On Mon, 27 Aug 2012, Vaibhav Hiremath wrote:

> Currently, the device names for the dcan module follows the
> format "dcan.X", where 'X' is the dcan instance number.
> On other side, driver may request for clock with/without con_id
> and dev_id, and it is expected that platform should respect this
> request and return the requested clock handle.
> 
> Now, when using device tree, the format of the device name created
> by OF layer is different, "<reg-address>.<device-name>",
> assuming that the device-tree "reg" property is specified.
> This causes the look-up failure for clock node in dcan driver
> 
> To fix this add new dcan clock alias for using device-tree.

Is the dcan driver present in v3.6-rc kernels?  Doesn't look like it but 
maybe it's under an alias.


- Paul
