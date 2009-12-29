From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ehci: fix missing kfree in remove path also
Date: Tue, 29 Dec 2009 14:50:53 +0200
Message-ID: <20091229125053.GB17147@nokia.com>
References: <1260970570-28536-1-git-send-email-ajay.gupta@ti.com>
 <20091228234218.GS3512@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25849 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZL2M5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 07:57:44 -0500
Content-Disposition: inline
In-Reply-To: <20091228234218.GS3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Tue, Dec 29, 2009 at 12:42:18AM +0100, ext Tony Lindgren wrote:
>* Ajay Kumar Gupta <ajay.gupta@ti.com> [091216 05:35]:
>> Added missing kfree() in ehci_hcd_omap_remove().
>
>This should get merged via linux-usb list.

it was sent to Greg already, thanks

-- 
balbi
