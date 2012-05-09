From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Wed, 9 May 2012 14:36:17 +0530
Message-ID: <CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-3-git-send-email-r.sricharan@ti.com>
	<20120504223933.GX5613@atomide.com>
	<CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
	<20120507173351.GB5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51755 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758864Ab2EIJG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 05:06:29 -0400
Received: by lbbgm6 with SMTP id gm6so32397lbb.33
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 02:06:17 -0700 (PDT)
In-Reply-To: <20120507173351.GB5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Tony,

[snip]
>> >> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) |=
| =A0 =A0\
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 defined(CONFIG_ARCH_OMAP3))
>> >> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) &=
& \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 !(defined(CONFIG_ARCH_OMAP2) || defined=
(CONFIG_ARCH_OMAP3))
>> >> +
>> >> =A0static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>> >> =A0{
>> >> =A0 =A0 =A0 WARN(1, "prm: omap2xxx/omap3xxx specific function and=
 "
>> >
>> > Maybe these functions could be just set up as __weak to avoid the
>> > ifdeffery?
>> >
>> =A0sorry to understand,
>> =A0you mean make this weak and have a strong override for OMAP2 ?
>
> Yeah that should do the trick, right?
 Ok, There are multiple functions under that #ifdef.
 Also i see that __weak cannot be used for inline functions.
So should those functions should be moved to .c file and qualify them
 __weak. There is already a strong override for OMAP2 and 3 which
should not be a problem.

[OR]

 So after the cleanup patch introducing CONFIG_SOC_OMAP4PLUS
 it can be changed as
 #ifdef (CONFIG_SOC_OMAP4PLUS) && !(defined(CONFIG_ARCH_OMAP2) ||
defined(CONFIG_ARCH_OMAP3))

So this will avoid patching this for the future socs. ?

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
