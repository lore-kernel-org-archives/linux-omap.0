From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Mon, 10 Mar 2014 18:05:35 +0200
Message-ID: <531DE2CF.7060708@ti.com>
References: <cover.1394440470.git.jsarha@ti.com> <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com> <20140310125848.GI28112@sirena.org.uk> <531DBD55.6030008@ti.com> <20140310154744.GJ28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60733 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbaCJQFp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 12:05:45 -0400
In-Reply-To: <20140310154744.GJ28112@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

On 03/10/2014 05:47 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 03:25:41PM +0200, Jyri Sarha wrote:
>> On 03/10/2014 02:58 PM, Mark Brown wrote:
>>> On Mon, Mar 10, 2014 at 10:52:21AM +0200, Jyri Sarha wrote:
...
>
>> I agreed on not to have it as the default. I can still imagine
>> couple of reason to have this option around. For instance, if the
>> board designer decides to pull the bias voltage from outside of the
>> chip completely, or like in my test setup when I feed the mic input
>> from a headset output of another device, because I do not have a
>> microphone around ATM.
>
> To repeat what I said first time around in those cases the pin wouldn't
> be connected at all so why would it ever be enabled?  You're not
> specifying that it's going to be always enabled at a given voltage.
>

What ever. My laptop headset output does not seem to mind about bias 
voltage being fed to it. In the first case the pin wouldn't be connected 
so it does not matter. I'll remove the option.

Best regards,
Jyri
