From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 28 Apr 2010 14:02:45 +0300
Message-ID: <h2hda15981b1004280402vbd5f9433g7e51d2b039de5936@mail.gmail.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-5-git-send-email-ohad@wizery.com> <20100428.085624.183054155.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:34937 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0D1LDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 07:03:07 -0400
Received: by gxk9 with SMTP id 9so1759448gxk.8
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 04:03:05 -0700 (PDT)
In-Reply-To: <20100428.085624.183054155.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

On Wed, Apr 28, 2010 at 8:56 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: [PATCH 4/4] omap: mailbox: convert block api to kfifo
> Date: Tue, 27 Apr 2010 19:56:22 +0200
>
>> The underlying buffering implementation of mailbox
>> is converted from block API to kfifo due to the simplicity
>> and speed of kfifo.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A05 +-
>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0108 =
+++++++++++++----------------
>> =A02 files changed, 52 insertions(+), 61 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pl=
at-omap/include/plat/mailbox.h
>> index 729166b..014cc58 100644
>> --- a/arch/arm/plat-omap/include/plat/mailbox.h
>> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
>> @@ -7,6 +7,7 @@
>> =A0#include <linux/workqueue.h>
>> =A0#include <linux/blkdev.h>
>
> Also the above is not necessary?

Good point. It will be removed.

Thanks,
Ohad.

>
>> =A0#include <linux/interrupt.h>
>> +#include <linux/kfifo.h>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
