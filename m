From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 14:52:05 +0100
Message-ID: <4F4B8A85.7060603@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com> <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com> <20120227134112.GB3191@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37342 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2B0NwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 08:52:20 -0500
In-Reply-To: <20120227134112.GB3191@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, tony@atomide.com
Cc: Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lrg@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org

Hi Mark,

On 2/27/2012 2:41 PM, Mark Brown wrote:
> On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:
>
>> Depending on what order Mark happens to pull them in, I am fine
>> re-sending adding support for the 2 twl6030 fixed regulators.
>
> Please can you guys come up with a single unified series for this stuff
> - I'll hold off on applying anything to allow you to do this.

The issue is that the initial TWL regulator series from Rajendra will 
depend on the twl core DT support I have that depends on the irq_domain 
series from Grant...

So I guess, it will be easy for us to split the regulator patches from 
the DTS ones to have at least the driver changes merged by you. Then 
Tony might be able to pull all the DTS in one series and thus avoid the 
various merge conflict that will happen since most OMAP drivers are 
hacking the same DTS files.

Does that make sense? Or do you think it will be even worst separating 
the patches?

Thanks,
Benoit
