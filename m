From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 13 Sep 2011 16:58:10 +0800
Message-ID: <CAGsJ_4ypKFD-a==gsMoPiwyHx39vAcsJr_5iyFS0fOn7-jHKbQ@mail.gmail.com>
References: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
 <CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
 <CAJe_ZhcxEaHoj+6+mTKOk2Jz9KBeTP-M3c2VMn=S4Y-K6iegKw@mail.gmail.com>
 <CAGsJ_4xaDyQgtGZwDjnXn-=ouHzqmVfwaKeDxuouvkPHMkr8mw@mail.gmail.com>
 <CAGsJ_4yrBuWB_GRoh8EwQoyQL9w_qXBXi4hqiWwPh8MV8eux8Q@mail.gmail.com> <CAJe_ZhfrrJUySt0JpM4n2cU0874kBJhMoMG9NMS5kX+C5f+rXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53717 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab1IMI6b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 04:58:31 -0400
Received: by bkbzt4 with SMTP id zt4so303391bkb.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 01:58:30 -0700 (PDT)
In-Reply-To: <CAJe_ZhfrrJUySt0JpM4n2cU0874kBJhMoMG9NMS5kX+C5f+rXQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: dan.j.williams@intel.com, sundaram@ti.com, linus.walleij@linaro.org, vinod.koul@intel.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2011/9/13 Jassi Brar <jaswinder.singh@linaro.org>:
> On 13 September 2011 13:16, Barry Song <21cnbao@gmail.com> wrote:
>>> if test pass, to the patch, and even for the moment, to the API's i=
dea
>>> Acked-by: Barry Song <baohua.song@csr.com>
>>
>> one issue i noticed is with a device_prep_dma_genxfer, i don't need
>> device_prep_slave_sg any more,
> Yeah, the damengine would need to adapt to the fact that these
> interleaved tranfers could be Mem->Mem as well as Mem<->Dev
> (even though yours could be only one type, but some dmacs could
> do both).
>
>> How about:
>>
>> =C2=A0 =C2=A0 =C2=A0 BUG_ON(dma_has_cap(DMA_MEMCPY, device->cap_mask=
) &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->device_p=
rep_dma_memcpy);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->device_p=
rep_dma_memcpy &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->device_p=
rep_dma_genxfer);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(dma_has_cap(DMA_SLAVE, device->cap=
_mask) &&
>> =C2=A0- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->de=
vice_prep_slave_sg);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->device_p=
rep_slave_sg &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !device->device_p=
rep_dma_genxfer);
>>
> Seems ok, but please modify in a way you think is best and submit a p=
atch
> on top of this new api. Then it'll be easier to evaluate everything.

i think it should be handled by this patch but not a new one.

>
> thanks.
>

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
