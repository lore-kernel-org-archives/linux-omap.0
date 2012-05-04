From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v3 07/10] arm: omap4430sdp: Add support for omap4iss camera
Date: Thu, 3 May 2012 22:20:47 -0500
Message-ID: <CAKnK67SZGES33T02Ki3imZi20OKRSRe+u9nONsq2KoEGVz4_0w@mail.gmail.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
 <1335971749-21258-8-git-send-email-saaguirre@ti.com> <20120502194700.GF852@valkosipuli.localdomain>
 <CAKnK67S5zZW0HAUYrg4ZqudiQqcOY+kbZeDeQ1OGU+s+cShBDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56747 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754650Ab2EDDVJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 23:21:09 -0400
Received: by qcso7 with SMTP id o7so1974988qcs.34
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 20:21:08 -0700 (PDT)
In-Reply-To: <CAKnK67S5zZW0HAUYrg4ZqudiQqcOY+kbZeDeQ1OGU+s+cShBDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org

Hi Sakari,

On Thu, May 3, 2012 at 7:03 AM, Aguirre, Sergio <saaguirre@ti.com> wrot=
e:
> Hi Sakari,
>
> Thanks for reviewing.
>
> On Wed, May 2, 2012 at 2:47 PM, Sakari Ailus <sakari.ailus@iki.fi> wr=
ote:
>>
>> Hi Sergio,
>>
>> Thanks for the patches!!
>>
>> On Wed, May 02, 2012 at 10:15:46AM -0500, Sergio Aguirre wrote:
>> ...
>>> +static int sdp4430_ov_cam1_power(struct v4l2_subdev *subdev, int o=
n)
>>> +{
>>> + =A0 =A0 struct device *dev =3D subdev->v4l2_dev->dev;
>>> + =A0 =A0 int ret;
>>> +
>>> + =A0 =A0 if (on) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!regulator_is_enabled(sdp4430_cam2pwr=
_reg)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_enable(=
sdp4430_cam2pwr_reg);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(d=
ev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Error in enabling sensor power regulator 'cam2pwr'\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return re=
t;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(50);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430SDP_GPIO_CAM_PDN_B=
, 1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_enable(sdp4430_cam1_aux_clk);=
 /* Enable XCLK */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Error in=
 clk_enable() in %s(%d)\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,=
 on);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430SD=
P_GPIO_CAM_PDN_B, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
>>> + =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(sdp4430_cam1_aux_clk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP4430SDP_GPIO_CAM_PDN_B=
, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_is_enabled(sdp4430_cam2pwr_=
reg)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_disable=
(sdp4430_cam2pwr_reg);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(d=
ev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Error in disabling sensor power regulator 'cam2pwr'\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return re=
t;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 return 0;
>>> +}
>>
>> Isn't this something that should be part of the sensor driver? There=
's
>> nothing in the above code that would be board specific, except the n=
ames of
>> the clocks, regulators and GPIOs. The sensor driver could hold the n=
ames
>> instead; this would be also compatible with the device tree.
>
> Agreed. I see what you mean...
>
> I'll take care of that.

Can you please check out these patches?

1. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/cb6c=
10d58053180364461e6bc8d30d1ec87e6e22
2. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/6732=
e0db25c6647b34ef8f01c244a49a1fd6b45d
3. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/d61c=
4e3142dc9cae972f9128fe73d986838c0ca1
4. http://gitorious.org/omap4-v4l2-camera/omap4-v4l2-camera/commit/e83f=
36001c7f7cbe184ad094d9b0c95c39e5028f

I want to see if I got your point properly...

Regards,
Sergio

>
>>
>> It should be possible to have s_power() callback NULL, too.
>>
>>> +static int sdp4430_ov_cam2_power(struct v4l2_subdev *subdev, int o=
n)
>>> +{
>>> + =A0 =A0 struct device *dev =3D subdev->v4l2_dev->dev;
>>> + =A0 =A0 int ret;
>>> +
>>> + =A0 =A0 if (on) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 gpoctl =3D 0;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_enable(sdp4430_cam2pwr_=
reg);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Error in=
 enabling sensor power regulator 'cam2pwr'\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(50);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (twl_i2c_read_u8(TWL_MODULE_AUDIO_VOIC=
E, &gpoctl,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 T=
WL6040_REG_GPOCTL))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (twl_i2c_write_u8(TWL_MODULE_AUDIO_VOI=
CE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
gpoctl | TWL6040_GPO3,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
TWL6040_REG_GPOCTL))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> The above piece of code looks quite interesting. What does it do?
>
> Well, this is because the camera adapter board in 4430SDP has 3
> sensors actually:
>
> - 1 Sony IMX060 12.1 MP sensor
> - 2 OmniVision OV5650 sensors
>
> And there's 3 wideband analog switches, like this:
>
> http://www.analog.com/static/imported-files/data_sheets/ADG936_936R.p=
df
>
> That basically select either IMX060 or OV5650 for CSI2A input.
>
> So, this commands are because the TWL6040 chip has a GPO pin to toggl=
e
> this, instead
> of an OMAP GPIO (Don't ask me why :) )
>
> Anyways... I see your point, maybe this should be explained better
> through a comment.
>
> Regards,
> Sergio
>>
>> Kind regards,
>>
>> --
>> Sakari Ailus
>> e-mail: sakari.ailus@iki.fi =A0 =A0 jabber/XMPP/Gmail: sailus@retiis=
i.org.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
