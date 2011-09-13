From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 13 Sep 2011 15:46:19 +0800
Message-ID: <CAGsJ_4yrBuWB_GRoh8EwQoyQL9w_qXBXi4hqiWwPh8MV8eux8Q@mail.gmail.com>
References: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
 <CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
 <CAJe_ZhcxEaHoj+6+mTKOk2Jz9KBeTP-M3c2VMn=S4Y-K6iegKw@mail.gmail.com> <CAGsJ_4xaDyQgtGZwDjnXn-=ouHzqmVfwaKeDxuouvkPHMkr8mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58101 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab1IMHqk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 03:46:40 -0400
Received: by bkbzt4 with SMTP id zt4so246176bkb.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 00:46:39 -0700 (PDT)
In-Reply-To: <CAGsJ_4xaDyQgtGZwDjnXn-=ouHzqmVfwaKeDxuouvkPHMkr8mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: dan.j.williams@intel.com, sundaram@ti.com, linus.walleij@linaro.org, vinod.koul@intel.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2011/9/13 Barry Song <21cnbao@gmail.com>:
> 2011/9/13 Jassi Brar <jaswinder.singh@linaro.org>:
>> On 12 September 2011 21:56, Barry Song <21cnbao@gmail.com> wrote:
>>>> Define a new api that could be used for doing fancy data transfers
>>>> like interleaved to contiguous copy and vice-versa.
>>>> Traditional SG_list based transfers tend to be very inefficient in
>>>> such cases as where the interleave and chunk are only a few bytes,
>>>> which call for a very condensed api to convey pattern of the trans=
fer.
>>>>
>>>> This api supports all 4 variants of scatter-gather and contiguous =
transfer.
>>>> Besides, it could also represent common operations like
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0device_prep_dma_{cyclic, memset, memcpy=
}
>>>> and maybe some more that I am not sure of.
>>>>
>>>> Of course, neither can this api help transfers that don't lend to =
DMA by
>>>> nature, i.e, scattered tiny read/writes with no periodic pattern.
>>>>
>>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>>
>>> anyway, this API needs a real user to prove why it needs to exist.
>>>
>>> prima2 can be the 1st(?, 2nd if TI uses) user of this API. let's tr=
y
>>> to see what the driver will be with this api. Then we might figure =
out
>>> more about what it should be.
>>>
>> Did you discover any issue with the api?
>
> no until now, but i need to test as i said since there is nobody else
> has used it before. so i just hold the formal ACK for a moment.
>
>> Because only three days ago you said
>> {
>> Jassi, you might think my reply as an ACK to "[PATCH] DMAEngine:
>> Define generic transfer request api".
>> }
>
> if test pass, to the patch, and even for the moment, to the API's ide=
a
> Acked-by: Barry Song <baohua.song@csr.com>

one issue i noticed is with a device_prep_dma_genxfer, i don't need
device_prep_slave_sg any more, then the validation check in
dma_async_device_register():

        BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
                !device->device_prep_slave_sg);

is wrong to me.

How about:

       BUG_ON(dma_has_cap(DMA_MEMCPY, device->cap_mask) &&
-               !device->device_prep_dma_memcpy);
+               !device->device_prep_dma_memcpy &&
+               !device->device_prep_dma_genxfer);

        BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
 -               !device->device_prep_slave_sg);
+               !device->device_prep_slave_sg &&
+               !device->device_prep_dma_genxfer);

>
>>
>> The api met your requirements easily not because I know them already=
,
>> but because I designed the api to be as generic as practically possi=
ble.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
