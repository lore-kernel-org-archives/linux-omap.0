From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 11/15] OMAP: DSS2: omapfb driver
Date: Fri, 07 Aug 2009 14:52:23 +0300
Message-ID: <4A7C1577.2050408@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <4A7C145B.20800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26942 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbZHGLwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 07:52:46 -0400
In-Reply-To: <4A7C145B.20800@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (EXT-Teleca/Helsinki)" <ext-roger.quadros@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Quadros Roger (EXT-Teleca/Helsinki) wrote:
>> diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
>> index 244b80d..89bf210 100644
>> --- a/drivers/video/omap2/Kconfig
>> +++ b/drivers/video/omap2/Kconfig
> 
> This file does not exist in linus' tree or linux-omap so it fails to apply as it 
> does not have 'new file node' attribute
> 
>> @@ -1,2 +1,3 @@
>>  source "drivers/video/omap2/dss/Kconfig"
>>  source "drivers/video/omap2/displays/Kconfig"
>> +source "drivers/video/omap2/omapfb/Kconfig"
>> diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
>> index 2d2c83e..0c0414f 100644
>> --- a/drivers/video/omap2/Makefile
>> +++ b/drivers/video/omap2/Makefile
> 
> ditto
> 
>> @@ -1,2 +1,3 @@
>>  obj-y += dss/
>>  obj-y += displays/
>> +obj-y += omapfb/
> 

You need to apply the patches in order. Those files, and the files 
needed by panel drivers patch, are created in

[PATCH 06/15] OMAP: DSS2: Display Subsystem

  Tomi
