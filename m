From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/7] TWL6030 audio codec initial support
Date: Mon, 28 Sep 2009 14:53:26 +0100
Message-ID: <20090928135325.GH31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391DE@dlee04.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC75@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54367 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751397AbZI1NxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Sep 2009 09:53:23 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC75@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Sep 26, 2009 at 10:42:39AM +0530, Shilimkar, Santosh wrote:

[Please fix your MUA to word wrap at 80 lines - I've reflowed the
message below.]

> While doing that series, we realized that there is a lot of code
> common between TWL5030 and TWL6030 apart from mainly interrupt handling
> and hence a common file approach is taken to avoid code duplication. The
> patch " [PATCHv2 3/7] ASoC: TWL6030: Add twl6030 codec driver" gives me
> an impression that there is opportunity to have a single file supporting
> both IC's. IC specific code can be handled using the runtime check
> depending on the revision.  Can you explore this ? 

Looking at the code there are substantial differences between the two
devices - the refactoring to move the digital section into the OMAP
looks to have made a substantial difference.  What might make sense is
something more like the refactoring that can be seen in wm_hubs where
shared functionality has been factored out into a library which can be
used by more than one CODEC driver.
