From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: Re: patch: add omap730 / omap850 rtc support
Date: Wed, 14 Oct 2009 15:27:35 +0200
Message-ID: <3ea34a000910140627w53dffe59l977a78b866c50d8a@mail.gmail.com>
References: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF600@dbde02.ent.ti.com>
	 <3ea34a000910140126p3352a5aej50300a39521f1128@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF6EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:34314 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760624AbZJNN2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 09:28:12 -0400
Received: by yxe26 with SMTP id 26so5319828yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 06:27:36 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF6EE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 14, 2009 at 11:52 AM, G, Manjunath Kondaiah <manjugk@ti.com=
> wrote:
> You can acheive the same using only enum with following:
>
> #define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
> #define rtc_read(reg)
> =A0 =A0 =A0 =A0omap_readb(OMAP_RTC_BASE + (reg * OMAP_RTC_REGISTER_SI=
ZE))

That was my first instinct too, but then I thought that one of the
register offsets wasn't related by a factor of 4 (when I made the
patch originally it was ~ 2am and I was very tired), which convinced
me to do a quick & easy static array implementation.

Thanks for your suggestion.

Regarding the 50 -> 35 change, I think it's clearly safe to do. I have
no objections.

C
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
