From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 15:17:21 -0700
Message-ID: <CACxGe6vU2dSpRrqd2y=ssgVsWuwpuvFtja9YcUAQA_ETWcwCYg@mail.gmail.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com> <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:56588 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116Ab2B0WRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 17:17:41 -0500
Received: by obcva7 with SMTP id va7so6029291obc.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 14:17:41 -0800 (PST)
In-Reply-To: <4F4B8A85.7060603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, tony@atomide.com, linaro-dev@lists.linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, Feb 27, 2012 at 6:52 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Mark,
>
>
> On 2/27/2012 2:41 PM, Mark Brown wrote:
>>
>> On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:
>>
>>> Depending on what order Mark happens to pull them in, I am fine
>>> re-sending adding support for the 2 twl6030 fixed regulators.
>>
>>
>> Please can you guys come up with a single unified series for this stuff
>> - I'll hold off on applying anything to allow you to do this.
>
>
> The issue is that the initial TWL regulator series from Rajendra will depend
> on the twl core DT support I have that depends on the irq_domain series from
> Grant...

If it depends on the irqdomain tree, then just merge that tree into
yours.  That tree is stable now for exactly that reason.  You can rely
on it.

git://git.secretlab.ca/git/linux-2.6 irqdomain/next

g.
