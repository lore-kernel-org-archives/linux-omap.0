From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride configuration
Date: Tue, 12 Jul 2011 18:15:22 +0530
Message-ID: <CABb+yY1_vuM7NGxV4o103YmYfte09XKpaXnYARcn3jjnChiBsQ@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
	<CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
	<CABb+yY1RqHJ6jsMB2RqPNnBLff-bzhwaXG1U-hCD8CpME+a3aA@mail.gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94030259DBBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259DBBE@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 12, 2011 at 5:01 PM, Raju, Sundaram <sundaram@ti.com> wrote=
:
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> Sent: Tuesday, July 12, 2011 4:51 PM
>> To: Linus Walleij
>> Cc: Raju, Sundaram; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; davinci-linux-open-source@linux.davincidsp.c=
om;
>> linux@arm.linux.org.uk; dan.j.williams@intel.com; linux-omap@vger.ke=
rnel.org
>> Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stri=
de
>> configuration
>>
>> On Tue, Jul 12, 2011 at 3:33 PM, Linus Walleij <linus.walleij@linaro=
=2Eorg>
>> wrote:
>> > On Tue, Jul 12, 2011 at 6:17 AM, Jassi Brar <jassisinghbrar@gmail.=
com>
>> wrote:
>> >
>> >> 1) Striding, in one form or other, is supported by other DMACs as=
 well.
>> >> =C2=A0 The number will only increase in future.
>> >> =C2=A0 Are we to add =C2=A0<VENDOR>_DMA_STRIDE_CONFIG for each ca=
se ?
>> >
>> > If we are sure about this and striding will work in a similar way =
on all
>> > then let's have the enum named DMA_STRIDE_CONFIG and move the
>> > passed-in struct to <linux/dmaengine.h) then?
>> >
>> > Would that be:
>> >
>> > struct dma_stride_config {
>> > =C2=A0 =C2=A0u32 read_bytes;
>> > =C2=A0 =C2=A0u32 skip_bytes;
>> > };
>> >
>> > Or something more complex?
>> Well, I am not sure if striding needs any special treatment at all.
>> Why not have client drivers prepare and submit sg-list.
>> Let the DMAC drivers interpret/parse the sg-list and program it
>> as strides if the h/w supports it.
>> If anything, we should make preparation and submission of sg-list
>> as efficient as possible.
> Jassi,
>
> sg_lists describe only a bunch of disjoint buffers. But what if the
> DMAC can skip and read the bytes within each of the buffers in
> the sg_list? (like TI EDMAC and TI SDMAC)
> How can that information be passed to the offload
> engine driver from the client?
>
OK, I overlooked.
We do need something new to handle these ultra-fine-grained sg-lists.
But still we shouldn't add SoC specific API to the common sub-systems.

Maybe a new api to pass fixed-format variable-length encoded message
to the DMAC drivers?
Which could be interpreted by DMAC drivers to extract all the needed xf=
er
parameters from the 'header' section and instructions to program the xf=
ers
in the DMAC from the variable length body of the 'message' buffer.
It might sound complicated but we can have helpers to make the job easy=
=2E
Btw, the regular single/sg-list xfers could also be expressed by this m=
ethod.
