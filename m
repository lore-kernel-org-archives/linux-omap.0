From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 8 Aug 2013 07:26:48 -0500
Message-ID: <52038E88.2050604@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-9-git-send-email-d-gerlach@ti.com> <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab3HHM1R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 08:27:17 -0400
In-Reply-To: <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

On 08/08/2013 03:45 AM, Russ Dill wrote:
>   In reference to
> the M3 handling it, the M3 wouldn't know which devices have a driver
> bound and which don't.
Does it need to? M3 firmware can pretty much define "I will force the 
device into low power state, and if the drivers dont handle things 
properly, fix the darned driver". M3 behavior should be considered as a 
"hardware" as far as Linux running on MPU is concerned, and firmware 
helps change the behavior by accounting for SoC quirks. *if* we have 
ability to handle this in the firmware, there is no need to carry this 
in Linux.

-- 
Regards,
Nishanth Menon
