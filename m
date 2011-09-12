From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 13 Sep 2011 00:26:16 +0800
Message-ID: <CAGsJ_4xkUhbO+ZxBV61bsABH0uDD=Mve4bvOA0KMsEbSMaEDbQ@mail.gmail.com>
References: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50128 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab1ILQ0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 12:26:37 -0400
Received: by bkbzt4 with SMTP id zt4so2761026bkb.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 09:26:36 -0700 (PDT)
In-Reply-To: <CAGsJ_4wXURUwbf-fcNOq1m5-NJ9+VMuDq+9OJpBjFZK4C_X3cw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: dan.j.williams@intel.com, sundaram@ti.com, linus.walleij@linaro.org, vinod.koul@intel.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

> Define a new api that could be used for doing fancy data transfers
> like interleaved to contiguous copy and vice-versa.
> Traditional SG_list based transfers tend to be very inefficient in
> such cases as where the interleave and chunk are only a few bytes,
> which call for a very condensed api to convey pattern of the transfer=
=2E
>
> This api supports all 4 variants of scatter-gather and contiguous tra=
nsfer.
> Besides, it could also represent common operations like
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device_prep_dma_{cyclic, memset, memcpy}
> and maybe some more that I am not sure of.
>
> Of course, neither can this api help transfers that don't lend to DMA=
 by
> nature, i.e, scattered tiny read/writes with no periodic pattern.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

anyway, this API needs a real user to prove why it needs to exist.

prima2 can be the 1st(?, 2nd if TI uses) user of this API. let's try
to see what the driver will be with this api. Then we might figure out
more about what it should be.

