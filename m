From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 06/11] v4l: Add support for omap4iss driver
Date: Thu, 8 Mar 2012 21:14:32 -0600
Message-ID: <CAKnK67R7uZ8eLLgtvLwHnnxvkcS=UdJ4VSvcAjLQra8_LXT=0w@mail.gmail.com>
References: <1322698500-29924-7-git-send-email-saaguirre@ti.com>
 <20120114175111.GA11467@valkosipuli.localdomain> <CAKnK67SnZZ95JC6hzqv4saR8KXTayV4gkbGy4rJFq8qYCZ23sg@mail.gmail.com>
 <20120126210514.GC15297@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58352 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089Ab2CIDOy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 22:14:54 -0500
Received: by mail-iy0-f177.google.com with SMTP id y10so2176174iak.22
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 19:14:53 -0800 (PST)
In-Reply-To: <20120126210514.GC15297@valkosipuli.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Hi Sakari,

On Thu, Jan 26, 2012 at 3:05 PM, Sakari Ailus <sakari.ailus@iki.fi> wro=
te:
> Hi Sergio,
>
>
> Aguirre, Sergio wrote:
>>>
>>> On Wed, Nov 30, 2011 at 06:14:55PM -0600, Sergio Aguirre wrote:
>
> ...
>
>>>> +/*
>>>> + * iss_save_ctx - Saves ISS context.
>>>> + * @iss: OMAP4 ISS device
>>>> + *
>>>> + * Routine for saving the context of each module in the ISS.
>>>> + */
>>>> +static void iss_save_ctx(struct iss_device *iss)
>>>> +{
>>>> + =A0 =A0 iss_save_context(iss, iss_reg_list);
>>>> +}
>>>
>>>
>>> Do you really, really need to save context related data? Couldn't y=
ou
>>> initialise the device the usual way when e.g. returning from suspen=
ded
>>> state?
>>
>>
>> I'll actually have to revisit this more carefuly. I haven't really
>> tested Runtime PM on this.
>>
>> I think I'll remove this for now, until i come up with something bet=
ter.
>
>
> Usually it's best to recreate the configuration the same way the driv=
er did
> it in the first place. Some registers have side effects so that resto=
ring
> them requires extra care.
>
>
>>>> +/*
>>>> + * iss_restore_ctx - Restores ISS context.
>>>> + * @iss: OMAP4 ISS device
>>>> + *
>>>> + * Routine for restoring the context of each module in the ISS.
>>>> + */
>>>> +static void iss_restore_ctx(struct iss_device *iss)
>>>> +{
>>>> + =A0 =A0 iss_restore_context(iss, iss_reg_list);
>>>> +}
>>>> +
>
>
> ...
>
>
>>>> +/*
>>>> + * csi2_irq_ctx_set - Enables CSI2 Context IRQs.
>>>> + * @enable: Enable/disable CSI2 Context interrupts
>>>> + */
>>>> +static void csi2_irq_ctx_set(struct iss_csi2_device *csi2, int en=
able)
>>>> +{
>>>> + =A0 =A0 u32 reg =3D CSI2_CTX_IRQ_FE;
>>>> + =A0 =A0 int i;
>>>> +
>>>> + =A0 =A0 if (csi2->use_fs_irq)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_IRQ_FS;
>>>> +
>>>> + =A0 =A0 for (i =3D 0; i< =A08; i++) {
>>>
>>>
>>> 8 =3D=3D number of contexts?
>>
>>
>> Yes. This loops from 0 to 7.
>>
>> Are you implying that I need to add a define to this?
>
>
> I think something that tells it is the number of contexts would be ni=
cer.
>
> ...
>
>
>>>> + =A0 =A0 writel(readl(csi2->regs1 + CSI2_SYSCONFIG) |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_SYSCONFIG_SOFT_RESET,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_SYSCONFIG);
>>>> +
>>>> + =A0 =A0 do {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_SYSSTAT=
US)&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
CSI2_SYSSTATUS_RESET_DONE;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (reg =3D=3D CSI2_SYSSTATUS_RESET_DONE=
)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 soft_reset_retries++;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (soft_reset_retries< =A05)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(100);
>>>
>>>
>>> How about usleep_range() here? Or omit such a long busyloop. Hardwa=
re
>>> typically resets quite fast.
>>
>>
>> I guess i'll try to fine-tune this then.
>
>
> I think it's fine to replace it with usleep_range() for now. Fine
> optimisations can be left for later if really needed.
>
> ...
>
>
>>>> +static void csi2_print_status(struct iss_csi2_device *csi2)
>>>> +{
>>>> + =A0 =A0 struct iss_device *iss =3D csi2->iss;
>>>> +
>>>> + =A0 =A0 if (!csi2->available)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 dev_dbg(iss->dev, "-------------CSI2 Register
>>>> dump-------------\n");
>>>> +
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SYSCONFIG);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SYSSTATUS);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, IRQENABLE);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, IRQSTATUS);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTRL);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, DBG_H);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_CFG);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_IRQSTATU=
S);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SHORT_PACKET);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_IRQENABL=
E);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, DBG_P);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, TIMING);
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL1(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL2(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_DAT_OFST(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_PING_ADDR(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_PONG_ADDR(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_IRQENABLE(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_IRQSTATUS(0));
>>>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL3(0));
>>>> +
>>>> + =A0 =A0 dev_dbg(iss->dev,
>>>> "--------------------------------------------\n");
>>>
>>>
>>> _If_ this is user-triggered, you might want to consider using debug=
fs for
>>> the same. Just FYI.
>>
>>
>> Ok. I'll see what can I do.
>
>
> Just FYI. :-) Thinking about this agian, debugfs might not go well wi=
th this
> since the prints may be triggered by the driver.
>
> ...
>
>
>>>> + =A0 =A0 /* Skip interrupts until we reach the frame skip count. =
The CSI2
>>>> will be
>>>> + =A0 =A0 =A0* automatically disabled, as the frame skip count has=
 been
>>>> programmed
>>>> + =A0 =A0 =A0* in the CSI2_CTx_CTRL1::COUNT field, so reenable it.
>>>> + =A0 =A0 =A0*
>>>> + =A0 =A0 =A0* It would have been nice to rely on the FRAME_NUMBER=
 interrupt
>>>> instead
>>>> + =A0 =A0 =A0* but it turned out that the interrupt is only genera=
ted when the
>>>> CSI2
>>>> + =A0 =A0 =A0* writes to memory (the CSI2_CTx_CTRL1::COUNT field i=
s decreased
>>>> + =A0 =A0 =A0* correctly and reaches 0 when data is forwarded to t=
he video
>>>> port only
>>>> + =A0 =A0 =A0* but no interrupt arrives). Maybe a CSI2 hardware bu=
g.
>>>> + =A0 =A0 =A0*/
>>>> + =A0 =A0 if (csi2->frame_skip) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->frame_skip--;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->frame_skip =3D=3D 0) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->format_id =3D csi2_=
ctx_map_format(csi2);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_config(csi2, ct=
x);
>>>
>>>
>>> Is configuration of the context needed elsewhere than in streamon? =
What
>>> changes while streaming?
>>
>>
>> Nothing I think...
>>
>> Same thing is done for OMAP3, so I tried to keep the driver as simil=
ar
>> as possible.
>
>
> Ok. Perhaps this could be fixed for OMAP 3, too. :-)

Actually, I just realized something while enabling ISP support for OMAP=
4.

If you have a sensor that returns something bigger than zero for
"g_skip_frames",
removing the csi2_ctx_config() call breaks VP output.

So, CSI2 is first enabled with VP only enabled, but the context format
doesn't have
a "+ VP", with a framecount =3D g_skip_frames... then when this is done=
,
and you have
a videoport, the next FE IRQ, ti hsould reconfigure the right VP
enabled context format.

This made me scratch my head several times when i wasn't receiving any
ISP interrupts :P

So please, don't try removing this from OMAP3 CSI2 driver! :)

Regards,
Sergio

>
>
>> I'll try removing this then.
>>
>
> ...
>
>>>> +/* This is not an exhaustive list */
>>>> +enum iss_csi2_pix_formats {
>>>> + =A0 =A0 CSI2_PIX_FMT_OTHERS =3D 0,
>>>> + =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT =3D 0x1e,
>>>> + =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT_VP =3D 0x9e,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16 =3D 0xab,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16_VP =3D 0x12f,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW8 =3D 0x2a,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW8_DPCM10_EXP16 =3D 0x2aa,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW8_DPCM10_VP =3D 0x32a,
>>>> + =A0 =A0 CSI2_PIX_FMT_RAW8_VP =3D 0x12a,
>>>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DPCM10_VP =3D 0x340,
>>>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DPCM10 =3D 0x2c0,
>>>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1 =3D 0x40,
>>>
>>>
>>> What are the USERDEF formats?
>>
>>
>> Again, inherited and adapted these from OMAP3 driver.
>>
>> Should I delete them?
>
>
> It's fine to keep them for now I guess --- Laurent must know what the=
y
> actually are. :-) Looks like CSI-2 pixel format codes (plus VP contro=
l, I
> guess).
>
> ...
>
>>>> +struct iss_video {
>>>> + =A0 =A0 struct video_device video;
>>>> + =A0 =A0 enum v4l2_buf_type type;
>>>> + =A0 =A0 struct media_pad pad;
>>>> +
>>>> + =A0 =A0 struct mutex mutex; =A0 =A0 =A0 =A0 =A0 =A0 /* format an=
d crop settings */
>>>> + =A0 =A0 atomic_t active;
>>>> +
>>>> + =A0 =A0 struct iss_device *iss;
>>>> +
>>>> + =A0 =A0 unsigned int capture_mem;
>>>> + =A0 =A0 unsigned int bpl_alignment; =A0 =A0 /* alignment value *=
/
>>>> + =A0 =A0 unsigned int bpl_zero_padding; =A0/* whether the alignme=
nt is
>>>> optional */
>>>> + =A0 =A0 unsigned int bpl_max; =A0 =A0 =A0 =A0 =A0 /* maximum byt=
es per line value */
>>>> + =A0 =A0 unsigned int bpl_value; =A0 =A0 =A0 =A0 /* bytes per lin=
e value */
>>>> + =A0 =A0 unsigned int bpl_padding; =A0 =A0 =A0 /* padding at end =
of line */
>>>> +
>>>> + =A0 =A0 /* Entity video node streaming */
>>>> + =A0 =A0 unsigned int streaming:1;
>>>> +
>>>> + =A0 =A0 /* Pipeline state */
>>>> + =A0 =A0 struct iss_pipeline pipe;
>>>> + =A0 =A0 struct mutex stream_lock; =A0 =A0 =A0 /* pipeline and st=
ream states */
>>>> +
>>>> + =A0 =A0 /* Video buffers queue */
>>>> + =A0 =A0 struct vb2_queue *queue;
>>>> + =A0 =A0 spinlock_t qlock; =A0 =A0 =A0 /* Spinlock for dmaqueue *=
/
>>>> + =A0 =A0 struct list_head dmaqueue;
>>>> + =A0 =A0 enum iss_video_dmaqueue_flags dmaqueue_flags;
>>>> + =A0 =A0 struct vb2_alloc_ctx *alloc_ctx;
>>>> +
>>>> + =A0 =A0 const struct iss_video_operations *ops;
>>>> +};
>>>> +
>>>> +#define to_iss_video(vdev) =A0 container_of(vdev, struct iss_vide=
o,
>>>> video)
>>>> +
>>>> +struct iss_video_fh {
>>>> + =A0 =A0 struct v4l2_fh vfh;
>>>> + =A0 =A0 struct iss_video *video;
>>>> + =A0 =A0 struct vb2_queue queue;
>>>> + =A0 =A0 struct v4l2_format format;
>>>
>>>
>>> Format shouldn't be part of the file handle anymore. There was a re=
ason
>>> for
>>> it in the past before PREPARE_BUF --- which is also supported by
>>> videobuf2.
>>
>>
>> Ok. So should I just remove it completely?
>>
>> Sorry if i'm not understanding this PREPARE_BUF thing... What should=
 I
>> have there?
>
>
> PREPARE_BUF prepares the buffer for the use in the device's DMA engin=
e. This
> is exactly what QBUF does, except that PREPARE_BUF doesn't put the bu=
ffer to
> the driver's queue (calling QBUF will then do that, and only that).
>
> Together with CREATE_BUFS this allows having different kinds of buffe=
rs in
> the same queue. This didn't use to be possible.
>
> Think of sets of buffers for still capture and viewfinder. They can n=
ow
> co-exist in the same queue.
>
> Kind regards,
>
> --
> Sakari Ailus
> sakari.ailus@iki.fi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
