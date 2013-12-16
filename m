From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: WG: [PATCH] usb: musb: omap2430: fix occasional musb breakage on boot
Date: Mon, 16 Dec 2013 12:49:04 +0200
Message-ID: <CANOLnOP6923w_qSeVU4hUDpKtgMzWxA2WevQW=PPUAX_=BWdGQ@mail.gmail.com>
References: <EE4E4767751A8B40949306E403F4DDD8032AA82A@sv03ultra002.ultratronik.de>
	<52AA2AA8.4090402@andin.de>
	<CANOLnON65xu0HKBzmhWOnoEoXscguBuozwKUV5FZAYObt=tP5w@mail.gmail.com>
	<52AB3589.6010606@andin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48478 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3LPKtE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 05:49:04 -0500
In-Reply-To: <52AB3589.6010606@andin.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Naumann <dev@andin.de>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Dec 13, 2013 at 6:27 PM, Andreas Naumann <dev@andin.de> wrote:
> On 13.12.2013 13:34, Grazvydas Ignotas wrote:
>>
>> Hmm I don't know about that, this would be inconsistent with what al=
l
>> other OMAP drivers do. Maybe we should do what musb_core.c does just
>
> Ok, thats cool.
>
>> to be consistent and add a similar comment. Only the static variable
>> could be avoided in favor of struct omap2430_glue member.
>
> Whats wrong with the static?

Well besides minor memory wastage when the driver is compiled in but
not used, you'd cause problems if TI makes a SoC with multiple musb
instances. Yes this driver already contains global variables, but
still we can avoid adding more easily.

Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
