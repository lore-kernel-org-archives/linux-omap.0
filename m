From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: HEAD unbootable on 2430SDP
Date: Mon, 6 Oct 2008 17:08:45 -0700
Message-ID: <a46a26fd0810061708xdd4b50ax150132fdca62f83@mail.gmail.com>
References: <a46a26fd0810061633h788d7c96ke5eb4a1f5fe440d4@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365AE0E8F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:22228 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYJGAIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 20:08:47 -0400
Received: by yx-out-2324.google.com with SMTP id 8so483875yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 17:08:45 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620365AE0E8F@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 6, 2008 at 4:46 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>
>
>> I am running into a weird problem with the current HEAD on OMAP2430SDP.
>>
>> It seems the execution goes into infinite loop in intc_bank_read_reg()
>> function.
>>
>> In the:
>>         while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
>>                 /* Wait for reset to complete */;
>
> Did your board boot loader setup the peripheral port remap register?

I'm using the u-boot snapshot from
http://linux.omap.com/pub/bootloader/2430sdp/source/u-boot-Sept2507.tar.gz.

And it seems to map it.

 - Juha

-- 
Madness takes it's toll. Please have exact change.
