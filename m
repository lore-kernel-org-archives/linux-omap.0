From: Sylwester Nawrocki <snjw23@gmail.com>
Subject: Re: [RFC PATCH v1 6/7] media: video: introduce face detection driver
 module
Date: Mon, 12 Dec 2011 22:57:35 +0100
Message-ID: <4EE678CF.1020300@gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>	<1322838172-11149-7-git-send-email-ming.lei@canonical.com>	<4EDD3DEE.6060506@gmail.com>	<CACVXFVPrAro=3t-wpbR_cVahzcx7SCa2J=s2nyyKfQ6SG-i0VQ@mail.gmail.com>	<4EDE90A3.7050900@gmail.com>	<CACVXFVN=-0OQ_Tz+HznDug4baLmLNjxVE21gv6CGFoU+hzCtPQ@mail.gmail.com>	<4EE14787.8090509@gmail.com>	<CACVXFVNV3TLNvPMU4oj6X+Yj5wqhNvcU_ZpyCd1wMm8B2azT4w@mail.gmail.com>	<4EE4EBCF.8000202@gmail.com> <CACVXFVNjawdPEYHoXNxc3U2-H8f4VVF_+2HDruNGQwg16M8njA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <CACVXFVNjawdPEYHoXNxc3U2-H8f4VVF_+2HDruNGQwg16M8njA@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 12/12/2011 10:49 AM, Ming Lei wrote:
>>> If FD result is associated with a frame, how can user space get the frame
>>> seq if no v4l2 buffer is involved? Without a frame sequence, it is a bit
>>> difficult to retrieve FD results from user space.
>>
>> If you pass image data in memory buffers from user space, yes, it could be
>> impossible.
> 
> It is easy to get the frame sequence from v4l2_buffer for the case too, :-)

Oops, have mixed something up ;)

>> Not really, still v4l2_buffer may be used by other (sub)driver within same
>> video processing pipeline.
> 
> OK.
> 
> A related question: how can we make one application to support the two kinds 
> of devices(input from user space data as OMAP4, input from SoC bus as Samsung)
> at the same time? Maybe some capability info is to be exported to user space?
> or other suggestions?

Good question. To let applications know that a video device is not just
an ordinary video output device I suppose we'll need a new object
detection/recognition capability flag.
V4L2_CAPS_OBJECT_DETECTION, V4L2_CAP_OBJECT_RECOGNITION or something similar.

It's probably safe to assume the SoC will support either input method at time,
not both simultaneously. Then it could be, for example, modelled with a video
node and a subdev:


	     user image data                   video capture
             for FD                            stream
             +-------------+                  +-------------+
             | /dev/video0 |                  | /dev/video0 |
             |   OUTPUT    |                  |  CAPTURE    |
             +------+------+                  +------+------+
                    |                                |
                    v                                ^
..------+        +--+--+----------+-----+            |
image   | link0  | pad | face     | pad |            |
sensor  +-->-----+  0  | detector |  1  |            |
sub-dev +-->-+   |     | sub-dev  |     |            |
..------+    |   +-----+----------+-----+            |
             |                                       |
             |   +--+--+------------+-----+          |
             |   | pad | image      | pad |          |
             +---+  0  | processing |  1  +----------+
          link1  |     | sub-dev    |     |
                 +-----+------------+-----+

User space can control state of link0. If the link is active (streaming) then
access to /dev/video0 would be blocked by the driver, e.g. with EBUSY errno.
This means that only one data source can be attached to an input pad (pad0).
These are intrinsic properties of Media Controller/v4l2 subdev API.


> And will your Samsung FD HW support to detect faces from memory? or just only
> detect from SoC bus?

I think we should be prepared for both configurations, as on a diagram above.

[...]
> OK, I will associate FD result with frame identifier, and not invent a
> dedicated v4l2 event for query frame seq now until a specific requirement
> for it is proposed.
> 
> I will convert/integrate recent discussions into patches of v2 for further

Sure, sounds like a good idea.

> review, and sub device support will be provided. But before starting to do it,
> I am still not clear how to integrate FD into MC framework. I understand FD
> sub device is only a media entity, so how can FD sub device find the media
> device(struct media_device)?  or just needn't to care about it now?

The media device driver will register all entities that belong to it and will
create relevant links between entities' pads, which then can be activated by
applications. How the entities are registered is another topic, that we don't
need to be concerned about at the moment. If you're curious see
drivers/media/video/omap3isp or driver/media/video/s5p-fimc for example media
device drivers.

-- 
Regards,
Sylwester
