From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3 SDMA + RFBI_PARAM register
Date: Sat, 31 Oct 2009 18:53:40 +0300
Message-ID: <48239d390910310853p2f014834vc7578f751fe6a619@mail.gmail.com>
References: <48239d390910290914n323cd057tb83fc6bacd01f3a8@mail.gmail.com>
	 <618f0c910910310041ida82431x37275a3b27c08110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:36451 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbZJaPxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 11:53:36 -0400
Received: by ewy28 with SMTP id 28so3773801ewy.18
        for <linux-omap@vger.kernel.org>; Sat, 31 Oct 2009 08:53:40 -0700 (PDT)
In-Reply-To: <618f0c910910310041ida82431x37275a3b27c08110@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <alexander.shishckin@gmail.com>

On Sat, Oct 31, 2009 at 10:41 AM, Venkatraman S <svenkatr@ti.com> wrote=
:
> On Thu, Oct 29, 2009 at 9:44 PM, Sergey Lapin <slapinid@gmail.com> wr=
ote:
>> Hi, all!
>>
>> I need to transfer block of data using sDMA from memory address
>> to RFBI_PARAM FIFO, so to put that into display module.
>>
>> I do this like this:
>>
>> /* DMA */
>> #define RFBI_BASE 0x48050800
>> #define RFBI_PARAM 0x0050
>> static void configure_dma(int dma_ch, u32 data, int size)
>> {
>> =A0 =A0 =A0 =A0int nblk;
>> =A0 =A0 =A0 =A0omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CO=
NSTANT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(RFBI_BASE + RFBI_PARAM), 0, 0);
>> =A0 =A0 =A0 =A0omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POS=
T_INC,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data, 0, 0);
>> =A0 =A0 =A0 =A0nblk =3D (size + PAGE_SIZE - 1) / PAGE_SIZE;
>> =A0 =A0 =A0 =A0omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TY=
PE_S8,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PAGE_SIZE, nblk, OMAP_DMA_SYNC_FRAME,=
 0, 0);
>> =A0 =A0 =A0 =A0omap_start_dma(dma_ch);
>> }
>
> Just making sure, do you want to use DMA to configure just a single
> register ? According to your code, you want to transfer "data" to the
> configuration register called RFBI_PARAM, and not the FIFO.
>
> Assuming you want just that, I think you need to use 32 bit element
> size. The registers can be read or written in 32 bit mode only. So us=
e
> OMAP_DMA_DATA_TYPE_S32, instead of OMAP_DMA_DATA_TYPE_S8.
> Again, if you use CONSTANT addressing mode for destination, the
> destination address will not be auto-incremented. Hence the only
> outcome of this transfer would be that the last 4 bytes of "data"
> would reside in RFBI_PARAM register, if you get to that.
Well, what I want to achieve is:
To write to my display, I need to write 0x22 to RFBI_CMD,
then do writes to RFBI_PARAM register to write pixel data.
It works in simple for(;;) loop. But I want to accelerate it,
so I'd like to use DMA for that.

from drivers/video/omap/rfbi.c:
static void rfbi_write_data(const void *buf, unsigned int len)
{
        rfbi_enable_clocks(1);
        if (rfbi.bits_per_cycle =3D=3D 16) {
                const u16 *w =3D buf;
                BUG_ON(len & 1);
                for (; len; len -=3D 2)
                        rfbi_write_reg(RFBI_PARAM, *w++);
        } else {
                const u8 *b =3D buf;
                BUG_ON(rfbi.bits_per_cycle !=3D 8);
                for (; len; len--)
                        rfbi_write_reg(RFBI_PARAM, *b++);
        }
        rfbi_enable_clocks(0);
}

This part works well, for the display, but it is very slow. I really wa=
nt to
accelerate this stuff using DMA. Any ideas on how to do that?
My display requires the following sequence: (it is hx8340-b)

COMMAND=3D0x22, then
DATA=3Dpixel data in chunks of 3 bytes per pixel. as I see, data are
passed to RFBI_PARAM register.

So all I want is what I have to do in the following situation, either
via RFBI or via sDMA writes to
RFBI_PARAM.

Actually, I have two displays, one is 1bpp, another is 18bpp, both use
8-bit 8080-style interface.
As for second one, I think it might be possible to run it using RFBI
with its dedicated DMA,
but I still haven't figured how, or if that's possible at all. For
first one, it seems not possible to run it
using RFBI's dedicated DMA and sDMA is required. Otherwise, both
displays use CPU too much.

Any ideas?
S.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
