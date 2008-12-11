From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [REVIEW PATCH 01/14] V4L: Int if: Dummy slave
Date: Thu, 11 Dec 2008 14:37:46 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E195@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla,
	Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

>From d6e52dcc4ec93dcca3218763ccf21fd1bea08d55 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Thu, 11 Dec 2008 13:35:52 -0600
Subject: [PATCH] V4L: Int if: Dummy slave

This patch implements a dummy slave that has no functionality. Helps
managing slaves in the OMAP 3 camera driver; no need to check for NULL
pointers.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/v4l2-int-device.c |   19 +++++++++++++++++++
 include/media/v4l2-int-device.h       |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/v4l2-int-device.c b/drivers/media/video/=
v4l2-int-device.c
index a935bae..cba1c9c 100644
--- a/drivers/media/video/v4l2-int-device.c
+++ b/drivers/media/video/v4l2-int-device.c
@@ -32,6 +32,25 @@
 static DEFINE_MUTEX(mutex);
 static LIST_HEAD(int_list);
=20
+static struct v4l2_int_slave dummy_slave =3D {
+	/* Dummy pointer to avoid underflow in find_ioctl. */
+	.ioctls =3D (void *)0x80000000,
+	.num_ioctls =3D 0,
+};
+
+static struct v4l2_int_device dummy =3D {
+	.type =3D v4l2_int_type_slave,
+	.u =3D {
+		.slave =3D &dummy_slave,
+	},
+};
+
+struct v4l2_int_device *v4l2_int_device_dummy()
+{
+	return &dummy;
+}
+EXPORT_SYMBOL_GPL(v4l2_int_device_dummy);
+
 void v4l2_int_device_try_attach_all(void)
 {
 	struct v4l2_int_device *m, *s;
diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-dev=
ice.h
index 9c2df41..85a1834 100644
--- a/include/media/v4l2-int-device.h
+++ b/include/media/v4l2-int-device.h
@@ -84,6 +84,8 @@ struct v4l2_int_device {
 	void *priv;
 };
=20
+struct v4l2_int_device *v4l2_int_device_dummy(void);
+
 void v4l2_int_device_try_attach_all(void);
=20
 int v4l2_int_device_register(struct v4l2_int_device *d);
--=20
1.5.6.5


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
