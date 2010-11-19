From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] omap: nand: remove hardware ECC as default
Date: Fri, 19 Nov 2010 12:44:07 +0200
Message-ID: <AANLkTik8rX+wYWQ8VmRGb6cxZrUHQmoPm5mGOvk=Z80j@mail.gmail.com>
References: <1290090130-20835-1-git-send-email-s-ghorai@ti.com>
	<20101118180137.GG9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34999 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0KSKoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:44:08 -0500
Received: by qwd7 with SMTP id 7so58945qwd.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:44:08 -0800 (PST)
In-Reply-To: <20101118180137.GG9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sukumar Ghorai <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Charles Manning <manningc2@actrix.gen.nz>

On Thu, Nov 18, 2010 at 8:01 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Sukumar Ghorai <s-ghorai@ti.com> [101118 06:12]:
>> CONFIG_MTD_NAND_OMAP_HWECC defined wronly in patch submitted during =
2.6.36
>> that using the hardware ECC by default

wrongly

>>
>> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>> ---
>> =A0drivers/mtd/nand/omap2.c | =A0 =A01 -
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index cd41c58..15682ec 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -7,7 +7,6 @@
>> =A0 * it under the terms of the GNU General Public License version 2=
 as
>> =A0 * published by the Free Software Foundation.
>> =A0 */
>> -#define CONFIG_MTD_NAND_OMAP_HWECC
>>
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/dma-mapping.h>
>
> This looks like a fix for the -rc cycle. Can you please update
> the description a bit to specify which commit broke it and
> what the error is now?

Well it broke NAND for beagle and pandora at least, as those have been
using sw ecc, all IO simply results in ECC errors with that define.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
