From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Fix TI CPSW Phy mode selection on IGEP COM
 AQUILA.
Date: Mon, 7 Jul 2014 04:50:05 -0700
Message-ID: <20140707115004.GU28884@atomide.com>
References: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48515 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751939AbaGGLuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 07:50:05 -0400
Content-Disposition: inline
In-Reply-To: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Enric Balletbo i Serra <eballetbo@iseebcn.com> [140625 04:44]:
> As this board use external clock for RMII interface we should specify 'rmii'
> phy mode and 'rmii-clock-ext' to make ethernet working.

Thanks applying into omap-for-v3.16/fixes.

Tony
