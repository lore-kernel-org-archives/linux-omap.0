From: =?big5?q?=AA=FC=B4=BC?= <aceraspire1200@yahoo.com.tw>
Subject: OMAP 5912 Webcam
Date: Mon, 13 Aug 2007 17:43:13 +0800 (CST)
Message-ID: <708337.38952.qm@web73512.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear all,
  I got some problems in OMAP5912. I use the webcam Orite SC-120 webcam w=
ith my OMAP5912. I use V4L library to write a program of capture(RGB Form=
at)to test the webcam ,but I got a low frame rate about 3 frame/s(352x288=
).
  I hope to achieve 15 (f/s) frame rate, so I set the webcam sequence wid=
th and height to 176 and 144. But I still got the same frame rate.
  I think some problem list ,but I don=A1=A6t know which one is correct. =
If anyone can teach me what problem I got.
  =20
  1.    The bandwidth of OMAP5912 usb is not enough.The webcam only can u=
se RGB format to capture.
  2.    I set the lower width and height to capture for faster frame rate=
. But I still got the same frame rate. whether the webcam capture the ful=
l image size(352x288) to OMAP, and downsample the image size(176x144) aft=
er that.
  3.    I got mistake in my program of capture.
    =20
  =20
  Webcam Feature
  =20
                  Senser  1/7"CMOS 120K Pixels    Video Format  24-Bit Tr=
ue Color    USB Inetr face  Compliant to USB 2.0 and 1.1    Image Resolut=
ion  640x480, 352x288, 320x240, 176x144, 160x120    Video Resolution  640=
x480, 352x288, 320x240, 176x144, 160x120    Frame rate  VGA 640x480 @ 30 =
frame rate per second    Adjustable Focus  3 CM to Infinity    Automatic =
White Balance  Yes    Automatic Exposure  Yes    Automatic Compensation  =
Yes    Store Digital Videos Formats  AVI / WMV    Store Digital Photo For=
mats  JPEG / BMP


       _________________________________________________
 =A6W=BC=D2=A4d=AA=F7=AFS=A7U=BD=D6=A4~=ACO=B4I=B0=D3=AFu=B7R=A1H=A4U=A8M=
=A9w=AE=B330=B8U=A1C
