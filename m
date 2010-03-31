From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
 method
Date: Wed, 31 Mar 2010 19:29:09 +0300
Message-ID: <20100331162909.GA23490@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
 <20100331162158.GB32025@rakim.wolfsonmicro.main>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51922 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0CaQ3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 12:29:51 -0400
Content-Disposition: inline
In-Reply-To: <20100331162158.GB32025@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Mar 31, 2010 at 06:21:58PM +0200, ext Mark Brown wrote:
>On Wed, Mar 31, 2010 at 06:35:10PM +0300, Felipe Balbi wrote:
>> +	if (debounce) {
>> +		val |= l;
>> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
>> +			clk_enable(bank->dbck);
>> +	} else {
>> +		val &= ~l;
>> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
>> +			clk_disable(bank->dbck);
>> +	}
>
>Will these do the right thing with the clocks for noop transitions or
>tweaks to the debounce time?  I'm not familiar with the OMAP clock
>framework, it could handle this.

good catch. We need to be a bit smarter here. I'll leave that for 
tomorrow. already 19:30 :-p

maybe adding a flag to gpio_bank that gets set when we first enable the 
debounce clock and then we:

if (debounce) {
	if (!bank->dbck_enabled && (cpu_is_omap34xx() || cpu_is_omap44xx())) {
		clk_enable(bank->dbck);
		bank->dbck_enabled = true;
	}
} else {
	if (bank->dbck_enabled && (cpu_is_omap34xx() || cpu_is_omap44xx())) {
		clk_enable(bank->dbck);
		bank->dbck_enabled = false;
	}
}

-- 
balbi
