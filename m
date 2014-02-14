From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Fri, 14 Feb 2014 15:47:57 +0200
Message-ID: <52FE1E8D.7010807@ti.com>
References: <52DE24DA.8050104@ti.com> <1390315061-14441-1-git-send-email-sre@debian.org> <20140213224914.GD28216@atomide.com> <20140214012546.GA7996@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52467 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbaBNNsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Feb 2014 08:48:11 -0500
In-Reply-To: <20140214012546.GA7996@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>, Tony Lindgren <tony@atomide.com>
Cc: mturquette@linaro.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On 02/14/2014 03:25 AM, Sebastian Reichel wrote:
> On Thu, Feb 13, 2014 at 02:49:14PM -0800, Tony Lindgren wrote:
>> * Sebastian Reichel <sre@debian.org> [140121 06:39]:
>>> update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
>>> to make them consistent for omap34xx and omap36xx. This makes it
>>> possible to reference the clocks from generic omap3 dts files.
>>
>> Is this needed as a fix for v3.14-rc? If so, please let me know
>> and ack if you want me to take it.
>
> The SSI driver will not arrive before 3.15 and 3.14 dts files do not
> contain any SSI nodes.
>
> Thus it should be enough to queue it for 3.15 if it goes via the
> same tree as the SSI dts patches.
>
> -- Sebastian
>

The patch itself looks good to me, so acked.

-Tero
