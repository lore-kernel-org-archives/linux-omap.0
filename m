From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: New compiler warnings with v3.5-rc
Date: Thu, 28 Jun 2012 15:15:39 +0530
Message-ID: <CANfBPZ8axAXpAnOcrDrnbXFwWONsvjFxmCP+eBkv0zb4QKufDA@mail.gmail.com>
References: <alpine.DEB.2.00.1206280244270.2338@utopia.booyaka.com> <1340874331.2059.86.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:47894 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165Ab2F1JqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:46:05 -0400
Received: by bkcji2 with SMTP id ji2so1843078bkc.5
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 02:46:01 -0700 (PDT)
In-Reply-To: <1340874331.2059.86.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, linux-omap@vger.kernel.org

On Thu, Jun 28, 2012 at 2:35 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Thu, 2012-06-28 at 02:47 -0600, Paul Walmsley wrote:
>> Hi Tero,
>>
>> there are some new compiler warnings added in the v3.5-rc kernels:
>>
>> arch/arm/mach-omap2/twl-common.c:51:12: warning: 'twl_set_voltage' d=
efined but not used
>> arch/arm/mach-omap2/twl-common.c:57:12: warning: 'twl_get_voltage' d=
efined but not used
>>
>> They only seem to appear on my N800 builds:
>>
>> http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/b=
uild/build_20120628011813_log.txt
>>
>> but it looks like I somehow am not doing a 2430-specific build yet, =
so
>> they may be 24xx-common.
>>
>> Anyway they were probably added by:
>>
>> commit 49c008ecce1f9a549c12e8957668d60008ab0d79
>> Author: Tero Kristo <t-kristo@ti.com>
>> Date: =A0 Mon Feb 20 12:26:08 2012 +0200
>>
>> =A0 =A0 arm: omap3: twl: add external controllers for core voltage r=
egulators
>>
>>
>> Maybe you can put together a quick patch to fix these?
>
> Yea, I can do that. Can you provide your .config as reference?
>
You can generate one quickly using these steps..
make omap2plus_defconfig
scripts/config --disable ARCH_OMAP4
scripts/config --disable ARCH_OMAP3
make oldnoconfig
make uImage
=2E.. and it should expose the warning.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
