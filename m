From: k c <omap_mails@hotmail.com>
Subject: 2420 linux + VIDIOC_S_FBUF
Date: Tue, 8 Jan 2008 13:14:50 +0000
Message-ID: <BAY119-W39F1E93BE2E2252B0EC4F9F9480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi All,

    I have noticed that the 2420 linux driver has the IOCTL's VIDIOC_S_FBUF=
 and VIDIOC_G_FBUF implemented in OMAP24xxcam.c. But I noticed that user is=
 not allowed to change the pixelformat by using the IOCTL (One can only cha=
nge the flags). The display controller supports YUYV ,UYVY right ? any spec=
ific reason why the IOCTL's to change the pixel format are not  implemented=
.

Thanks
kc
_________________________________________________________________
Post free property ads on Yello Classifieds now! www.yello.in
http://ss1.richmedia.in/recurl.asp?pid=3D219=
