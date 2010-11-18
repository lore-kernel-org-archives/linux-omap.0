From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP MUX framework changes
Date: Thu, 18 Nov 2010 22:01:55 +0100
Message-ID: <4CE59443.3000401@ti.com>
References: <1290017211-2217-1-git-send-email-dmurphy@ti.com> <20101118175714.GF9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620Ab0KRVB4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 16:01:56 -0500
In-Reply-To: <20101118175714.GF9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Tony,

On 11/18/2010 6:57 PM, Tony Lindgren wrote:
> Hi Dan,

[...]

> Can you please make this into a separate patch. And instead of
> indenting the code more, just do something like:
>
> 	if (!partition)
> 		return -EINVAL;

Do you want me to merge that in my current OMAP4 series branch?

Regards,
Benoit
