From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] generic clk module removal
Date: Wed, 28 Apr 2010 08:55:10 -0500
Message-ID: <4BD83E3E.3000403@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com> <4BD790C1.6030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47595 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab0D1NzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 09:55:18 -0400
In-Reply-To: <4BD790C1.6030406@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 4/27/2010 8:34 PM, Nishanth Menon wrote:
> On 04/27/2010 08:29 PM, Omar Ramirez Luna wrote:
>> This set of patches remove clk module from the services layer.
>>
>> Now:
>> - GPT 5-8 are controlled through DM Timer framework.
>> - MCBSP clocks are enabled by requesting the proper mcbsp device.
>> - WDT is left for bridge driver to control rather than on request from dsp.
>> - SSI is controlled by enabling/disabling its sst, ssr and ick clocks.
>>
>> v2:
>> - rebased
>> - keep iva2 handling as it is advised to turn off the clocks for iva reset
>>     sources.
>> - release all the clocks (disable&   free) if driver is uninstalled.
>>
>>
[...]
> is there a series numbering for this patchset?

wrong sed substitution command to place "v2" :/

I will resend.

- omar

