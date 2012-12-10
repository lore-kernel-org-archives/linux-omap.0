From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 01/23] mfd: omap-usb-host: get rid of cpu_is_omap..()
 macros
Date: Mon, 10 Dec 2012 11:34:53 +0200
Message-ID: <50C5ACBD.50105@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com> <1354630396-24545-2-git-send-email-rogerq@ti.com> <20121205184217.GK21682@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2LJJfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 04:35:19 -0500
In-Reply-To: <20121205184217.GK21682@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 12/05/2012 08:42 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [121204 06:15]:
>> Instead of using cpu_is_omap..() macros in the device driver we
>> rely on information provided in the platform data.
>>
>> The only information we need is whether the USB Host module has
>> a single ULPI bypass control bit for all ports or individual bypass
>> control bits for each port. OMAP3 REV2.1 and earlier have the former.
> 
> Thanks for moving this one earlier in the series. Looks like
> you're missing Samuel as the MFD maintainer from your cc.
> You should resend again with Samuel Ortiz <sameo@linux.intel.com>
> added.
> 
> Maybe check the patches in this series with scripts/get_maintainer.pl
> to see who all should be cc:ed?
> 

OK, I'll resend this series with appropriate maintainers in cc.

regards,
-roger
