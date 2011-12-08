From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Thu, 8 Dec 2011 11:42:10 +0800
Message-ID: <CACVXFVMR_n946HW1eYWEfcig_D6wFx5e3vEKmVHtERcmtsXX6g@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
	<1322838172-11149-6-git-send-email-ming.lei@canonical.com>
	<4EDD428B.9010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EDD428B.9010800@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 6, 2011 at 6:15 AM, Sylwester Nawrocki <snjw23@gmail.com> w=
rote:
> On 12/02/2011 04:02 PM, Ming Lei wrote:
>> This patch introduces two new IOCTLs and related data
>> structure defination which will be used by the coming
>> face detection video device.
>>
>> The two IOCTLs and related data structure are used by
>> user space application to retrieve the results of face
>> detection. They can be called after one v4l2_buffer
>> has been ioctl(VIDIOC_DQBUF) and before it will be
>> ioctl(VIDIOC_QBUF).
>>
>> The utility fdif[1] is useing the two IOCTLs to find
>> faces deteced in raw images or video streams.
>>
>> [1],http://kernel.ubuntu.com/git?p=3Dming/fdif.git;a=3Dshortlog;h=3D=
refs/heads/v4l2-fdif
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0drivers/media/video/v4l2-ioctl.c | =A0 38 ++++++++++++++++++++
>> =A0include/linux/videodev2.h =A0 =A0 =A0 =A0| =A0 70 +++++++++++++++=
+++++++++++++++++++++++
>> =A0include/media/v4l2-ioctl.h =A0 =A0 =A0 | =A0 =A06 +++
>> =A03 files changed, 114 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/media/video/v4l2-ioctl.c b/drivers/media/video/=
v4l2-ioctl.c
>> index e1da8fc..fc6266f 100644
>> --- a/drivers/media/video/v4l2-ioctl.c
>> +++ b/drivers/media/video/v4l2-ioctl.c
>> @@ -2140,6 +2140,30 @@ static long __video_do_ioctl(struct file *fil=
e,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbgarg(cmd, "index=3D%d", b->index);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> + =A0 =A0 case VIDIOC_G_FD_RESULT:
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fd_result *fr =3D arg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ops->vidioc_g_fd_result)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ops->vidioc_g_fd_result(file, fh, =
fr);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dbgarg(cmd, "index=3D%d", fr->buf_index);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 case VIDIOC_G_FD_COUNT:
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fd_count *fc =3D arg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ops->vidioc_g_fd_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ops->vidioc_g_fd_count(file, fh, f=
c);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dbgarg(cmd, "index=3D%d", fc->buf_index);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ops->vidioc_default)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> @@ -2234,6 +2258,20 @@ static int check_array_args(unsigned int cmd,=
 void *parg, size_t *array_size,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 case VIDIOC_G_FD_RESULT: {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fd_result *fr =3D parg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (fr->face_cnt !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *user_ptr =3D (void __user=
 *)fr->fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *kernel_ptr =3D (void *)&f=
r->fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *array_size =3D sizeof(str=
uct v4l2_fd_detection)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * =
fr->face_cnt;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
>> index 4b752d5..073eb4d 100644
>> --- a/include/linux/videodev2.h
>> +++ b/include/linux/videodev2.h
>> @@ -2160,6 +2160,74 @@ struct v4l2_create_buffers {
>> =A0 =A0 =A0 __u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reserved[8];
>> =A0};
>>
>> +/**
>> + * struct v4l2_obj_detection
>> + * @buf_index: =A0 =A0 =A0 entry, index of v4l2_buffer for face det=
ection
>> + * @centerx: return, position in x direction of detected object
>> + * @centery: return, position in y direction of detected object
>> + * @angle: =A0 return, angle of detected object
>> + * =A0 =A0 =A0 =A0 =A0 0 deg ~ 359 deg, vertical is 0 deg, clockwis=
e
>> + * @sizex: =A0 return, size in x direction of detected object
>> + * @sizey: =A0 return, size in y direction of detected object
>> + * @confidence: =A0 =A0 =A0return, confidence level of detection re=
sult
>> + * =A0 =A0 =A0 =A0 =A0 0: the heighest level, 9: the lowest level
>
> Hmm, not a good idea to align a public interface to the capabilities
> of a single hardware implementation.

I think that the current omap interface is general enough, so why can't
we use it as public interface?

> min/max confidence could be queried with
> relevant controls and here we could remove the line implying range.

No, the confidence is used to describe the probability about
the correctness of the current detection result. Anyway, no FD can
make sure that it is 100% correct.  Other HW can normalize its
confidence level to 0~9 so that application can handle it easily, IMO.

>> + * @reserved: =A0 =A0 =A0 =A0future extensions
>> + */
>> +struct v4l2_obj_detection {
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 centerx;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 centery;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 angle;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 sizex;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 sizey;
>
> How about using struct v4l2_rect in place of centerx/centery, sizex/s=
izey ?
> After all it describes a rectangle. We could also use struct v4l2_frm=
size_discrete
> for size but there seems to be missing en equivalent for position, e.=
g.

Maybe user space would like to plot a circle or ellipse over the detect=
ed
objection, and I am sure that I have seen this kind of plot over detect=
ed
face before.

> struct v4l2_position {
> =A0 =A0 =A0 =A0__s32 x;
> =A0 =A0 =A0 =A0__s32 y;
> };
>
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 confidence;
>> + =A0 =A0 __u32 =A0 =A0 =A0 =A0 =A0 reserved[4];
>> +};
>> +
>> +#define V4L2_FD_HAS_LEFT_EYE 0x1
>> +#define V4L2_FD_HAS_RIGHT_EYE =A0 =A0 =A0 =A00x2
>> +#define V4L2_FD_HAS_MOUTH =A0 =A00x4
>> +#define V4L2_FD_HAS_FACE =A0 =A0 0x8
>> +
>> +/**
>> + * struct v4l2_fd_detection - VIDIOC_G_FD_RESULT argument
>> + * @flag: =A0 =A0return, describe which objects are detected
>> + * @left_eye: =A0 =A0 =A0 =A0return, left_eye position if detected
>> + * @right_eye: =A0 =A0 =A0 return, right_eye position if detected
>> + * @mouth_eye: =A0 =A0 =A0 return, mouth_eye position if detected
>
> mouth_eye ? ;)

Sorry, it should be mouth, :-)

>
>> + * @face: =A0 =A0return, face position if detected
>> + */
>> +struct v4l2_fd_detection {
>> + =A0 =A0 __u32 =A0 flag;
>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 left_eye;
>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 right_eye;
>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 mouth;
>> + =A0 =A0 struct v4l2_obj_detection =A0 =A0 =A0 face;
>
> I would do this differently, i.e. put "flag" inside struct v4l2_obj_d=
etection
> and then struct v4l2_fd_detection would be simply an array of
> struct v4l2_obj_detection, i.e.
>
> struct v4l2_fd_detection {
> =A0 =A0 =A0 =A0unsigned int count;
> =A0 =A0 =A0 =A0struct v4l2_obj_detection [V4L2_MAX_FD_OBJECT_NUM];
> };
>
> This might be more flexible, e.g. if in the future some hardware supp=
orts
> detecting wrinkles, we could easily add that by just defining a new f=
lag:
> V4L2_FD_HAS_WRINKLES, etc.

This is a bit flexible, but not explicit enough for describing
interface, how about
reserving these as below for future usage?

	struct v4l2_fd_detection {
		__u32   flag;
		Struct v4l2_obj_detection       left_eye;
		Struct v4l2_obj_detection       right_eye;
		Struct v4l2_obj_detection       mouth;
		Struct v4l2_obj_detection       face;
		Struct v4l2_obj_detection       reserved[4];
	};


thanks,
--
Ming Lei
