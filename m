From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 13 Sep 2011 14:13:43 +0530
Message-ID: <CAJe_ZhfrrJUySt0JpM4n2cU0874kBJhMoMG9NMS5kX+C5f+rXQ@mail.gmail.com>
References: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
	<CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
	<CAJe_ZhcxEaHoj+6+mTKOk2Jz9KBeTP-M3c2VMn=S4Y-K6iegKw@mail.gmail.com>
	<CAGsJ_4xaDyQgtGZwDjnXn-=ouHzqmVfwaKeDxuouvkPHMkr8mw@mail.gmail.com>
	<CAGsJ_4yrBuWB_GRoh8EwQoyQL9w_qXBXi4hqiWwPh8MV8eux8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60954 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1IMInp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 04:43:45 -0400
Received: by wyh22 with SMTP id 22so296062wyh.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 01:43:44 -0700 (PDT)
In-Reply-To: <CAGsJ_4yrBuWB_GRoh8EwQoyQL9w_qXBXi4hqiWwPh8MV8eux8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dan.j.williams@intel.com, sundaram@ti.com, linus.walleij@linaro.org, vinod.koul@intel.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

On 13 September 2011 13:16, Barry Song <21cnbao@gmail.com> wrote:
>> if test pass, to the patch, and even for the moment, to the API's id=
ea
>> Acked-by: Barry Song <baohua.song@csr.com>
>
> one issue i noticed is with a device_prep_dma_genxfer, i don't need
> device_prep_slave_sg any more,
Yeah, the damengine would need to adapt to the fact that these
interleaved tranfers could be Mem->Mem as well as Mem<->Dev
(even though yours could be only one type, but some dmacs could
do both).

> How about:
>
> =A0 =A0 =A0 BUG_ON(dma_has_cap(DMA_MEMCPY, device->cap_mask) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_dma_memcpy);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_dma_memcpy &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_dma_genxfer);
>
> =A0 =A0 =A0 =A0BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_slave_sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_slave_sg &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_prep_dma_genxfer);
>
Seems ok, but please modify in a way you think is best and submit a pat=
ch
on top of this new api. Then it'll be easier to evaluate everything.

thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
