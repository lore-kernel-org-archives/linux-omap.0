From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Fri, 2 Mar 2007 13:12:27 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47622A6D@dlee13.ent.ti.com>
References: <11726783562347-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <11726783562347-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

My comments below, looks like most of the code from Trilok's and your
patch is same, but you have spit the functionality in many files, which
doesn't add any features or advantages to the actual camera driver
architecture as such.

1. Why do we need a separate omap24xxcam-core.c? I don't see any added
advantage from this split. Can you please briefly explain your thoughts?


2. Headers in every file is different from the file name. Its bit
difficult to get the intent of code :). I agree this is an evolving
code, you can reject this comment.

3. Lot of code is already available and well organized in David's and
Trilok's patch like for example: omap24xxcam_core_enable is same as
omap24xxcam_cc_enable, the functionality in omap24xxcam-dmahw.c
omap24xx-vbq.c is same as code in their patches. I felt like this
functionality is better achieved with previous patches, is this split
really required?

4. I see few comments are same as in David's code but functionality or
code is different example:

+/* Program the camera interface xclk for the frequency cam->img.xclk
based on=20
+ * the functional clock frequency cam->img.mclk.  If the specifed
cam->img.xclk=20
+ * frequency is not possible based on the value of cam->img.mclk, then
the=20
+ * closest xclk frequency lower than the specified xclk will be
selected. =20
+ * The actual xclk frequency is returned in cam->img.xclk.  If
cam->img.xclk is zero,=20
+ * then xclk is turned off (stable low value).
+ */
+
+void omap24xxcam_core_init(struct omap24xxcam_core *core,
+			   unsigned long base)
+{
+	DBG;
+
+	core->base =3D base;
+=09
+	/* Setting the camera core AUTOIDLE bit causes problems with
frame=20
+	 * synchronization, so we will clear the AUTOIDLE bit instead.
+	 */
+	//omap24xxcam_reg_out(cam, CC_SYSCONFIG, 0);
+	omap24xxcam_reg_out(core->base, CC_SYSCONFIG,
CC_SYSCONFIG_AUTOIDLE);
+
+	core->xclk_enabled =3D 0;
+}
+
+void omap24xxcam_core_exit(const struct omap24xxcam_core *core)
+{
+}
+

5. Your drivers/media/video/omap/omap24xxcam-sgdma.c is same as what is
available in drivers/media/video/omap/omap24xxcam-dma.c (from David).=20

6. Same with vbq.c.

7. Ioctl mapping is ok, but it might be an issue if were to add a
special case that is not part of V4L2 for now (atleast for testing
sake).



=20
