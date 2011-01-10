From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes
Date: Mon, 10 Jan 2011 13:13:17 -0600
Message-ID: <4D2B5A4D.5000300@ti.com>
References: <1294441282-17986-1-git-send-email-nm@ti.com> <20110110190436.GE4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43557 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752503Ab1AJTNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 14:13:25 -0500
Received: by mail-vw0-f43.google.com with SMTP id 17so7959064vws.16
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 11:13:22 -0800 (PST)
In-Reply-To: <20110110190436.GE4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

Tony Lindgren had written, on 01/10/2011 01:04 PM, the following:
> * Nishanth Menon <nm@ti.com> [110107 15:00]:
>> Hi,
>> As discussed in the threads:
>> http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
>> http://marc.info/?t=121540030800004&r=1&w=2
>>
>> here is the split up series with commit message after discussion:
>> http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21
>>
>> Koen Kooi (3):
>>   omap3: beaglexm: fix EHCI power up GPIO dir
>>   omap3: beaglexm: fix DVI reset GPIO
>>   omap3: beaglexm: fix power on of DVI
> 
> Dropping the earlier versions from omap-fixes, I want to get the
> build fixes in ASAP. These can wait a bit until Aaro's comments
> are addressed.
Ack. will post a v5 after aligning. build breakages have higher priority 
ofcourse ;)

-- 
Regards,
Nishanth Menon
