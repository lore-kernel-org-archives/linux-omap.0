From: <Toshihiro.Kobayashi@nokia.com>
Subject: RE: [PATCH 5/5] dsp_core.c: Use struct platform_driver
Date: Tue, 29 Nov 2005 12:28:00 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F55017D385D@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: komal_shah802003@yahoo.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Basically it looks OK but the following change is not neccesary.
I think fields in a global structure are initialized with 0 if not
specified.

+#else
+#define dsp_drv_suspend		NULL
+#define dsp_drv_resume		NULL
 #endif /* CONFIG_PM */
=20
-#ifdef CONFIG_PM
 	.suspend	=3D dsp_drv_suspend,
 	.resume		=3D dsp_drv_resume,
-#endif

BR,
Toshihiro Kobayashi

>-----Original Message-----
>From: ext Komal Shah [mailto:komal_shah802003@yahoo.com]=20
>Sent: Tuesday, November 29, 2005 1:56 AM
>To: linux-omap-open-source@linux.omap.com
>Cc: Kobayashi Toshihiro (Nokia-NRC/Tokyo)
>Subject: [PATCH 5/5] dsp_core.c: Use struct platform_driver
>
>Tony/Toshihiro-san,
>
>Attached patch updates driver model and adjustment of #ifdef CONFIG_PM.
>
>---Komal Shah
>http://komalshah.blogspot.com/
>
