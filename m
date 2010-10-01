From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] omap: zoom2: fix build break when CONFIG_WL12XX_PLATFORM_DATA=n
Date: Sat, 2 Oct 2010 01:09:16 +0200
Message-ID: <AANLkTikuHYbj0mq8df8jHQ3Wkh0ps2SOoaOkrrXOeax=@mail.gmail.com>
References: <1285965236-17907-1-git-send-email-gadiyar@ti.com>
 <AANLkTi=+dtqdZLb8rfu8NZRU5GceUL5+S3B=MeW1xF=M@mail.gmail.com> <cf2c8b9dc6762d53dcaf522d874cb37b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60457 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab0JAXJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:09:37 -0400
In-Reply-To: <cf2c8b9dc6762d53dcaf522d874cb37b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Oct 2, 2010 at 1:02 AM, Anand Gadiyar <gadiyar@ti.com> wrote:
> I picked up your patch and the warnings are gone. The key difference
> was I missed marking the alternative function as an inline.

Ok, thanks for the update.


>
> Without that, I was seeing warnings like these:
> include/linux/wl12xx.h:42: warning: 'wl12xx_set_platform_data' defined but
> not used
>
> - Anand
>
