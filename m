From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 41/41] ARM: OMAP3: use DT clock init if DT data is
 available
Date: Wed, 27 Nov 2013 11:06:52 +0200
Message-ID: <5295B62C.8090209@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-42-git-send-email-t-kristo@ti.com> <20131126174455.GF26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34997 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab3K0JHW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 04:07:22 -0500
In-Reply-To: <20131126174455.GF26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/26/2013 07:44 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131126 00:10]:
>> OMAP3 platforms support both DT and non-DT boot at the moment, make
>> the clock init work according to the used setup.
>
> We're making omap3 to be DT only as well, so it might make sense to
> drop the omap3 clock data as well while at it. Or do it later to
> avoid adding dependencies, up to you.

Ok, I can remove it with next rev if you like.

-Tero
