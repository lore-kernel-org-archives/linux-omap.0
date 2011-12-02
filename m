From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 03/11] v4l: Introduce sensor operation for getting
 interface configuration
Date: Fri, 2 Dec 2011 10:04:42 -0600
Message-ID: <CAKnK67REjC110pywXA+Uy_6N7UEibsci=EDbsUw3CqrQWp+ZKA@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-4-git-send-email-saaguirre@ti.com> <4ED8D374.1030206@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4ED8D374.1030206@mm-sol.com>
Sender: linux-media-owner@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi Stan,

On Fri, Dec 2, 2011 at 7:32 AM, Stanimir Varbanov <svarbanov@mm-sol.com=
> wrote:
> Hi, Sergio
>
> This change in interface is not used from the omap4iss driver.
>
> You could drop it from the patch set, if so.

Oops, yes... I used to depend on this for my soc_camera implementation =
before...

You're absolutely right, i'll remove it in the next iteration.

Merci!

>
> On 12/01/2011 02:14 AM, Sergio Aguirre wrote:
>> From: Stanimir Varbanov <svarbanov@mm-sol.com>
>>
>> Introduce g_interface_parms sensor operation for getting sensor
>> interface parameters. These parameters are needed from the host side
>> to determine it's own configuration.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> ---
>> =A0include/media/v4l2-subdev.h | =A0 42 ++++++++++++++++++++++++++++=
++++++++++++++
>> =A01 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev=
=2Eh
>> index f0f3358..0d322ed 100644
>> --- a/include/media/v4l2-subdev.h
>> +++ b/include/media/v4l2-subdev.h
>> @@ -362,6 +362,42 @@ struct v4l2_subdev_vbi_ops {
>> =A0 =A0 =A0 int (*s_sliced_fmt)(struct v4l2_subdev *sd, struct v4l2_=
sliced_vbi_format *fmt);
>> =A0};
>>
>> +/* Which interface the sensor use to provide it's image data */
>> +enum v4l2_subdev_sensor_iface {
>> + =A0 =A0 V4L2_SUBDEV_SENSOR_PARALLEL,
>> + =A0 =A0 V4L2_SUBDEV_SENSOR_SERIAL,
>> +};
>> +
>> +/* Each interface could use the following modes */
>> +/* Image sensor provides horizontal and vertical sync signals */
>> +#define V4L2_SUBDEV_SENSOR_MODE_PARALLEL_SYNC =A0 =A0 =A0 =A00
>> +/* BT.656 interface. Embedded sync */
>> +#define V4L2_SUBDEV_SENSOR_MODE_PARALLEL_ITU 1
>> +/* MIPI CSI1 */
>> +#define V4L2_SUBDEV_SENSOR_MODE_SERIAL_CSI1 =A02
>> +/* MIPI CSI2 */
>> +#define V4L2_SUBDEV_SENSOR_MODE_SERIAL_CSI2 =A03
>> +
>> +struct v4l2_subdev_sensor_serial_parms {
>> + =A0 =A0 unsigned char lanes; =A0 =A0 =A0 =A0 =A0 =A0/* number of l=
anes used */
>> + =A0 =A0 unsigned char channel; =A0 =A0 =A0 =A0 =A0/* virtual chann=
el */
>> + =A0 =A0 unsigned int phy_rate; =A0 =A0 =A0 =A0 =A0/* output rate a=
t CSI phy in bps */
>> + =A0 =A0 unsigned int pix_clk; =A0 =A0 =A0 =A0 =A0 /* pixel clock i=
n Hz */
>> +};
>> +
>> +struct v4l2_subdev_sensor_parallel_parms {
>> + =A0 =A0 unsigned int pix_clk; =A0 =A0 =A0 =A0 =A0 /* pixel clock i=
n Hz */
>> +};
>> +
>> +struct v4l2_subdev_sensor_interface_parms {
>> + =A0 =A0 enum v4l2_subdev_sensor_iface if_type;
>> + =A0 =A0 unsigned int if_mode;
>> + =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_sensor_serial_parms ser=
ial;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_sensor_parallel_parms p=
arallel;
>> + =A0 =A0 } parms;
>> +};
>> +
>> =A0/**
>> =A0 * struct v4l2_subdev_sensor_ops - v4l2-subdev sensor operations
>> =A0 * @g_skip_top_lines: number of lines at the top of the image to =
be skipped.
>> @@ -371,10 +407,16 @@ struct v4l2_subdev_vbi_ops {
>> =A0 * @g_skip_frames: number of frames to skip at stream start. This=
 is needed for
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0buggy sensors that generate faulty =
frames when they are
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0turned on.
>> + * @g_interface_parms: get sensor interface parameters. The sensor =
subdev should
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fill this structure with curr=
ent interface params. These
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interface parameters are need=
ed on host side to configure
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0it's own hardware receivers.
>> =A0 */
>> =A0struct v4l2_subdev_sensor_ops {
>> =A0 =A0 =A0 int (*g_skip_top_lines)(struct v4l2_subdev *sd, u32 *lin=
es);
>> =A0 =A0 =A0 int (*g_skip_frames)(struct v4l2_subdev *sd, u32 *frames=
);
>> + =A0 =A0 int (*g_interface_parms)(struct v4l2_subdev *sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_sensor_=
interface_parms *parms);
>> =A0};
>>
>> =A0/*
>
>
> --
> best regards,
> Stan
