From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] OMAP: remove OMAP_TAG_UART
Date: Fri, 7 Aug 2009 12:26:56 +0300
Message-ID: <6ed0b2680908070226t44612698s64bfdca47623b0c9@mail.gmail.com>
References: <20090807051516.4787.36125.stgit@tikku>
	 <20090807051650.4787.84433.stgit@tikku>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988C18@dbde02.ent.ti.com>
	 <87tz0kma8y.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:59413 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbZHGJdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:33:24 -0400
Received: by fxm28 with SMTP id 28so1217872fxm.17
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 02:33:24 -0700 (PDT)
In-Reply-To: <87tz0kma8y.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 7, 2009 at 9:03 AM, Kalle Valo<kalle.valo@iki.fi> wrote:
> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>
>>>Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
>>>omap_uart_platform_data instead.
>>>
>>>Tested on rx51 and n8x0. Compile tested on omap_osk_5912.
>>>
>>>Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
>>
>> Any plans to remove OMAP_TAG_LCD
>
> I don't have any plans, but I don't know about others.

Already started by Tomi:
http://marc.info/?l=linux-omap&m=124948326314839&w=2
