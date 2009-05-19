From: "Dongsoo, Nathaniel Kim" <dongsoo.kim@gmail.com>
Subject: Re: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
Date: Tue, 19 May 2009 14:40:55 +0900
Message-ID: <5e9665e10905182240u38f5759bo405bde86ff59499b@mail.gmail.com>
References: <A24693684029E5489D1D202277BE89443E17ECF5@dlee02.ent.ti.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB03056A15B4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A15B4@dbde02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Shah, Hardik" <hardik.shah@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Hardik,

According to earlier mail from Sergio, I could be noticed that it is
totally ok to restrict number of buffers by driver. As matter of fact,
I was always considering about the H/W restriction and could find the
answer from his mail.
By the way, thank you for your answer.
Cheers,

Nate


On Tue, May 19, 2009 at 2:28 PM, Shah, Hardik <hardik.shah@ti.com> wrot=
e:
> Hi Nate,
>
>
>> -----Original Message-----
>> From: Aguirre Rodriguez, Sergio Alberto
>> Sent: Tuesday, May 19, 2009 10:52 AM
>> To: Dongsoo, Nathaniel Kim; Shah, Hardik
>> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Jadav, =
Brijesh R;
>> Hiremath, Vaibhav
>> Subject: RE: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
>>
>> Hi Nate,
>>
>> I have 1 input regarding your question:
>>
>> >From: linux-media-owner@vger.kernel.org [linux-media-owner@vger.ker=
nel.org]
>> On Behalf Of Dongsoo, Nathaniel Kim [dongsoo.kim@gmail.com]
>> >Sent: Tuesday, May 19, 2009 7:53 AM
>> >To: Shah, Hardik
>> >Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Jadav,=
 Brijesh
>> R; Hiremath, Vaibhav
>> >Subject: Re: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
>> >
>> >Hello Hardik,
>> >
>> >Reviewing your driver, I found something made me curious.
>> >
>> >
>> >On Wed, Apr 22, 2009 at 3:25 PM, Hardik Shah <hardik.shah@ti.com> w=
rote:
>>
>> <snip>
>>
>> >> +/* Buffer setup function is called by videobuf layer when REQBUF=
 ioctl is
>> >> + * called. This is used to setup buffers and return size and cou=
nt of
>> >> + * buffers allocated. After the call to this buffer, videobuf la=
yer will
>> >> + * setup buffer queue depending on the size and count of buffers
>> >> + */
>> >> +static int omap_vout_buffer_setup(struct videobuf_queue *q, unsi=
gned int
>> *count,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *s=
ize)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_vout_device *vout =3D q->priv_data;
>> >> + =A0 =A0 =A0 int startindex =3D 0, i, j;
>> >> + =A0 =A0 =A0 u32 phy_addr =3D 0, virt_addr =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 if (!vout)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> +
>> >> + =A0 =A0 =A0 if (V4L2_BUF_TYPE_VIDEO_OUTPUT !=3D q->type)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> +
>> >> + =A0 =A0 =A0 startindex =3D (vout->vid =3D=3D OMAP_VIDEO1) ?
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video1_numbuffers : video2_numbuffe=
rs;
>> >> + =A0 =A0 =A0 if (V4L2_MEMORY_MMAP =3D=3D vout->memory && *count =
< startindex)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *count =3D startindex;
>> >> +
>> >> + =A0 =A0 =A0 if ((rotation_enabled(vout->rotation)) && *count > =
4)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *count =3D 4;
>> >> +
>> >
>> >
>> >
>> >This seems to be weird to me. If user requests multiple buffers mor=
e
>> >than 4, user cannot recognize that the number of buffers requested =
is
>> >forced to change into 4. I'm not sure whether this could be serious=
 or
>> >not, but it is obvious that user can have doubt about why if user h=
ave
>> >no information about the OMAP H/W.
>> >Is it really necessary to be configured to 4?
> [Shah, Hardik] Rotation requires the VRFB contexts and limited number=
 of contexts are available. So maximum number of buffers is fixed to 4 =
when rotation is enabled.
>
> Thanks,
> Hardik
>> >
>> >
>> >Cheers,
>> >
>> >Nate
>> >
>>
>> We did a very similar thing on omap3 camera driver, not exactly by t=
he number
>> of buffers requested, but more about checking if the bytesize of the=
 total
>> requested buffers was superior to the MMU fixed sized page table siz=
e
>> capabilities to map that size, then we were limiting the number of b=
uffers
>> accordingly (for keeping the page table size fixed).
>>
>> According to the v4l2 spec, changing the count value should be valid=
, and it
>> is the userspace app responsability to check the value again, to con=
firm how
>> many of the requested buffers are actually available.
>>
>> Regards,
>> Sergio
>



--=20
=3D
DongSoo, Nathaniel Kim
Engineer
Mobile S/W Platform Lab.
Digital Media & Communications R&D Centre
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim@gmail.com
          dongsoo45.kim@samsung.com
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
