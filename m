From: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Subject: Re: [REVIEW PATCH 09/14] OMAP: CAM: Add ISP Core
Date: Tue, 3 Mar 2009 08:12:46 +0900
Message-ID: <5e9665e10903021512i31868531l286ac159d682480d@mail.gmail.com>
References: <5e9665e10903020009y7fe7d0d0j356708e1c3149cac@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89442E0B5C1E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:21551 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZCBXMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 18:12:48 -0500
In-Reply-To: <A24693684029E5489D1D202277BE89442E0B5C1E@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Nagalla, Hari" <hnagalla@ti.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

Hi.

Thank you for your reply.
I'm looking forward to see Sakari's new patch :)
Cheers,

Nate

On Tue, Mar 3, 2009 at 4:37 AM, Aguirre Rodriguez, Sergio Alberto
<saaguirre@ti.com> wrote:
> Hi Nate,
>
>> -----Original Message-----
>> From: DongSoo(Nathaniel) Kim [mailto:dongsoo.kim@gmail.com]
>> Sent: Monday, March 02, 2009 2:10 AM
>> To: Aguirre Rodriguez, Sergio Alberto
>> Cc: linux-omap@vger.kernel.org; video4linux-list@redhat.com; Nagalla=
,
>> Hari; Sakari Ailus; Tuukka.O Toivonen; linux-media@vger.kernel.org
>> Subject: Re: [REVIEW PATCH 09/14] OMAP: CAM: Add ISP Core
>>
>> Hello,
>>
>> reviewing ISP driver, I found that we've got no querymenu support in
>> ISP and also omap3 camera interface driver.
>
> Sakari is about to repost our latest progress on this driver, and exa=
ctly one of the changes we did is added this support for querymenu on b=
oth camera and ISP drivers.
>
>>
>> +/**
>> + * struct vcontrol - Video control structure.
>> + * @qc: V4L2 Query control structure.
>> + * @current_value: Current value of the control.
>> + */
>> +static struct vcontrol {
>> + =A0 =A0 =A0 struct v4l2_queryctrl qc;
>> + =A0 =A0 =A0 int current_value;
>> +} video_control[] =3D {
>>
>> <snip>
>>
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D V4L2_CID_PRIVA=
TE_ISP_COLOR_FX,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D V4L2_CTRL_TY=
PE_INTEGER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "Color Effec=
ts",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .minimum =3D PREV_DEFA=
ULT_COLOR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maximum =3D PREV_BW_C=
OLOR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .step =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_value =3D PRE=
V_DEFAULT_COLOR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .current_value =3D PREV_DEFAULT_COLOR,
>> + =A0 =A0 =A0 }
>> +};
>>
>> I think we should make it menu type for this color FX control.
>> If that kind of control has no menu information, user has no way to
>> figure out what kind of FX supported by device.
>> BTW if we make querymenu support in omap3 camera subsystem, we shoul=
d
>> make querymenu support for v4l2 int device also.
>> I think I've seen before a patch which intent to use querymenu in v4=
l2
>> int device, but no patch for omap3 ISP and camera interface.
>> Can I make a patch and post on linux-omap, linux-media list? of cour=
se
>> if you don't mind.
>> Or...am I digging wrong way? I mean.. querymenu for omap3 camera sub=
system.
>> Please let me know :)
>
> Please hold a bit, as we expect to repost the driver again this week.
>
> This control is now substituted by V4L2_CID_COLORFX, with seems to be=
 already accepted for merging into v4l:
>
> http://osdir.com/ml/linux-media/2009-02/msg00593.html
>
> Anyways, thanks for your intended help on this. Expect new patches ve=
ry soon.
>>
>> Cheers,
>>
>> Nate
>>
>> --
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> DongSoo(Nathaniel), Kim
>> Engineer
>> Mobile S/W Platform Lab.
>> Telecommunication R&D Centre
>> Samsung Electronics CO., LTD.
>> e-mail : dongsoo.kim@gmail.com
>> =A0 =A0 =A0 =A0 =A0 dongsoo45.kim@samsung.com
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
DongSoo(Nathaniel), Kim
Engineer
Mobile S/W Platform Lab. S/W centre
Telecommunication R&D Centre
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim@gmail.com
          dongsoo45.kim@samsung.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
