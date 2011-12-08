From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 14:16:10 -0600
Message-ID: <CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52555 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1LHUQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 15:16:12 -0500
Received: by mail-fx0-f49.google.com with SMTP id s1so780050fab.22
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 12:16:11 -0800 (PST)
In-Reply-To: <CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 2:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Given that dm timer framework doesn't support request of clocks
>> by soft | hard irqs because some recent changes, tidspbridge needs
>> to request its clocks on init and enable/disable them on demand.
>>
>> This was first seen on 3.2-rc1.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Tested-by: Felipe Contreras <felipe.contreras@gmail.com>
> Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

Thanks!

> Something the commit message didn't mention is that this fixes a nasty
> continuous loop that happens as soon as you load the module.

Indeed.

> Definitely 3.2-fix material IMO :)

I believe it was pushed to staging-next... I'm rooting so it can be
pushed to staging-linus :)

Regards,

Omar
