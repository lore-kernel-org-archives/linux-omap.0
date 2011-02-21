From: Johannes Reif <reif@corscience.de>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Mon, 21 Feb 2011 12:53:33 +0100
Message-ID: <4D62523D.5080203@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab1BULxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 06:53:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Mathieu Poirier <mathieu.poirier@canonical.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hello Venkat, Hello Mathieu,

>  No. I was working on some other things lately. What card are you using and
>  how often are you seeing this ?
>
>  Regards,
>  Venkat.

We get the timeout Problem every time:
[    1.888732] Waiting for root device /dev/mmcblk0p2...
[    4.193603] mmc0: error -110 whilst initialising SD card

Right now the issue occurs with following cards CONFIG_PREEMPT=y enabled:

- SanDisk 4GB micro SDHC Class 2
- SanDisk 2GB micro SD


These cards worked fine:

- Transcend 2GB micro SD
- Transcend 4GB micro SDHC Class 6
- SanDisk 4GB micro SDHC Class 6 (Mobile Ultra)


Thanks,
Johannes





