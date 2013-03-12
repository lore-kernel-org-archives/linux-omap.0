From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/7] usb: otg: twl4030-usb: ignore duplicate events
Date: Tue, 12 Mar 2013 16:55:38 +0200
Message-ID: <CANOLnOPB7Z6Tc+fZ=-L4acm27r1WKd7jiSEHYRFz=+L84roUaw@mail.gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
	<1362877681-8102-3-git-send-email-notasas@gmail.com>
	<513F2E71.7020502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34812 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3CLOzj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 10:55:39 -0400
In-Reply-To: <513F2E71.7020502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>

On Tue, Mar 12, 2013 at 3:32 PM, kishon <kishon@ti.com> wrote:
> Hi,
>
>
> On Sunday 10 March 2013 06:37 AM, Grazvydas Ignotas wrote:
>>
>> In some rare cases we may get multiple interrupts that will generate
>> duplicate omap_musb_mailbox() calls. This is a problem because each
>> VBUS/ID event generates runtime_pm call in OMAP glue code, causing
>> unbalanced gets or puts and breaking PM.
>
>
> Did you actually observed multiple interrupts? Actually we thought
> debouncing should be handled in hardware.

I think I saw it a few times, although it might have been something
else. In any case the software check is very cheap and there is no
reason not to have it, IMO.

>
>>
>> The same goes for initial state, glue already defaults to "no cable"
>> state, so only bother it if we have VBUS or ID.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> Thanks
> Kishon

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
