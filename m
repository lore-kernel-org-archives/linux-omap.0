From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: sbc-t3x: add DVI display data
Date: Mon, 10 Nov 2014 09:48:45 -0800
Message-ID: <20141110174845.GP31454@atomide.com>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
 <1414927198-7127-1-git-send-email-lifshitz@compulab.co.il>
 <54561E45.7000404@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34609 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752910AbaKJRtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 12:49:32 -0500
Content-Disposition: inline
In-Reply-To: <54561E45.7000404@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [141102 04:08]:
> On 11/02/14 13:19, Dmitry Lifshitz wrote:
> > Add DSS related pinmux and display data nodes required to support
> > DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
> > 
> > Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks applying into omap-for-v3.19/dt.

Are we now ready to drop the board-cm-*.c files?

Regards,

Tony
