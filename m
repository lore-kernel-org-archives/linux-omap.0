From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Tue, 6 Dec 2011 23:45:27 +0800
Message-ID: <CACVXFVOoQRZKDEWUtuq3hE3H25b7UUWWAJbsTGgVHJcUbnihig@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
	<201112061255.56136.arnd@arndb.de>
	<CACVXFVPYUY-vpeoKJKX2XN7-0w+=seW0u3EaP=hD9m1Sy7nkTQ@mail.gmail.com>
	<201112061441.25822.arnd@arndb.de>
	<CACVXFVO8Uk808J9HgVv6ernd4x_QwN3YsAaERF=W8F=NQrLwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVO8Uk808J9HgVv6ernd4x_QwN3YsAaERF=W8F=NQrLwQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 6, 2011 at 10:52 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> On Tue, Dec 6, 2011 at 10:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> 3. extending video_usercopy in some way to make this work, preferabl=
y
>> =A0 in a generic way.
>
> Maybe this one is a good choice, and I think that it is worthy to
> support the below kind of array parameter:
>
> struct v4l2_fd_result {
> =A0 =A0 =A0 =A0__u32 =A0 buf_index;
> =A0 =A0 =A0 =A0__u32 =A0 face_cnt;
> =A0 =A0 =A0 =A0__u32 =A0 reserved[6];
> =A0 =A0 =A0 =A0struct v4l2_fd_detection fd[];
> };
>
> and it is not difficult to implement it in a generic way so that new
> array parameters can be supported as 64/32 compatible.

How about the blow patch to support 64/32 compatible array parameter?

diff --git a/drivers/media/video/v4l2-ioctl.c b/drivers/media/video/v4l=
2-ioctl.c
index e1da8fc..72c81f7 100644
--- a/drivers/media/video/v4l2-ioctl.c
+++ b/drivers/media/video/v4l2-ioctl.c
@@ -2239,6 +2239,26 @@ static int check_array_args(unsigned int cmd,
void *parg, size_t *array_size,
 	return ret;
 }

+static int is_64_32_array_args(unsigned int cmd, void *parg, int *extr=
a_len)
+{
+	int ret =3D 0;
+
+	switch (cmd) {
+	case VIDIOC_G_FD_RESULT: {
+		struct v4l2_fd_result *fr =3D parg;
+
+		*extra_len =3D fr->faces_cnt *
+			sizeof(struct v4l2_fd_detection);
+		ret =3D 1;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 long
 video_usercopy(struct file *file, unsigned int cmd, unsigned long arg,
 	       v4l2_kioctl func)
@@ -2251,6 +2271,7 @@ video_usercopy(struct file *file, unsigned int
cmd, unsigned long arg,
 	size_t  array_size =3D 0;
 	void __user *user_ptr =3D NULL;
 	void	**kernel_ptr =3D NULL;
+	int	extra =3D 0;

 	/*  Copy arguments into temp kernel buffer  */
 	if (_IOC_DIR(cmd) !=3D _IOC_NONE) {
@@ -2280,9 +2301,29 @@ video_usercopy(struct file *file, unsigned int
cmd, unsigned long arg,
 		}
 	}

-	err =3D check_array_args(cmd, parg, &array_size, &user_ptr, &kernel_p=
tr);
+	if (is_64_32_array_args(cmd, parg, &extra)) {
+		int size;
+		void *old_mbuf;
+
+		err =3D 0;
+		if (!extra)
+			goto out_array_args;
+		old_mbuf =3D mbuf;
+		size =3D extra + _IOC_SIZE(cmd);
+		mbuf =3D kmalloc(size, GFP_KERNEL);
+		if (NULL =3D=3D mbuf)
+			return -ENOMEM;
+		memcpy(mbuf, parg, _IOC_SIZE(cmd));
+		parg =3D mbuf;
+		kfree(old_mbuf);
+	} else {
+		err =3D check_array_args(cmd, parg, &array_size,
+				&user_ptr, &kernel_ptr);
+	}
+
 	if (err < 0)
 		goto out;
+out_array_args:
 	has_array_args =3D err;

 	if (has_array_args) {
@@ -2321,7 +2362,7 @@ out_array_args:
 	switch (_IOC_DIR(cmd)) {
 	case _IOC_READ:
 	case (_IOC_WRITE | _IOC_READ):
-		if (copy_to_user((void __user *)arg, parg, _IOC_SIZE(cmd)))
+		if (copy_to_user((void __user *)arg, parg, _IOC_SIZE(cmd) + extra))
 			err =3D -EFAULT;
 		break;
 	}



thanks,
--
Ming Lei
