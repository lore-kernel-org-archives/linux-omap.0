From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Mon, 17 Jan 2011 15:01:28 +0100
Message-ID: <AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43915 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1AQOB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 09:01:29 -0500
Received: by qyj19 with SMTP id 19so1944153qyj.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 06:01:29 -0800 (PST)
In-Reply-To: <20110114173400.GB22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 6:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
>> Is the name 'omap_sram_push' wrong then?
>> What about the following?
>> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned lon=
g size)
>>
>> =A0 =A0 =A0 =A0omap_sram_ceil -=3D size;
>> =A0 =A0 =A0 =A0omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(=
void *));
>> =A0- =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
>> =A0- =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil,
>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(omap_sram_ceil + size))=
;
>>
>> =A0- =A0 =A0 return (void *)omap_sram_ceil;
>> =A0+ =A0 =A0return fncpy((void *)omap_sram_ceil, start, size);
>
> It's more correct, but still missing out on the type safety which we'=
ve
> tried to provide with fncpy.
IIUC the type of the function is propagated from the 2nd argument
(funcp) to the return value, which is fine here. The (void)* is here
only to avoid a warning thrown by memcpy.

>=A0Note also the other issue with Dave Martin
> has raised though - this isn't ready for merging yet.
Ok I am using the latest version now and will re-spin the patch.

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
