From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: Fwd: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Wed, 14 Mar 2007 11:29:38 +0200
Message-ID: <45F7C082.3070807@nokia.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
	<b8bf37780702280821wb17104chf75b973b420895ef@mail.gmail.com>
	<200703010848.32757.andre.rosa@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200703010848.32757.andre.rosa@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.rosa@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Andr=E9 Goddard Rosa wrote:
> Hi, Sakari!

Hello,

And thanks for the comments!

...
>> +static int
>> +omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +       struct omap24xxcam_fh *fh =3D file->private_data;
>> +       int err;
>> +
>> +       /* let the video-buf mapper check arguments and set-up structu=
res */
>> +       err =3D videobuf_mmap_mapper(&fh->vbq, vma);
>> +       if (err)
>> +               goto err1;
>> +
>> +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
>> +
>> +       /* do mapping to our allocated buffers */
>> +       err =3D omap24xxcam_mmap_buffers(file, vma);
>> +       if (err)
>> +               goto err2;
>=20
> Same comments of Trilok here, but also please find that
> videobuf_mmap_mapper() allocates memory. Where is it
> being released in this case?
>=20
> Should we call videobuf_mmap_free() in this error case?

It's that kfree. If you look at the other drivers, no special attention=20
is paid on this one. It's because the vidobuf_mmap_mapper is the last=20
function called, i.e. there is no case where videobuf_mmap_mapper would=20
succeed but the driver's mmap call would fail.

...
>> +       omap24xxcam_sensor_exit(cam);
>> +
>> +       if (cam->vfd) {
>> +               if (cam->vfd->minor =3D=3D -1) {
>> +                       /* The device was never registered, so release=
 the
>> +                        * video_device struct directly.
>> +                        */
>> +                       video_device_release(cam->vfd);
>> +               } else {
>> +                       /* The unregister function will release the
>> video_device
>> +                        * struct as well as unregistering it.
>> +                        */
>> +                       video_unregister_device(cam->vfd);
>=20
> Are you sure that video_unregister_device() calls  video_device_release=
(cam->vfd)
> or does kfree(cam->vfd) in its regular path?

video_unregister_device doesn't do that directly. I have to check=20
further what's happening here.

It indeed looks like a potential memory leak.

Regards,

--=20
Sakari Ailus
sakari.ailus@nokia.com
