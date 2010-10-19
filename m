From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/4] Horray, more CBUS patches
Date: Tue, 19 Oct 2010 10:38:07 +0300
Message-ID: <20101019073807.GA12470@legolas.emea.dhcp.ti.com>
References: <1287473358-25634-1-git-send-email-balbi@ti.com>
 <20101019103825.e7906b0b.jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933130Ab0JSHiX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:38:23 -0400
Content-Disposition: inline
In-Reply-To: <20101019103825.e7906b0b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Oct 19, 2010 at 02:38:25AM -0500, Jarkko Nikula wrote:
>On Tue, 19 Oct 2010 10:29:14 +0300
>Felipe Balbi <balbi@ti.com> wrote:
>
>> I believe now everything is fine. Still, it's only
>> compile tested with n770_defconfig and omap2plus_defconfig.
>>
>> Felipe Balbi (4):
>>   cbus: remove unneded includes
>>   cbus: retu: move platform_device to board file
>>   cbus: tahvo: move platform_device to board file
>>   cbus: tahvo-usb: move platform_device to board file
>>
>omap2plus_defconfig doesn't include CONFIG_CBUS(_x) so you must enable
>them manually.

I did that, don't worry

-- 
balbi
