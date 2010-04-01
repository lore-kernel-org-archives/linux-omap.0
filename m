From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 1 Apr 2010 14:36:53 +0300
Message-ID: <20100401113653.GM16297@nokia.com>
References: <20100329.120856.59654379.Hiroshi.DOYU@nokia.com>
 <20100401095203.GL31200@atomide.com>
 <20100401.132336.193692763.Hiroshi.DOYU@nokia.com>
 <20100401.142629.226796472.Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43109 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab0DALhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 07:37:38 -0400
Content-Disposition: inline
In-Reply-To: <20100401.142629.226796472.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "x0095840@ti.com" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

Hi,

On Thu, Apr 01, 2010 at 01:26:29PM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
>+static int __init omap24xx_init_devices(void)
>+{
>+	if (!cpu_is_omap24xx())
>+		return;

return 0
here.

>+static int __init omap44xx_init_devices(void)
>+{
>+	if (!cpu_is_omap44xx())
>+		return;

return 0
here too :-)

other than that, to me it looks a lot cleaner. Then we can start moving 
any other device registration that still lies in devices.c to the new 
files

-- 
balbi
