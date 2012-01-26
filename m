From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] GPMC: fix device size setup
Date: Thu, 26 Jan 2012 15:31:50 -0800
Message-ID: <20120126233150.GC29812@atomide.com>
References: <4F1D0D07.7070807@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29780 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab2AZXbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 18:31:52 -0500
Content-Disposition: inline
In-Reply-To: <4F1D0D07.7070807@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120122 23:01]:
> following statement can only change device size from 8-bit(0) to 16-bit(1),
> but not vice versa:
> 
> regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> 
> so as this field has 1 reserved bit, that could be used in future,
> just clear both bits and then OR with the desired value

Thanks applying into fixes.

Tony
