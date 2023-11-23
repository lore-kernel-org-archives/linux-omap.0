Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C45224F2
	for <linux-omap@vger.kernel.org>; Thu, 23 Nov 2023 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TorcYzd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E4C433C7;
	Thu, 23 Nov 2023 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700736073;
	bh=nFEAOqE6x/NDZvJnfnKH663qewXBVjbzzX523Xev7lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TorcYzd/bGGxpk5uRxKa3pngvRjZgOTAS+5vgboRT9b06u3XQxH1fxKEQ1f6yrzjj
	 kXxvZBZ/QfqwTxHafO4Aav3r13p86t9y6R3hYUAi0D64JLlKcU8wplC5TTRfn+I1M3
	 NoJrkO3l3outGzPeD+oc1Fz4XaqXMBY3F0GB0SCvx5T7Hu3rETw+j6AvH7S2seO2Uf
	 MjfmW0emprMbwKtAOgVcIjoulnowiQjruA6spYXhI/+q/EaP+peHPlFgBLgtv6syZ1
	 XVxe+pgX373pWc93gOG9CnSC3C1KHusWXKQidH6xnBWnJcfJ1wGXFHWanvhWob7jPf
	 mOTJAEMhZnDwA==
Date: Thu, 23 Nov 2023 10:41:08 +0000
From: Lee Jones <lee@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: tony@atomide.com, robh@kernel.org, wens@csie.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Message-ID: <20231123104108.GF1184245@google.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
 <20231123103756.GD1184245@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123103756.GD1184245@google.com>

On Thu, 23 Nov 2023, Lee Jones wrote:

> On Sun, 29 Oct 2023, Peter Ujfalusi wrote:
> 
> > The core twl chip is probed via i2c and the dev->driver->of_match_table is
> > NULL, causing the driver to fail to probe.
> > 
> > This partially reverts commit 1e0c866887f4.
> > 
> > Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> > ---
> >  drivers/mfd/twl6030-irq.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> > index f9fce8408c2c..3c03681c124c 100644
> > --- a/drivers/mfd/twl6030-irq.c
> > +++ b/drivers/mfd/twl6030-irq.c
> > @@ -24,10 +24,10 @@
> >  #include <linux/kthread.h>
> >  #include <linux/mfd/twl.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/property.h>
> >  #include <linux/suspend.h>
> >  #include <linux/of.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/of_device.h>
> >  
> >  #include "twl-core.h"
> >  
> > @@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
> >  	int			nr_irqs;
> >  	int			status;
> >  	u8			mask[3];
> > -	const int		*irq_tbl;
> > +	const struct of_device_id *of_id;
> >  
> > -	irq_tbl = device_get_match_data(dev);
> > -	if (!irq_tbl) {
> > +	of_id = of_match_device(twl6030_of_match, dev);
> 
> I think you just dropped support for ACPI.

Ah, scrap that.  I was looking at the wrong part of 1e0c866887f4.

So what about the other drivers changed in the aforementioned commit?

Ideally we'd have a call that covers all of the various probing APIs.

> Rob, care to follow-up?

I'd still like Rob to comment.

-- 
Lee Jones [李琼斯]
