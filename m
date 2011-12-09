From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Fri, 9 Dec 2011 12:34:01 +0800
Message-ID: <CACVXFVOj_OGxSqRp+2fJ-nQQrkpv3vLwocP=8qdyXncUhyqESA@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
	<1322838172-11149-6-git-send-email-ming.lei@canonical.com>
	<4EDD428B.9010800@gmail.com>
	<CACVXFVMR_n946HW1eYWEfcig_D6wFx5e3vEKmVHtERcmtsXX6g@mail.gmail.com>
	<4EE139D1.4030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EE139D1.4030503@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 9, 2011 at 6:27 AM, Sylwester Nawrocki <snjw23@gmail.com> w=
rote:
> On 12/08/2011 04:42 AM, Ming Lei wrote:
>>>> +/**
>>>> + * struct v4l2_obj_detection
>>>> + * @buf_index: =A0 =A0 =A0 entry, index of v4l2_buffer for face d=
etection
>
> I would prefer having the frame sequence number here. It will be more
> future proof IMHO. If for instance we decide to use such an ioctl on
> a v4l2 sub-device, without dequeuing buffers, there will be no proble=
m
> with that. And still in your specific use case it's not big deal to
> look up the buffer index given it's sequence number in the applicatio=
n.

OK, take your suggestion to use frame index, but I still have question
about it, see my question in another thread.

>
>>>> + * @centerx: return, position in x direction of detected object
>>>> + * @centery: return, position in y direction of detected object
>>>> + * @angle: =A0 return, angle of detected object
>>>> + * =A0 =A0 =A0 =A0 =A0 0 deg ~ 359 deg, vertical is 0 deg, clockw=
ise
>>>> + * @sizex: =A0 return, size in x direction of detected object
>>>> + * @sizey: =A0 return, size in y direction of detected object
>>>> + * @confidence: =A0 =A0 =A0return, confidence level of detection =
result
>>>> + * =A0 =A0 =A0 =A0 =A0 0: the heighest level, 9: the lowest level
>>>
>>> Hmm, not a good idea to align a public interface to the capabilitie=
s
>>> of a single hardware implementation.
>>
>> I think that the current omap interface is general enough, so why ca=
n't
>> we use it as public interface?
>
> I meant exactly the line implying the range. What if for some hardwar=
e
> it's 0..11 ?

We can let driver to normalize it to user which doesn't care if the ran=
ge
is 0~11 or 10~21, a uniform range should always make user happy,
shouldn't it?

>
>>
>>> min/max confidence could be queried with
>>> relevant controls and here we could remove the line implying range.
>>
>> No, the confidence is used to describe the probability about
>> the correctness of the current detection result. Anyway, no FD can
>> make sure that it is 100% correct. =A0Other HW can normalize its
>> confidence level to 0~9 so that application can handle it easily, IM=
O.
>
> 1..100 might be better, to minimize rounding errors. Nevertheless IMO=
 if we
> can export an exact range supported by FD device we should do it, and=
 let
> upper layers do the normalization. And the bigger numbers should mean=
 higher
> confidence, consistently for all devices.

Looks 1..100 is better, and I will change it to 1..100.

>
> Do you think we could assume that the FD threshold range (FD_LHIT reg=
ister
> in case of OMAP4) is always same as the result confidence level ?

No, they are different. FD_LHIT is used to guild FD HW to detect more
faces but more false positives __or__ less faces but less false positiv=
es.

A control class is needed to be introduced for adjusting this value of =
=46D
HW, and I think a normalized range is better too.

>
> If so then the confidence level range could possibly be queried with =
the
> detection threshold control. We could name it V4L2_CID_FD_CONFIDENCE_=
THRESHOLD

As I said above, there is no advantage to export the range to user, and=
 a
uniform range will make user happy.

> for example.
> I could take care of preparing the control class draft and the docume=
ntation
> for it.

It is great to hear it, :-)

>
>>
>>>> + * @reserved: =A0 =A0 =A0 =A0future extensions
>>>> + */
>>>> +struct v4l2_obj_detection {
>
> How about changing name of this structure to v4l2_fd_primitive or v4l=
2_fd_shape ?
>

I think v4l2_obj_detection is better because it can be reused to descri=
be
some other kind of object detection from video in the future.

>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 centerx;
>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 centery;
>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 angle;
>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 sizex;
>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 sizey;
>>>
>>> How about using struct v4l2_rect in place of centerx/centery, sizex=
/sizey ?
>>> After all it describes a rectangle. We could also use struct v4l2_f=
rmsize_discrete
>>> for size but there seems to be missing en equivalent for position, =
e.g.
>>
>> Maybe user space would like to plot a circle or ellipse over the det=
ected
>> objection, and I am sure that I have seen this kind of plot over det=
ected
>> face before.
>
> OK, in any way I suggest to replace all __u16 with __u32, to minimize=
 performance
> issues and be consistent with the data type specifying pixel values e=
lsewhere in
> V4L.

OK, but may introduce more memory footprint for the fd result.

> It makes sense to make 'confidence' __u32 as well and add a flags att=
ribute to
> indicate the shape.

Sounds good.

>
>>>
>>>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 confidence;
>>>> + =A0 =A0 __u32 =A0 =A0 =A0 =A0 =A0 reserved[4];
>
> And then
> =A0 =A0 =A0 =A0 =A0__u32 =A0 =A0 =A0 =A0 =A0 reserved[10];
>
> or
> =A0 =A0 =A0 =A0 =A0__u32 =A0 =A0 =A0 =A0 =A0 reserved[2];
>
>>>> +};
>>>> +
>>>> +#define V4L2_FD_HAS_LEFT_EYE 0x1
>>>> +#define V4L2_FD_HAS_RIGHT_EYE =A0 =A0 =A0 =A00x2
>>>> +#define V4L2_FD_HAS_MOUTH =A0 =A00x4
>>>> +#define V4L2_FD_HAS_FACE =A0 =A0 0x8
>
> Do you think we could change it to:
>
> #define V4L2_FD_FL_LEFT_EYE =A0 =A0 (1 << 0)
> #define V4L2_FD_FL_RIGHT_EYE =A0 =A0(1 << 1)
> #define V4L2_FD_FL_MOUTH =A0 =A0 =A0 =A0(1 << 2)
> #define V4L2_FD_FL_FACE =A0 =A0 =A0 =A0 (1 << 3)

