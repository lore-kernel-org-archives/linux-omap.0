From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v2 0/6] Introduce support for TI816X processor series
Date: Wed, 11 Aug 2010 20:32:14 +0300
Message-ID: <20100811173214.GC21391@nokia.com>
References: <1281546621-11348-1-git-send-email-hemantp@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:36205 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550Ab0HKRbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 13:31:52 -0400
Content-Disposition: inline
In-Reply-To: <1281546621-11348-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hemant Pedanekar <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi,

On Wed, Aug 11, 2010 at 07:10:21PM +0200, ext Hemant Pedanekar wrote:
>This patch series adds support for TI816X processor series. First device in this
>series is DM8168 and details can be found at:
>
>http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
>
>This device is architecturally closer to the OMAP devices. Hence, these patches
>are being submitted on linux-omap.

Yeah, I was wondering why is this coming to linux-omap tree. What's the 
actual core in it ? Is it based on some OMAP revision instead ? It would 
be cool to know what's similar and what's difference between e.g. 
omap3430 and ti816x or to which omap revision is this being compared to.

I believe Tony will have more comments to this ?!?

-- 
balbi

DefectiveByDesign.org
