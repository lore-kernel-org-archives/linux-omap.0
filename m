From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH v2 2/2] omap: RX-51: enable tsc2005
Date: Tue, 10 Nov 2009 12:30:37 +0200
Message-ID: <87bpjaekoi.fsf@purkki.valot.fi>
References: <1257340982-22814-1-git-send-email-aaro.koskinen@nokia.com>
	<1257340982-22814-2-git-send-email-aaro.koskinen@nokia.com>
	<87d43ufih0.fsf@purkki.valot.fi> <4AF8193A.70505@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61151 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZKJKaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:30:35 -0500
In-Reply-To: <4AF8193A.70505@nokia.com> (Aaro Koskinen's message of "Mon\, 09 Nov 2009 15\:29\:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "tony@atomide.com" <tony@atomide.com>

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

>> I sent a wl1251 patch which adds spi_board_info and conflicts with
>> this patch:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17604.html
>>
>> How do we handle this?
>
> I can resend/rebase this patch once the wl1251 patch is integrated.

Ok, thanks. I'll resend the wl1251 patch just to be sure that it
doesn't get lost.

> BTW, check the comment from Tommi Rantala - spi_board_info can be marked
> with __initdata.

I'll add it to my patch.

-- 
Kalle Valo
