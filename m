From: Venkatraman S <svenkatr@ti.com>
Subject: Re: OMAP3 SDMA + RFBI_PARAM register
Date: Sat, 31 Oct 2009 13:11:21 +0530
Message-ID: <618f0c910910310041ida82431x37275a3b27c08110@mail.gmail.com>
References: <48239d390910290914n323cd057tb83fc6bacd01f3a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56287 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbZJaHlQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 03:41:16 -0400
Received: by pwj9 with SMTP id 9so1038251pwj.21
        for <linux-omap@vger.kernel.org>; Sat, 31 Oct 2009 00:41:21 -0700 (PDT)
In-Reply-To: <48239d390910290914n323cd057tb83fc6bacd01f3a8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <alexander.shishckin@gmail.com>

On Thu, Oct 29, 2009 at 9:44 PM, Sergey Lapin <slapinid@gmail.com> wrot=
e:
> Hi, all!
>
> I need to transfer block of data using sDMA from memory address
> to RFBI_PARAM FIFO, so to put that into display module.
>
> I do this like this:
>
> /* DMA */
> #define RFBI_BASE 0x48050800
> #define RFBI_PARAM 0x0050
> static void configure_dma(int dma_ch, u32 data, int size)
> {
> =A0 =A0 =A0 =A0int nblk;
> =A0 =A0 =A0 =A0omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CON=
STANT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(RFBI_BASE + RFBI_PARAM), 0, 0);
> =A0 =A0 =A0 =A0omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST=
_INC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data, 0, 0);
> =A0 =A0 =A0 =A0nblk =3D (size + PAGE_SIZE - 1) / PAGE_SIZE;
> =A0 =A0 =A0 =A0omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYP=
E_S8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PAGE_SIZE, nblk, OMAP_DMA_SYNC_FRAME, =
0, 0);
> =A0 =A0 =A0 =A0omap_start_dma(dma_ch);
> }

Just making sure, do you want to use DMA to configure just a single
register ? According to your code, you want to transfer "data" to the
configuration register called RFBI_PARAM, and not the FIFO.

Assuming you want just that, I think you need to use 32 bit element
size. The registers can be read or written in 32 bit mode only. So use
OMAP_DMA_DATA_TYPE_S32, instead of OMAP_DMA_DATA_TYPE_S8.
Again, if you use CONSTANT addressing mode for destination, the
destination address will not be auto-incremented. Hence the only
outcome of this transfer would be that the last 4 bytes of "data"
would reside in RFBI_PARAM register, if you get to that.

>
> /*
> =A0* DMA call back function
> =A0*/
> static void hx8340_dma_cb(int lch, u16 ch_status, void *data)
> {
> =A0 =A0 =A0 =A0if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(hx8340.fbdev->dev, "Misaligned=
 access\n");
> =A0 =A0 =A0 =A0if (hx8340.dma_ch < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0omap_free_dma(hx8340.dma_ch);
> =A0 =A0 =A0 =A0hx8340.dma_ch =3D -1;
> }
>
> /* data is physical address of buffer */
> static int transfer_dma(u32 data, int size)
> {
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0if (hx8340.dma_ch !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(TASK_UNINTERRUPTIBLE=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule_timeout(100);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(hx8340.dma_ch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0ret =3D omap_request_dma(OMAP34XX_DSS_DMA3, "HX8340",
> hx8340_dma_cb, NULL, &hx8340.dma_ch);
> =A0 =A0 =A0 =A0if (ret !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("HX8340: dma request failure\n"=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0configure_dma(hx8340.dma_ch, data, size);
> =A0 =A0 =A0 =A0return 0;
> }
> But all I get is
> DMA transaction error with device 75
>
> Is what I try to achieve at all possible? At RFBI part of CPU
> datasheet it is mentioned it is possible using sDMA
> to write these registers. So, is there some examples? I tried to use
> drivers/mmc/host/omap_hsmmc.c as example,
> but that seems to be not enough. Any ideas?
>
> S.

Do you want examples for configuring DMA in general, or configuring
RFBI ? There are many modules in drivers which use DMA ( USB, McBSP,
etc).

Venkat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
