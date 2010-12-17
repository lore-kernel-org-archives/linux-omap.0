From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/7] OMAP3: remove unused code from the ASM sleep code
Date: Fri, 17 Dec 2010 07:18:08 -0600
Message-ID: <4D0B6310.2010104@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53533 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754289Ab0LQNSM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 08:18:12 -0500
Received: by mail-yx0-f179.google.com with SMTP id 7so360376yxs.24
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 05:18:11 -0800 (PST)
In-Reply-To: <1292580506-4421-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Remove unused code:
> - macros,
> - variables,
> - unused semaphore locking API. This API shall be added back
>   when needed,
> - infinite loops for debug.
> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon<nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933


-- 
Regards,
Nishanth Menon
