From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 6/7] media: video: introduce face detection driver module
Date: Wed, 7 Dec 2011 21:40:41 +0800
Message-ID: <CACVXFVN=-0OQ_Tz+HznDug4baLmLNjxVE21gv6CGFoU+hzCtPQ@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
	<1322838172-11149-7-git-send-email-ming.lei@canonical.com>
	<4EDD3DEE.6060506@gmail.com>
	<CACVXFVPrAro=3t-wpbR_cVahzcx7SCa2J=s2nyyKfQ6SG-i0VQ@mail.gmail.com>
	<4EDE90A3.7050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EDE90A3.7050900@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 7, 2011 at 6:01 AM, Sylwester Nawrocki <snjw23@gmail.com> w=
rote:
> On 12/06/2011 03:07 PM, Ming Lei wrote:
>> Hi,
>>
>> Thanks for your review.
>>
>> On Tue, Dec 6, 2011 at 5:55 AM, Sylwester Nawrocki <snjw23@gmail.com=
> wrote:
>>> Hi Ming,
>>>
>>> (I've pruned the Cc list, leaving just the mailing lists)
>>>
>>> On 12/02/2011 04:02 PM, Ming Lei wrote:
>>>> This patch introduces one driver for face detection purpose.
>>>>
>>>> The driver is responsible for all v4l2 stuff, buffer management
>>>> and other general things, and doesn't touch face detection hardwar=
e
>>>> directly. Several interfaces are exported to low level drivers
>>>> (such as the coming omap4 FD driver)which will communicate with
>>>> face detection hw module.
>>>>
>>>> So the driver will make driving face detection hw modules more
>>>> easy.
>>>
>>>
>>> I would hold on for a moment on implementing generic face detection
>>> module which is based on the V4L2 video device interface. We need t=
o
>>> first define an API that would be also usable at sub-device interfa=
ce
>>> level (http://linuxtv.org/downloads/v4l-dvb-apis/subdev.html).
>>
>> If we can define a good/stable enough APIs between kernel and user s=
pace,
>> I think the patches can be merged first. For internal kernel APIs, w=
e should
>> allow it to evolve as new hardware comes or new features are to be i=
ntroduced.
>
> I also don't see a problem in discussing it a bit more;)

OK, fair enough, let's discuss it, :-)

>
>>
>> I understand the API you mentioned here should belong to kernel inte=
rnal
>> API, correct me if it is wrong.
>
> Yes, I meant the in kernel design, i.e. generic face detection kernel=
 module
> and an OMAP4 FDIF driver. It makes lots of sense to separate common c=
ode
> in this way, maybe even when there would be only OMAP devices using i=
t.

Yes, that is the motivation of the generic FD module. I think we can fo=
cus on
two use cases for the generic FD now:

- one is to detect faces from user space image data

- another one is to detect faces in image data generated from HW(SoC
internal bus, resize hardware)

=46or OMAP4 hardware, input data is always from physically continuous
memory directly, so it is very easy to support the two cases. For the
use case 2,
if buffer copy is to be avoided, we can use the coming shared dma-buf[1=
]
to pass the image buffer produced by other HW to FD hw directly.

=46or other FD hardware, if it supports to detect faces in image data f=
rom
physically continuous memory, I think the patch is OK to support it.

If the FD hw doesn't support to detect faces from physically continuous
memory, I have some questions: how does user space app to parse the
=46D result if application can't get the input image data? If user spac=
e can
get image data, how does it connect the image data with FD result? and
what standard v4l2 ways(v4l2_buffer?) can the app use to describe the
image data?

> I'm sure now the Samsung devices won't fit in video output node based=
 driver
> design. They read image data in different ways and also the FD result=
 format
> is totally different.

I think user space will need the FD result, so it is very important to =
define
API to describe the FD result format to user space. And the input about=
 your
=46D HW result format is certainly helpful to define the API.

>>
>>> AFAICS OMAP4 FDIF processes only data stored in memory, thus it see=
ms
>>> reasonable to use the videodev interface for passing data to the ke=
rnel
>>> from user space.
>>>
>>> But there might be face detection devices that accept data from oth=
er
>>> H/W modules, e.g. transferred through SoC internal data buses betwe=
en
>>> image processing pipeline blocks. Thus any new interfaces need to b=
e
>>> designed with such devices in mind.
>>>
>>> Also the face detection hardware block might now have an input DMA
>>> engine in it, the data could be fed from memory through some other
>>> subsystem (e.g. resize/colour converter). Then the driver for that
>>> subsystem would implement a video node.
>>
>> I think the direct input image or frame data to FD should be from me=
mory
>> no matter the actual data is from external H/W modules or input DMA =
because
>> FD will take lot of time to detect faces in one image or frame and F=
D can't
>> have so much memory to cache several images or frames data.
>
> Sorry, I cannot provide much details at the moment, but there exists =
hardware
> that reads data from internal SoC buses and even if it uses some sort=
 of
> cache memory it doesn't necessarily have to be available for the user=
=2E

Without some hardware background, it is not easy to give a generic FD m=
odule
design.

> Still the FD result is associated with an image frame for such H/W, b=
ut not
> necessarily with a memory buffer queued by a user application.

=46or user space application, it doesn't make sense to handle FD result=
s
only without image data.  Even though there are other ways of input
image data to FD, user space still need to know the image data, so it m=
akes
sense to associate FD result with a memory buffer.

> How long it approximately takes to process single image for OMAP4 FDI=
=46 ?

See the link[2], and my test result is basically consistent with the da=
ta.

>>
>> If you have seen this kind of FD hardware design, please let me know=
=2E
>>
>>> I'm for leaving the buffer handling details for individual drivers
>>> and focusing on a standard interface for applications, i.e. new
>>
>> I think leaving buffer handling details in generic FD driver or
>> individual drivers
>> doesn't matter now, since it don't have effect on interfaces between=
 kernel
>> and user space.
>
> I think you misunderstood me. I wasn't talking about core/driver modu=
le split,
> I meant we should not be making the user interface video node centric=
=2E
>
> I think for Samsung devices I'll need a capture video node for passin=
g

Why is it a capture video node instead of OUTPUT v4l2 device? I think t=
he
device name should be decided from the view of face detection function:
=46D need input image data and produce detection result.

> the result to the user. So instead of associating FD result with a bu=
ffer index

See the explanation above.

> we could try to use the frame sequence number (struct v4l2_buffer.seq=
uence,
> http://linuxtv.org/downloads/v4l-dvb-apis/buffer.html#v4l2-buffer).
>
> It might be much better as the v4l2 events are associated with the fr=
ame
> sequence. And if we use controls then you get control events for free=
,
> and each event carries a frame sequence number int it
> (http://linuxtv.org/downloads/v4l-dvb-apis/vidioc-dqevent.html).
>
> --
>
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

thanks,
--
Ming Lei

[1], http://marc.info/?t=3D132281644700005&r=3D1&w=3D2
[2], http://e2e.ti.com/support/embedded/linux/f/354/t/128938.aspx#46274=
0
