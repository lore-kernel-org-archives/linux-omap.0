From: k c <omap_mails@hotmail.com>
Subject: 2420 2.6 open source kernel + color space coversion
Date: Tue, 11 Dec 2007 16:12:54 +0000
Message-ID: <BAY119-W828D01D8E6A90E786AAD7F9640@phx.gbl>
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

Hi,
=20
  In the 2.6.9 open source kernel for OMAP2420 there is no support to set t=
he display controller color conversion on the video pipeline. There are not=
 IOCTL's implemented for this. The 2430 open source kernel has an IOCTL VID=
IOC_S_OMAP2_COLORCONV implemented in ./drivers/media/video/omap/omap24xxvou=
t.c.
=20
Can anyone let me know if I can find that support for OMAP2420 or do I have=
 to implement that myself.
=20
Thanks,
K C
_________________________________________________________________
Post free property ads on Yello Classifieds now! www.yello.in
http://ss1.richmedia.in/recurl.asp?pid=3D220=
