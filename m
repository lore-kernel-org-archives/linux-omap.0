From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv2] i2c: omap: Move the remove constraint
Date: Thu, 15 Nov 2012 14:21:00 +0530
Message-ID: <CAM=Q2cvE2=c_L5YhkeXscx=2EfZp5MGtdnp6KowhwUQx_j1Muw@mail.gmail.com>
References: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
	<CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46702 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993193Ab2KOIvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 03:51:03 -0500
In-Reply-To: <CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de

On Thu, Nov 15, 2012 at 1:46 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Hi Shubhrajyoti,
>
> On Thu, Nov 15, 2012 at 8:34 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>> Currently we just queue the transfer and release the
>> qos constraints, however we donot wait for the transfer
> Typo: donot
Just fixed and resent.

>
>> to complete to release the constraint. Move the remove
>> constraint after the bus busy as we are sure that the
>> transfers are completed by then.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Looks good!
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks for review.

>
> Regards,
> Jean
>
