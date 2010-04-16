From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH v6] board-omap3-beagle: add DSS2 support
Date: Fri, 16 Apr 2010 11:05:08 +0000
Message-ID: <4BC84464.7040909@corscience.de>
References: <1271321551-28634-1-git-send-email-koen@dominion.thruhere.net> <35BE594D-A567-4C77-A78C-58D20511533C@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56361 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757841Ab0DPJFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:05:36 -0400
In-Reply-To: <35BE594D-A567-4C77-A78C-58D20511533C@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>

Hello Koen,
On 04/16/10 08:38, Koen Kooi wrote:
> No more comments on this one? Can it go into Tony's tree now?
> 
> Op 15 apr 2010, om 10:52 heeft Koen Kooi het volgende geschreven:
> 
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
>>
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
>>
>> Changes since v1:
>>        * removed beagle_panel_enable_tv() and beagle_panel_disable_tv()
>> Changes since v2:
>>        * changed to REGULATOR_SUPPLY(_name, _dev_name) for dss regulators
>> Changes since v3:
>>        * really remove beagle_panel_enable_tv() and beagle_panel_disable_tv()
>>        * moved comments to this section
>> Changes since v4:
>>        * remove trailing whitespace
>> Changes since v5:
>>        * fix semicolon typo
>>
>> arch/arm/mach-omap2/board-omap3beagle.c |  102 ++++++++++++++++++++++--------
>> 1 files changed, 75 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 962d377..43d3e7d 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -39,6 +39,7 @@
>>
>> #include <plat/board.h>
>> #include <plat/common.h>
>> +#include <plat/display.h>
>> #include <plat/gpmc.h>
>> #include <plat/nand.h>
>> #include <plat/usb.h>
>> @@ -106,6 +107,77 @@ static struct platform_device omap3beagle_nand_device = {
>> 	.resource	= &omap3beagle_nand_resource,
>> };
>>
>> +/* DSS */
>> +
>> +static int beagle_enable_dvi(struct omap_dss_device *dssdev)
>> +{
>> +	if (dssdev->reset_gpio != -1)
>> +		gpio_set_value(dssdev->reset_gpio, 1);
There was already a comment about using gpio_is_valid(dssdev->reset_gpio)
>> +
>> +	return 0;
>> +}
>> +
>> +static void beagle_disable_dvi(struct omap_dss_device *dssdev)
>> +{
>> +	if (dssdev->reset_gpio != -1)
>> +		gpio_set_value(dssdev->reset_gpio, 0);
Here too.
Thomas
