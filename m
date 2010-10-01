From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/4] CBUS patches
Date: Fri, 1 Oct 2010 11:03:23 +0300
Message-ID: <20101001080323.GK2925@legolas.emea.dhcp.ti.com>
References: <1285919238-26555-1-git-send-email-balbi@ti.com>
 <20101001074808.GJ2925@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38777 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab0JAIDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 04:03:22 -0400
Content-Disposition: inline
In-Reply-To: <20101001074808.GJ2925@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Oct 01, 2010 at 02:48:08AM -0500, Balbi, Felipe wrote:
>On Fri, Oct 01, 2010 at 02:47:14AM -0500, Balbi, Felipe wrote:
>>Hi Tony,
>>
>>removed a few unneeded includes and moved platform_device
>>registration to board file.
>>
>>ps: as usual, compile tested only :-p No working n810 available
>
>forgot to say, patches also available at:
>
>git://gitorious.org/usb/usb.git cbus

Jarkko Nikula reminded me about 770. It also has cbus so it's now
missing the platform_devices hehe. Sorry about that. Forget about these
patches.

-- 
balbi
