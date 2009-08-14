From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [Fwd: patch usb-ehci-ensure-all-watchdog-timer-events-are-deleted-when-suspending-usb.patch
 added to gregkh-2.6 tree]
Date: Fri, 14 Aug 2009 13:44:39 -0500
Message-ID: <4A85B097.1080205@ti.com>
References: <4A85A18F.4040207@ti.com> <878whm8dfu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33141 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbZHNSop (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Aug 2009 14:44:45 -0400
In-Reply-To: <878whm8dfu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Kevin Hilman wrote:
> Jon,
> 
> Do you know if this will be queued as a fix for .31?  or if it will wait
> for the .32 merge window.
> 
> Kevin

I am not sure. I was just browsing Greg's page and I found the following 
text file.

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/series

Here Greg has a list of patches for .31. This patch is not part of what 
he has planned for .31. The patch is listed under "USB stuff  (after 
2.6.30 is out)", however, I believe that this is a typo, as this is 
under the main heading "Stuff to be merged after 2.6.31 is out". So I 
would presume this would come after .31 in .32 if there are no issues.

Cheers
Jon



