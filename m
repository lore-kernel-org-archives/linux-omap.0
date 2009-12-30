From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch-v2.6.34 8/9] arm: omap: musb: do not pass clock name to
 driver
Date: Wed, 30 Dec 2009 14:23:04 +0300
Message-ID: <4B3B3818.5030804@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com> <1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:59287 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750820AbZL3LX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 06:23:26 -0500
In-Reply-To: <1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hello.

Felipe Balbi wrote:

> we are using clkdev and the driver can use whatever
> name it wants.
>   

   It's not so actually. This depends on the matching mechanism 
established within clkdev: by device, by name, or by both. Not all 
implementations will match by device, e.g. DA8xx/OMAP-L1x will match by 
clock name.

WBR, Sergei


