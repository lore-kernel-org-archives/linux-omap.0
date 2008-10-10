From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: HEAD unbootable on 2430SDP
Date: Thu, 9 Oct 2008 17:35:44 -0700
Message-ID: <a46a26fd0810091735o107fcebcs479ac33a43ff0d4e@mail.gmail.com>
References: <a46a26fd0810061633h788d7c96ke5eb4a1f5fe440d4@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365AE0E8F@dlee02.ent.ti.com>
	 <a46a26fd0810061708xdd4b50ax150132fdca62f83@mail.gmail.com>
	 <a46a26fd0810071757y41094df1o1b99e3a0dd6d5e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:64452 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYJJAfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 20:35:48 -0400
Received: by wx-out-0506.google.com with SMTP id h27so128798wxd.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 17:35:44 -0700 (PDT)
In-Reply-To: <a46a26fd0810071757y41094df1o1b99e3a0dd6d5e0a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This problem was fixed by the patch in email:

[PATCH] OMAP2xxx: move SRAM to fix boot hang

I thought the 0xD8000000 -> 0x40200000 in MMU tables looked a bit odd. :)

Thanks,
 - Juha

On Tue, Oct 7, 2008 at 5:57 PM, Juha Kuikka <juha.kuikka@gmail.com> wrote:
> On Mon, Oct 6, 2008 at 5:08 PM, Juha Kuikka <juha.kuikka@gmail.com> wrote:
>>
>> On Mon, Oct 6, 2008 at 4:46 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>> >
>> >
>> >> I am running into a weird problem with the current HEAD on OMAP2430SDP.
>> >>
>> >> It seems the execution goes into infinite loop in intc_bank_read_reg()
>> >> function.
>> >>
>> >> In the:
>> >>         while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
>> >>                 /* Wait for reset to complete */;
>> >
>> > Did your board boot loader setup the peripheral port remap register?
>>
>> I'm using the u-boot snapshot from
>> http://linux.omap.com/pub/bootloader/2430sdp/source/u-boot-Sept2507.tar.gz.
>>
>> And it seems to map it.
>>
>
> I might also add that the kernel at
> http://linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v5.tgz
> boots without this issue.
>
>  - Juha
> --
> Madness takes it's toll. Please have exact change.
>



-- 
Madness takes it's toll. Please have exact change.
