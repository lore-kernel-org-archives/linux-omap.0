From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 1/2] omap: mcbsp: Drop SPI mode support
Date: Tue, 14 Jun 2011 15:38:41 +0300
Message-ID: <6027329.5ZCJWRgjcM@barack>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab1FNMio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:38:44 -0400
In-Reply-To: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

On Tuesday 14 June 2011 13:23:51 Jarkko Nikula wrote:
> We haven't seen any use for the SPI API in McBSP driver over the years. More
> over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode is not
> even supported since OMAP2430 so it's very unlikely that we'll see any use
> for it in the future either.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Either now or later, but for both:

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

