From: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: RE: [PATCH 0/3]OMAP4: Keypad support
Date: Tue, 15 Feb 2011 15:11:06 +0530
Message-ID: <194836c91e028071bd1db1dc6411935f@mail.gmail.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41570 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab1BOJlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 04:41:09 -0500
In-Reply-To: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Shubhrajyoti D <a0393217@india.ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,
Any comments on this series.

Thanking you,
With Regards,
Shubhro
> -----Original Message-----
> From: shubhrajyoti@ti.com [mailto:shubhrajyoti@ti.com]
> Sent: Monday, December 27, 2010 11:22 AM
> To: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Cc: Shubhrajyoti D
> Subject: [PATCH 0/3]OMAP4: Keypad support
>
> From: Shubhrajyoti D <a0393217@india.ti.com>
>
> Adding the keypad 4430sdp board support and PM runtime change.
> Tested on 4430sdp.
>
> Abraham Arce (1):
>   OMAP4:keypad: PM runtime
>
> Benoit Cousson (1):
>   OMAP4: hwmod data: Add keypad in the hwmod database
>
> Syed Rafiuddin (1):
>   OMAP4: keypad: Add the board support.
>
>  arch/arm/mach-omap2/board-4430sdp.c        |   89
> ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/devices.c              |   41 +++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70
++++++++++++++++++++++
>  drivers/input/keyboard/omap4-keypad.c      |    8 +++
>  4 files changed, 208 insertions(+), 0 deletions(-)
