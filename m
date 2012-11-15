From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv2] i2c: omap: Move the remove constraint
Date: Thu, 15 Nov 2012 09:53:35 +0100
Message-ID: <CAORVsuUE0pdmVyWO5-7TGZn=-XDib1jqbEVRK7Bmhj9bx_HGQQ@mail.gmail.com>
References: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
	<CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
	<CAM=Q2cvE2=c_L5YhkeXscx=2EfZp5MGtdnp6KowhwUQx_j1Muw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52690 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992946Ab2KOIxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 03:53:36 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1939654iea.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 00:53:36 -0800 (PST)
In-Reply-To: <CAM=Q2cvE2=c_L5YhkeXscx=2EfZp5MGtdnp6KowhwUQx_j1Muw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de

On Thu, Nov 15, 2012 at 9:51 AM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
> On Thu, Nov 15, 2012 at 1:46 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>> Hi Shubhrajyoti,
>>
>> On Thu, Nov 15, 2012 at 8:34 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>>> Currently we just queue the transfer and release the
>>> qos constraints, however we donot wait for the transfer
>> Typo: donot
> Just fixed and resent.
>
>>
>>> to complete to release the constraint. Move the remove
>>> constraint after the bus busy as we are sure that the
>>> transfers are completed by then.
>>>
>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> Looks good!
>> Acked-by: Jean Pihet <j-pihet@ti.com>
>
> Thanks for review.

Thanks!

Regards,
Jean

>
>>
>> Regards,
>> Jean
>>