> ---
> =C2=A0include/linux/dmaengine.h | =C2=A0 73 +++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 73 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8fbf40e..74f3ae0 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -76,6 +76,76 @@ enum dma_transaction_type {
> =C2=A0/* last transaction type for creation of the capabilities mask =
*/
> =C2=A0#define DMA_TX_TYPE_END (DMA_CYCLIC + 1)
>
> +/**
> + * Generic Transfer Request
> + * ------------------------
> + * A chunk is collection of contiguous bytes to be transfered.
> + * The gap(in bytes) between two chunks is called inter-chunk-gap(IC=
G).
> + * ICGs may or maynot change between chunks.
> + * A FRAME is the smallest series of contiguous {chunk,icg} pairs,
> + * =C2=A0that when repeated an integral number of times, specifies t=
he transfer.
> + * A transfer template is specification of a Frame, the number of ti=
mes
> + * =C2=A0it is to be repeated and other per-transfer attributes.
> + *
> + * Practically, a client driver would have ready a template for each
> + * =C2=A0type of transfer it is going to need during its lifetime an=
d
> + * =C2=A0set only 'src_start' and 'dst_start' before submitting the =
requests.
> + *
> + *
> + * =C2=A0| =C2=A0 =C2=A0 =C2=A0Frame-1 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A0 =C2=A0 Frame-2 =C2=A0 =C2=A0 =C2=A0 | ~ | =C2=A0 =C2=A0 =C2=
=A0 Frame-'numf' =C2=A0|
> + * =C2=A0|=3D=3D=3D=3D....=3D=3D.=3D=3D=3D...=3D...|=3D=3D=3D=3D....=
=3D=3D.=3D=3D=3D...=3D...| ~ |=3D=3D=3D=3D....=3D=3D.=3D=3D=3D...=3D...=
|
> + *
> + * =C2=A0 =C2=A0=3D=3D =C2=A0Chunk size
> + * =C2=A0 =C2=A0... ICG
> + */
> +
> +/**
> + * struct data_chunk - Element of scatter-gather list that makes a f=
rame.
> + * @size: Number of bytes to read from source.
> + * =C2=A0 =C2=A0 =C2=A0 size_dst :=3D fn(op, size_src), so doesn't m=
ean much for destination.
> + * @icg: Number of bytes to jump after last src/dst address of this
> + * =C2=A0 =C2=A0 =C2=A0chunk and before first src/dst address for ne=
xt chunk.
> + * =C2=A0 =C2=A0 =C2=A0Ignored for dst(assumed 0), if dst_inc is tru=
e and dst_sgl is false.
> + * =C2=A0 =C2=A0 =C2=A0Ignored for src(assumed 0), if src_inc is tru=
e and src_sgl is false.
> + */
> +struct data_chunk {
> + =C2=A0 =C2=A0 =C2=A0 size_t size;
> + =C2=A0 =C2=A0 =C2=A0 size_t icg;
> +};
> +
> +/**
> + * struct xfer_template - Template to convey DMAC the transfer patte=
rn
> + * =C2=A0 =C2=A0 =C2=A0and attributes.
> + * @op: The operation to perform on source data before writing it on
> + * =C2=A0 =C2=A0 =C2=A0to destination address.
> + * @src_start: Bus address of source for the first chunk.
> + * @dst_start: Bus address of destination for the first chunk.
> + * @src_inc: If the source address increments after reading from it.
> + * @dst_inc: If the destination address increments after writing to =
it.
> + * @src_sgl: If the 'icg' of sgl[] applies to Source (scattered read=
).
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Otherwise, source is re=
ad contiguously (icg ignored).
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ignored if src_inc is f=
alse.
> + * @dst_sgl: If the 'icg' of sgl[] applies to Destination (scattered=
 write).
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Otherwise, destination =
is filled contiguously (icg ignored).
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ignored if dst_inc is f=
alse.
> + * @frm_irq: If the client expects DMAC driver to do callback after =
each frame.
> + * @numf: Number of frames in this template.
> + * @frame_size: Number of chunks in a frame i.e, size of sgl[].
> + * @sgl: Array of {chunk,icg} pairs that make up a frame.
> + */
> +struct xfer_template {
> + =C2=A0 =C2=A0 =C2=A0 enum dma_transaction_type op;
> + =C2=A0 =C2=A0 =C2=A0 dma_addr_t src_start;
> + =C2=A0 =C2=A0 =C2=A0 dma_addr_t dst_start;
> + =C2=A0 =C2=A0 =C2=A0 bool src_inc;
> + =C2=A0 =C2=A0 =C2=A0 bool dst_inc;
> + =C2=A0 =C2=A0 =C2=A0 bool src_sgl;
> + =C2=A0 =C2=A0 =C2=A0 bool dst_sgl;
> + =C2=A0 =C2=A0 =C2=A0 bool frm_irq;
> + =C2=A0 =C2=A0 =C2=A0 size_t numf;
> + =C2=A0 =C2=A0 =C2=A0 size_t frame_size;
> + =C2=A0 =C2=A0 =C2=A0 struct data_chunk sgl[0];
> +};
>
> =C2=A0/**
> =C2=A0* enum dma_ctrl_flags - DMA flags to augment operation preparat=
ion,
> @@ -432,6 +502,7 @@ struct dma_tx_state {
> =C2=A0* @device_prep_dma_cyclic: prepare a cyclic dma operation suita=
ble for audio.
> =C2=A0* =C2=A0 =C2=A0 The function takes a buffer of size buf_len. Th=
e callback function will
> =C2=A0* =C2=A0 =C2=A0 be called after period_len bytes have been tran=
sferred.
> + * @device_prep_dma_genxfer: Transfer expression in a generic way.
> =C2=A0* @device_control: manipulate all pending operations on a chann=
el, returns
> =C2=A0* =C2=A0 =C2=A0 zero or error code
> =C2=A0* @device_tx_status: poll for transaction completion, the optio=
nal
> @@ -496,6 +567,8 @@ struct dma_device {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_async_tx_descriptor *(*device_p=
rep_dma_cyclic)(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_cha=
n *chan, dma_addr_t buf_addr, size_t buf_len,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t period_=
len, enum dma_data_direction direction);
> + =C2=A0 =C2=A0 =C2=A0 struct dma_async_tx_descriptor *(*device_prep_=
dma_genxfer)(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_chan *c=
han, struct xfer_template *xt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*device_control)(struct dma_chan *cha=
n, enum dma_ctrl_cmd cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
arg);
>
> --
> 1.7.4.1
>
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
