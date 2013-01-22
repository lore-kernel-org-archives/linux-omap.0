From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/5] ARM: dts: twl6030: Add PWM support
Date: Tue, 22 Jan 2013 11:54:36 +0100
Message-ID: <50FE6FEC.70905@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com> <1358519794-13214-3-git-send-email-peter.ujfalusi@ti.com> <50FE6C5E.50802@ti.com> <50FE6EB7.8070605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36417 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab3AVKyp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jan 2013 05:54:45 -0500
In-Reply-To: <50FE6EB7.8070605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 01/22/2013 11:49 AM, Peter Ujfalusi wrote:
> HI Benoit,
> 
> On 01/22/2013 11:39 AM, Benoit Cousson wrote:
>>> +
>>> +	twl_pwm: pwm {
>>> +		/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
>>> +		compatible = "ti,twl6030-pwm";
>>> +		#pwm-cells = <2>;
>>> +	};
>>> +
>>> +	twl_pwmled: pwmled {
>>> +		/* provides one PWM (id 0 for Charing indicator LED) */
>>
>> typo: charging.
> 
> Aargh. Corrected in the branch.

Thanks,

Pulled and pushed into git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.9/dts

Regards,
Benoit

