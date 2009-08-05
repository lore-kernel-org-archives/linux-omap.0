From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 13/15] OMAP: SDP: Enable DSS2 for OMAP3 SDP board
Date: Wed, 05 Aug 2009 17:48:37 +0300
Message-ID: <4A799BC5.4070906@nokia.com>
References: <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com> <20090805144052.GM7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28186 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934292AbZHEOtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:49:04 -0400
In-Reply-To: <20090805144052.GM7374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:

>> +
>> +static struct omap_dss_device sdp3430_lcd_device = {
>> +	.name = "lcd",
>> +	.driver_name = "sharp_ls_panel",
>> +	.type = OMAP_DISPLAY_TYPE_DPI,
>> +	.phy.dpi.data_lines = 16,
>> +	.platform_enable = sdp3430_panel_enable_lcd,
>> +	.platform_disable = sdp3430_panel_disable_lcd,
>>  };
> 
> Please check the formatting of data so they're tabbed.
> 

Do you mean something like:

static struct omap_dss_device sdp3430_lcd_device = {
	.name			= "lcd",
	.driver_name		= "sharp_ls_panel",


  Tomi
