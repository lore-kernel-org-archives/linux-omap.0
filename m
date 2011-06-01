From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 1/3] OMAP2+: Fix debug section mistmatch warnings
Date: Wed, 1 Jun 2011 13:01:04 +0530
Message-ID: <BANLkTintdDG33LnfLMjGnDkp5_17qZc+nw@mail.gmail.com>
References: <1306907896-28789-1-git-send-email-govindraj.raja@ti.com> <20110601071359.GV11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62772 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab1FAHbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 03:31:25 -0400
Received: by bwz15 with SMTP id 15so4298660bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Jun 2011 00:31:24 -0700 (PDT)
In-Reply-To: <20110601071359.GV11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Nishant Kamat <nskamat@ti.com>

On Wed, Jun 1, 2011 at 12:43 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Govindraj.R <govindraj.raja@ti.com> [110531 22:54]:
>> Fix the below debug section mismatch warnings.
>> while compiling kernel with CONFIG_DEBUG_SECTION_MISMATCH=3Dy
>>
>> WARNING: vmlinux.o(.data+0x38638): Section mismatch in reference fro=
m the
>> variable serial*_data to the (unknown reference) .init.data:(unknown=
)
>> The variable serial*_data references
>> the (unknown reference) __initdata (unknown)
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the va=
riable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> These should be already fixed by an earlier patch. Can you please
> check against our devel-fixes branch?

Yes this is already fixed. Sorry for the noise.

--
Thanks,
Govindraj.R

>
> Tony
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
