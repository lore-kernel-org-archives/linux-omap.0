From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with
 partial activation
Date: Mon, 06 May 2013 17:12:05 +0100
Message-ID: <5187D655.1010402@kernel.org>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com> <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab3EFQMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 May 2013 12:12:05 -0400
In-Reply-To: <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Luebbe <jlu@pengutronix.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, rachna@ti.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On 05/06/2013 01:48 PM, Jan Luebbe wrote:
> Hi Pantelis,
> 
> while trying out your patch on a custom AM335x board, I noticed that the
> sysfs entries ware missing. This is fixed in the first patch, you might want
> to squash that into your original patch.
> 
> The second one makes sure that the iio framework does not read invalid data.
> 
> Regards,
> Jan

I don't believe Pantelis ever came back with a response to the various issues
raised with the original patches?

If Pantelis has moved on, Jan feel free to pick up the patches, respin them
and resend to linux-iio if you like (with appropriate crediting naturally)

Until these are appropriately fixed up and resent, I'm lazy so will ignore these.
(your patches look reasonable to me based on a really superficial look)

Jonathan
