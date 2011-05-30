From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Mon, 30 May 2011 09:59:01 +0200
Message-ID: <BANLkTiks+fenCyB315j0a5pDmc0-aw2ZdA@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-2-git-send-email-khilman@ti.com>
	<4DE3441F.6070807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58718 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab1E3H7D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 03:59:03 -0400
Received: by qyk7 with SMTP id 7so684237qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 00:59:01 -0700 (PDT)
In-Reply-To: <4DE3441F.6070807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, p-titiano@ti.com

On Mon, May 30, 2011 at 9:15 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>>
>> Remove the OMAP-specific PM debug 'sleep_while_idle' feature which i=
s
>> currently available as an OMAP-specific debugfs entry.
>>
>> This duplicates existing ARM-generic functionality available as a
>> boot-time option using the boot cmdline option 'hohlt'.
>>
>> If runtime configuration of this is needed, then adding a debugfs
>> entry for the ARM-generic hlt/nohlt interface should be added.
>>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>
> This makes it easy for future OMAP PM code as well.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Agree!
Acked-by: Jean Pihet <j-pihet@ti.com>

>
> Regards
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
