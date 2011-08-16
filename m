From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 16 Aug 2011 20:02:22 +0530
Message-ID: <CAJe_Zhcbfd_K7h2Dq_w5FNTXgFaHqOAWmwpUtzjQMLXoydg8Gw@mail.gmail.com>
References: <1313147667-3385-1-git-send-email-jaswinder.singh@linaro.org>
	<1313499399.1603.92.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313499399.1603.92.camel@vkoul-udesk3>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: sundaram@ti.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, rmk+kernel@arm.linux.org.uk, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On 16 August 2011 18:26, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-08-12 at 16:44 +0530, Jassi Brar wrote:
>> Define a new api that could be used for doing fancy data transfers
>> like interleaved to contiguous copy and vice-versa.
>> Traditional SG_list based transfers tend to be very inefficient in
>> such cases as where the interleave and chunk are only a few bytes,
>> which call for a very condensed api to convey pattern of the transfe=
r.
>>
>> This api supports all 4 variants of scatter-gather and contiguous tr=
ansfer.
>> Besides, it could also represent common operations like
>> =A0 =A0 =A0 =A0 device_prep_dma_{cyclic, memset, memcpy}
>> and maybe some more that I am not sure of.
>>
>> Of course, neither can this api help transfers that don't lend to DM=
A by
>> nature, i.e, scattered tiny read/writes with no periodic pattern.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> ---
>> =A0include/linux/dmaengine.h | =A0 73 ++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 73 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 8fbf40e..74f3ae0 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -76,6 +76,76 @@ enum dma_transaction_type {
>> =A0/* last transaction type for creation of the capabilities mask */
>> =A0#define DMA_TX_TYPE_END (DMA_CYCLIC + 1)
>>
>> +/**
>> + * Generic Transfer Request
>> + * ------------------------
>> + * A chunk is collection of contiguous bytes to be transfered.
>> + * The gap(in bytes) between two chunks is called inter-chunk-gap(I=
CG).
>> + * ICGs may or maynot change between chunks.
>> + * A FRAME is the smallest series of contiguous {chunk,icg} pairs,
>> + * =A0that when repeated an integral number of times, specifies the=
 transfer.
>> + * A transfer template is specification of a Frame, the number of t=
imes
>> + * =A0it is to be repeated and other per-transfer attributes.
>> + *
>> + * Practically, a client driver would have ready a template for eac=
h
>> + * =A0type of transfer it is going to need during its lifetime and
>> + * =A0set only 'src_start' and 'dst_start' before submitting the re=
quests.
>> + *
>> + *
>> + * =A0| =A0 =A0 =A0Frame-1 =A0 =A0 =A0 =A0| =A0 =A0 =A0 Frame-2 =A0=
 =A0 =A0 | ~ | =A0 =A0 =A0 Frame-'numf' =A0|
>> + * =A0|=3D=3D=3D=3D....=3D=3D.=3D=3D=3D...=3D...|=3D=3D=3D=3D....=3D=
=3D.=3D=3D=3D...=3D...| ~ |=3D=3D=3D=3D....=3D=3D.=3D=3D=3D...=3D...|
>> + *
>> + * =A0 =A0=3D=3D =A0Chunk size
>> + * =A0 =A0... ICG
>> + */
>> +
>> +/**
>> + * struct data_chunk - Element of scatter-gather list that makes a =
frame.
>> + * @size: Number of bytes to read from source.
>> + * =A0 =A0 size_dst :=3D fn(op, size_src), so doesn't mean much for=
 destination.
>> + * @icg: Number of bytes to jump after last src/dst address of this
>> + * =A0 =A0chunk and before first src/dst address for next chunk.
>> + * =A0 =A0Ignored for dst(assumed 0), if dst_inc is true and dst_sg=
l is false.
>> + * =A0 =A0Ignored for src(assumed 0), if src_inc is true and src_sg=
l is false.
>> + */
>> +struct data_chunk {
>> + =A0 =A0 size_t size;
>> + =A0 =A0 size_t icg;
>> +};
>> +
>> +/**
>> + * struct xfer_template - Template to convey DMAC the transfer patt=
ern
>> + * =A0 =A0and attributes.
>> + * @op: The operation to perform on source data before writing it o=
n
>> + * =A0 =A0to destination address.
>> + * @src_start: Bus address of source for the first chunk.
>> + * @dst_start: Bus address of destination for the first chunk.
>> + * @src_inc: If the source address increments after reading from it=
=2E
>> + * @dst_inc: If the destination address increments after writing to=
 it.
>> + * @src_sgl: If the 'icg' of sgl[] applies to Source (scattered rea=
d).
>> + * =A0 =A0 =A0 =A0 =A0 Otherwise, source is read contiguously (icg =
ignored).
>> + * =A0 =A0 =A0 =A0 =A0 Ignored if src_inc is false.
>> + * @dst_sgl: If the 'icg' of sgl[] applies to Destination (scattere=
d write).
>> + * =A0 =A0 =A0 =A0 =A0 Otherwise, destination is filled contiguousl=
y (icg ignored).
>> + * =A0 =A0 =A0 =A0 =A0 Ignored if dst_inc is false.
>> + * @frm_irq: If the client expects DMAC driver to do callback after=
 each frame.
>> + * @numf: Number of frames in this template.
>> + * @frame_size: Number of chunks in a frame i.e, size of sgl[].
>> + * @sgl: Array of {chunk,icg} pairs that make up a frame.
>> + */
>> +struct xfer_template {
>> + =A0 =A0 enum dma_transaction_type op;
>> + =A0 =A0 dma_addr_t src_start;
>> + =A0 =A0 dma_addr_t dst_start;
>> + =A0 =A0 bool src_inc;
>> + =A0 =A0 bool dst_inc;
>> + =A0 =A0 bool src_sgl;
>> + =A0 =A0 bool dst_sgl;
>> + =A0 =A0 bool frm_irq;
>> + =A0 =A0 size_t numf;
>> + =A0 =A0 size_t frame_size;
>> + =A0 =A0 struct data_chunk sgl[0];
>> +};
>>
>> =A0/**
>> =A0 * enum dma_ctrl_flags - DMA flags to augment operation preparati=
on,
>> @@ -432,6 +502,7 @@ struct dma_tx_state {
>> =A0 * @device_prep_dma_cyclic: prepare a cyclic dma operation suitab=
le for audio.
>> =A0 * =A0 The function takes a buffer of size buf_len. The callback =
function will
>> =A0 * =A0 be called after period_len bytes have been transferred.
>> + * @device_prep_dma_genxfer: Transfer expression in a generic way.
>> =A0 * @device_control: manipulate all pending operations on a channe=
l, returns
>> =A0 * =A0 zero or error code
>> =A0 * @device_tx_status: poll for transaction completion, the option=
al
>> @@ -496,6 +567,8 @@ struct dma_device {
>> =A0 =A0 =A0 struct dma_async_tx_descriptor *(*device_prep_dma_cyclic=
)(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dma_chan *chan, dma_addr_t buf_ad=
dr, size_t buf_len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t period_len, enum dma_data_directi=
on direction);
>> + =A0 =A0 struct dma_async_tx_descriptor *(*device_prep_dma_genxfer)=
(
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct dma_chan *chan, struct xfer_templat=
e *xt);
>> =A0 =A0 =A0 int (*device_control)(struct dma_chan *chan, enum dma_ct=
rl_cmd cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long arg);
>>
> Do you have a driver which is using the API, would help to evaluate t=
his
> API when we see the usage :)
Sorry, not in public and not for DMAENGINE.
It will help if you see it as a generic[1] solution to the requirement =
of
supporting interleaved transfers with DMACs like TI's EDMA, SDMA,
ARM's PL330 and many more in future.

> Currently we have two approaches to solve this problem first being th=
e
> DMA_STRIDE_CONFIG proposed by Linus W, I feel this one is better
> approach as this can give client ability to configure each transfer
> rather than set for the channel.
To me, doing it via a control command vs new transfer type, is secondar=
y
to doing it in a generic way. And yes, I too believe this way is better=
 because
it is more flexible.


[1] Btw, I haven't yet added option to specify byte/half-word/word swap
while data transfer - which I once had to do with PL330 in a weird setu=
p.
