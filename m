From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: Re: OMAP850 RTC and MMC registers differ from other OMAP1, how to
	implement?
Date: Wed, 7 Oct 2009 18:13:35 +0200
Message-ID: <3ea34a000910070913o302d053fqec0b393b7a0eb599@mail.gmail.com>
References: <3d374d00907300659y5af1bc0ctdd236d8b5f4712e4@mail.gmail.com>
	 <3d374d00907300825o13fa7b2frc22dae8a290f4118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.211.196]:43321 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZJGREI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 13:04:08 -0400
Received: by ywh34 with SMTP id 34so5107845ywh.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 10:03:31 -0700 (PDT)
In-Reply-To: <3d374d00907300825o13fa7b2frc22dae8a290f4118@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Alistair,

I'm also doing a bit of work with the omap850 for my htc wizard.

Has anything happened with the rtc patches lately? I haven't seen
anything show up in linux-omap git, but I might have missed them.

If not, can you please post them ? I don't mind implementing the omap1
compatibiity pointed out by Russell & Tony [1].

Cheers,

Chris

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg16701.htm=
l


On Thu, Jul 30, 2009 at 5:25 PM, Alistair Buxton <a.j.buxton@gmail.com>=
 wrote:
> Hi,
>
> I'm working on OMAP850 support. I have found that OMAP 15xx and 16xx =
have
> 32 bit registers, while 730 and 850 have 8 bit RTC registers and 16
> bit MMC registers. At the moment I work around this using #defines as
> such:
>
> #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
> #define OMAP_RTC_SECONDS_REG =A0 =A0 =A0 =A0 =A0 0x00
> ...
> #define OMAP_RTC_OSC_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x19
> #else
> #define OMAP_RTC_SECONDS_REG =A0 =A0 =A0 =A0 =A0 =A00x00
> ...
> #define OMAP_RTC_OSC_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x54
> #endif
>
> I have been told that this isn't a good way to handle it because the
> same binary kernel has to work on all OMAP1 machines. So this has to
> be checked for at run time. We can check that with cpu_is_omap7xx()
> but what would be the correct way to actually implement this? I could
> do something like this:
>
> #define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
> #define OMAP_RTC_OSC_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x19*OMAP_RTC_R=
EGISTER_SIZE)
>
> Would that be acceptable? If not, how should I do it? Is there an
> existing driver that does something similar I could look at?
>
> Thanks,
> --
> Alistair Buxton
> a.j.buxton@gmail.com
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-=
kernel
> FAQ: =A0 =A0 =A0 =A0http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette: =A0http://www.arm.linux.org.uk/mailinglists/etiquette.php
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
