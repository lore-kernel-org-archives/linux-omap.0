From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Thu, 01 Apr 2010 16:42:00 +0300
Message-ID: <1270129320.2704.114.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54845 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab0DANmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 09:42:54 -0400
In-Reply-To: <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> In case of 720P with 90/270 degree rotation, the system reports
> GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able to fill
> the FIFO as per requirement.
> 
> In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> 
> "To improve the performance on 90 degree rotation, split the data access on
> write side and not read side."
> 
> That means, read should always happen on 0 degree and write should go to
> respective rotation view.

I haven't had time to look at this patch yet. I'll try to do it next
week.

However, I knew that TRM text when I was writing the code. The reason I
chose to use 0 degree view for omapfb and change the view from DSS side
was that it was difficult to handle mmapped areas in this case, if I
recall right. I have to say I don't exactly remember what the problems
were, so I need to read the code and think about this again.

Hmm, perhaps it was so that if you choose to change omapfb's VRFB view,
you can only do that if nothing is mmapped. Which means that either you
can only use one rotation angle defined at boot time, or you need
carefully to remove all mmappings, including fb console, then change the
view and recreate the mapping. And one requirement was that the rotation
should be changeable at runtime, which made the select the current
approach.

 Tomi