OK

> and add:
>
> #define V4L2_FD_FL_SMILE =A0 =A0 =A0 =A0(1 << 4)
> #define V4L2_FD_FL_BLINK =A0 =A0 =A0 =A0(1 << 5)

Do you have any suggestion about how to describe this kind of
detection?

>>>> +
>>>> +/**
>>>> + * struct v4l2_fd_detection - VIDIOC_G_FD_RESULT argument
>>>> + * @flag: =A0 =A0return, describe which objects are detected
>>>> + * @left_eye: =A0 =A0 =A0 =A0return, left_eye position if detecte=
d
>>>> + * @right_eye: =A0 =A0 =A0 return, right_eye position if detected
>>>> + * @mouth_eye: =A0 =A0 =A0 return, mouth_eye position if detected
>>>
>>> mouth_eye ? ;)
>>
>> Sorry, it should be mouth, :-)
>
> :) also the word return could be omitted.
>
>>
>>>
>>>> + * @face: =A0 =A0return, face position if detected
>>>> + */
>>>> +struct v4l2_fd_detection {
>
> How about changing the name to v4l2_fd_object ?

I think the structure is used to describe one single detection result w=
hich
may include several kind of objects detected, so sounds
v4l2_fd_detection is better than v4l2_fd_object(s?).

>
>>>> + =A0 =A0 __u32 =A0 flag;
>>>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 left_eye;
>>>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 right_eye;
>>>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 mouth;
>>>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 face;
>>>
>>> I would do this differently, i.e. put "flag" inside struct v4l2_obj=
_detection
>>> and then struct v4l2_fd_detection would be simply an array of
>>> struct v4l2_obj_detection, i.e.
>>>
>>> struct v4l2_fd_detection {
>>> =A0 =A0 =A0 =A0unsigned int count;
>>> =A0 =A0 =A0 =A0struct v4l2_obj_detection [V4L2_MAX_FD_OBJECT_NUM];
>>> };
>>>
>>> This might be more flexible, e.g. if in the future some hardware su=
pports
>>> detecting wrinkles, we could easily add that by just defining a new=
 flag:
>>> V4L2_FD_HAS_WRINKLES, etc.
>>
>> This is a bit flexible, but not explicit enough for describing
>> interface, how about reserving these as below for future usage?
>>
>> =A0 =A0 =A0 struct v4l2_fd_detection {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u32 =A0 flag;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Struct v4l2_obj_detection =A0 =A0 =A0 le=
ft_eye;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Struct v4l2_obj_detection =A0 =A0 =A0 ri=
ght_eye;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Struct v4l2_obj_detection =A0 =A0 =A0 mo=
uth;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Struct v4l2_obj_detection =A0 =A0 =A0 fa=
ce;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Struct v4l2_obj_detection =A0 =A0 =A0 re=
served[4];
>> =A0 =A0 =A0 };
>
> OK, and how about this:
>
> =A0 =A0 =A0 =A0struct v4l2_fd_object {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_fd_shape =A0 =A0left_eye;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_fd_shape =A0 =A0right_eye;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_fd_shape =A0 =A0mouth;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_fd_shape =A0 =A0face;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 reserved[33];

Why is struct 'v4l2_fd_shape =A0 =A0reserved[4]' removed?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 flags;
> =A0 =A0 =A0 =A0} __packed;

Why is '__packed' needed? It will introduce performance loss if we have
not good reason to do it.


thanks,
--
Ming Lei
