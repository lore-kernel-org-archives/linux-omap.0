From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 3/4] OMAP3: PM debug: remove register dumping
Date: Mon, 30 May 2011 10:06:36 +0200
Message-ID: <BANLkTikfPgkk1ca=E3SyU7T8T6vABgAjtQ@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-4-git-send-email-khilman@ti.com>
	<4DE344D6.5070103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39419 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab1E3IGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 04:06:36 -0400
Received: by qyg14 with SMTP id 14so1822967qyg.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 01:06:36 -0700 (PDT)
In-Reply-To: <4DE344D6.5070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, p-titiano@ti.com

On Mon, May 30, 2011 at 9:18 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>>
>> Remove OMAP3-specific register dumping feature from PM debug layer.
>> This is removed because:
>>
>> - it's ugly
>> - it's OMAP3-specific, and will obviously not scale to OMAP4+
>> - userspace /dev/mem-based tools (like omapconf) can do this much be=
tter
>>
> Fully agree and indeed it doesn't scale for OMAP4.
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>

Ok. Same comment about the use of omaconf as a debug/investigation tool=
=2E
Acked-by: Jean Pihet <j-pihet@ti.com>

>
>
>
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
