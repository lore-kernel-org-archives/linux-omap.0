From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3] OMAP: DSS2: Support for UMSH-8173MD TFT panel
Date: Tue, 03 Jan 2012 11:36:59 +0100
Message-ID: <4F02DA4B.8020205@gmail.com>
References: <1324370436.2042.4.camel@deskari>  <1324374872-5132-1-git-send-email-zonque@gmail.com> <1325582515.1973.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63414 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2ACKhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 05:37:04 -0500
Received: by eekc4 with SMTP id c4so15782735eek.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 02:37:02 -0800 (PST)
In-Reply-To: <1325582515.1973.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On 01/03/2012 10:21 AM, Tomi Valkeinen wrote:
> On Tue, 2011-12-20 at 10:54 +0100, Daniel Mack wrote:
>> This patch adds support for Microtip Technologies' UMSH-8173MD 800x480
>> RGB TFT panel. Tested with an OMAP3 board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> ---
>>  drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
>>  1 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
>> index 519c47d..cbcf164 100644
>> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
>> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
>> @@ -297,6 +297,31 @@ static struct panel_config generic_dpi_panels[] = {
>>  
>>  		.name			= "apollon",
>>  	},
>> +
>> +	/* Microtips Technologies - UMSH-8173MD */
>> +	{
>> +		{
>> +			.x_res		= 800,
>> +			.y_res		= 480,
>> +
>> +			.pixel_clock	= 34560,
>> +
>> +			.hsw		= 13,
>> +			.hfp		= 101,
>> +			.hbp		= 101,
>> +
>> +			.vsw		= 23,
>> +			.vfp		= 1,
>> +			.vbp		= 1,
>> +		},
>> +		.acbi			= 0x0,
>> +		.acb			= 0x0,
>> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
>> +		.power_on_delay		= 0,
>> +		.power_off_delay	= 0,
>> +		.name			= "UMSH-8173MD",
> 
> Looks fine, except the panel name is not in line with the other panel
> names. I suggest "microtips_umsh_8173md". I can apply the patch and
> make the change if you are ok with the name.

Yes, please do! :)


Thanks,
Daniel
