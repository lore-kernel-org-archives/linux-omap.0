From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 0/2] ASoC: OMAP2+: Update Audio IP with sDMA binding
 for DT boot
Date: Fri, 15 Mar 2013 18:01:20 +0100
Message-ID: <514353E0.8020906@ti.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com> <51432FEE.4060709@ti.com> <20130315165609.GB8988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46358 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab3CORBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 13:01:44 -0400
In-Reply-To: <20130315165609.GB8988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Mark,

On 03/15/2013 05:56 PM, Mark Brown wrote:
> On Fri, Mar 15, 2013 at 03:27:58PM +0100, Benoit Cousson wrote:
> 
>> I've just applied it in my for_3.10/dts branch on top of Jon's series
>> that does add the SDMA binding.
> 
> The ASoC side doesn't build at present due to an unmerged dependency.

Oops, sorry my bad, in fact I've just applied the DTS patch. Seb told me
about that missing dependency.

Having the DTS without the ASoC change will do nothing, so it is fine
merging them separately.

Regards,
Benoit

