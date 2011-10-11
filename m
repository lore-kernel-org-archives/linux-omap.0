From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract regulator_init_data
Date: Tue, 11 Oct 2011 11:29:29 +0530
Message-ID: <4E93DB41.2080900@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com> <1318263578-7407-4-git-send-email-rnayak@ti.com> <20111010172222.GG3607@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38521 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317Ab1JKF7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 01:59:38 -0400
In-Reply-To: <20111010172222.GG3607@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org

On Monday 10 October 2011 10:52 PM, Mark Brown wrote:
> On Mon, Oct 10, 2011 at 09:49:36PM +0530, Rajendra Nayak wrote:
>
>> +- regulator-change-voltage: boolean, Output voltage can be changed by software
>> +- regulator-change-current: boolean, Output current can be chnaged by software
>> +- regulator-change-mode: boolean, Operating mode can be changed by software
>> +- regulator-change-status: boolean, Enable/Disable control for regulator exists
>> +- regulator-change-drms: boolean, Dynamic regulator mode switching is enabled
>> +- regulator-mode-fast: boolean, allow/set fast mode for the regulator
>> +- regulator-mode-normal: boolean, allow/set normal mode for the regulator
>> +- regulator-mode-idle: boolean, allow/set idle mode for the regulator
>> +- regulator-mode-standby: boolean, allow/set standby mode for the regulator
>> +- regulator-input-uV: Input voltage for regulator when supplied by another regulator
>> +- regulator-always-on: boolean, regulator should never be disabled
>
> Thinking about this I'm not sure that these should go in the device
> tree, they're as much talking about what Linux is able to cope with as
> they are talking about what the hardware is able to do.  Sometimes
> they'll be fixed by the design but they are sometimes also restricted by
> what the software is currently capable of.  DRMS is a prime example
> here, it depends on how good we are at telling the API about how much
> current we're using.

So is there another way of passing these, if not through device tree?
There are other linux specific things that need to be passed to the
framework as well, like the state of the regulator in the various
linux specific suspend states, like standby/mem/disk.
So if these can't be passed through device tree, should they still
be passed in some way through platform_data? Or is it best to identify
the bindings as being linux specific and not generic by appending a
"linux," to the bindings.

Grant, need some help and advice.

