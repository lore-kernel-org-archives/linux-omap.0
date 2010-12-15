From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38,part two
Date: Wed, 15 Dec 2010 16:44:58 +0530
Message-ID: <b49f721f09976988f78ce7faf0499654@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
 <a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com> <alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60889 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753228Ab0LOLO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 06:14:59 -0500
Received: by mail-qy0-f177.google.com with SMTP id 27so1991489qyk.15
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 03:14:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, December 15, 2010 9:28 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
Mark Brown; Benoit Cousson; Kevin Hilman;
> Peter Ujfalusi; Santosh Shilimkar; Jarkko Nikula; Liam Girdwood
> Subject: RE: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches
for 2.6.38,part two
>
> On Tue, 14 Dec 2010, Rajendra Nayak wrote:
>
> > Boot tested on 2430/3430/4430SDP. Tested RET/OFF mode in suspend
> > on 3430SDP with minimal config (omap3_pm_defconfig).
>
> Thanks for testing this.  Would you like me to add Tested-by:'s ?

Sure,
Tested-by: Rajendra Nayak <rnayak@ti.com>

>
> Also, I still plan to make that change that you proposed to cause the
> prminst, cminst functions to read/write directly to the registers...
> soon...

Thanks, already had a look.

>
>
> - Paul
