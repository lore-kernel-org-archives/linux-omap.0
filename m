From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Fri, 26 Nov 2010 11:56:35 +0200
Message-ID: <4CEF8453.3070904@nokia.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <20101125161112.GB15099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:64739 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab0KZJ6r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 04:58:47 -0500
In-Reply-To: <20101125161112.GB15099@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

On 11/25/2010 06:11 PM, ext Mark Brown wrote:
> On Thu, Nov 25, 2010 at 05:52:23PM +0200, Srikar wrote:
>
>> +static struct regulator_consumer_supply rx51_vdac_supply[] = {
>> +	{
>> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
> The ifdefs here aren't really saving much...
Currently rx51_display_device is defined under same
ifdefs(CONFIG_FB_OMAP2,CONFIG_FB_OMAP2_MODULE)
 as extern and also in board-rx51-video.c display devices are under same
ifdefs,So used to  not
break compilation when CONFIG_FB_OMAP2,CONFIG_FB_OMAP2_MODULE not defined.
>> +		.supply	= "vdda_dac",
>> +		.dev	= &rx51_display_device.dev,
> dev_name is preferred, though I'm not sure if we'll ever get round to
> phasing out plain dev.
Currently difficult to use .dev_name .
