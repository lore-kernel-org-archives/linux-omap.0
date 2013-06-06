From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in
 clock36xx.c
Date: Thu, 6 Jun 2013 15:31:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com> <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com> <CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39265 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab3FFPb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 11:31:57 -0400
In-Reply-To: <CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, jean-philippe francois <jp.francois@cynove.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Kevin Hilman <khilman@linaro.org>

On Thu, 6 Jun 2013, jean-philippe francois wrote:

> Does the first version [1] of the patch, that only touch the MSB of
> the divider also trigger the
> bug ?
> 
> [1]  https://patchwork.kernel.org/patch/2609681/

That one passes the PM test here.  Will take this one for v3.10-rc fixes 
instead, since it fixes a known DSS problem and the original code wasn't 
correct.

Jean, could you work with Mike to come up with a better approach for 
v3.11 or v3.12?


- Paul
