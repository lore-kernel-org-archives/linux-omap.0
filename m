From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 3 May 2010 09:35:20 +0300
Message-ID: <x2vda15981b1005022335q571f0ea9s8c14bfc490f60b0f@mail.gmail.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
	<1272815071-2827-5-git-send-email-ohad@wizery.com> <20100503.083036.59656495.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62178 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0ECGfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:35:46 -0400
Received: by gxk9 with SMTP id 9so1268704gxk.8
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 23:35:42 -0700 (PDT)
In-Reply-To: <20100503.083036.59656495.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

On Mon, May 3, 2010 at 8:30 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> Hi Ohad,
>
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
> Date: Sun, 2 May 2010 17:44:31 +0200
>
>> The underlying buffering implementation of mailbox
>> is converted from block API to kfifo due to the simplicity
>> and speed of kfifo.
>>
>> The default size of the kfifo buffer is set to 256 bytes.
>> This value is configurable at compile time (via
>> CONFIG_OMAP_MBOX_KFIFO_SIZE), and can be changed at
>> runtime (via the omap_kfifo_size module parameter).
>
> mbox_kfifo_size?

sure. thanks for noticing.

>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> If you want, you can also reach me at < ohadb at ti dot com >.
>>
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
9 +++
>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A04 +-
>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0107 =
+++++++++++++----------------
>> =A03 files changed, 58 insertions(+), 62 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
