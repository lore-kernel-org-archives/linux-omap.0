From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 5/6] usb: ohci: don't hard-code TLL channel count
Date: Thu, 19 Aug 2010 10:23:12 +0300
Message-ID: <20100819072312.GV4385@nokia.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-5-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-6-git-send-email-keshava_mgowda@ti.com>
 <20100819060308.GT4385@nokia.com>
 <0680EC522D0CC943BC586913CF3768C003B39A33E9@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49912 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0HSHXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 03:23:39 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B39A33E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

please teach your mailer to break the lines at 80 characters.

On Thu, Aug 19, 2010 at 08:26:06AM +0200, ext Munegowda, Keshava wrote:
>The function ohci_omap3_tll_config will be used with different tll 
>channel count in case of OMAP4 support soon, hence this change is 
>required.  We have removed only the hardcoded values used by this 
>function.

ok then. That's what I expected to hear.

-- 
balbi

DefectiveByDesign.org
