From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Fri, 15 Oct 2010 15:24:03 +0100
Message-ID: <20101015142402.GM14782@rakim.wolfsonmicro.main>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
 <201010061017.13908.peter.ujfalusi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
 <201010131131.49967.peter.ujfalusi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
 <20101015095109.2d76babe.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41170 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756173Ab0JOOYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Oct 2010 10:24:06 -0400
Content-Disposition: inline
In-Reply-To: <20101015095109.2d76babe.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Girdwood, Liam" <x0135381@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

On Fri, Oct 15, 2010 at 09:51:09AM +0300, Jarkko Nikula wrote:

> So things can get complicated if trying to implement generic transfer
> API to general purpose block like McBSP compared to some dedicated
> block where transfer setup is always more or less the same.

I tend to agree.  Experience with some of the other platforms suggests
that doing the abstracted API for data transfers doesn't save you that
much unless the hardware is really hard to manage and so needs lots of
code that can be factored out from the leaf drivers.
