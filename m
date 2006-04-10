From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Linux audio driver OMAP5912
Date: Mon, 10 Apr 2006 09:35:32 -0500
Message-ID: <520AB2AD990DC04082102F77CA17263803127532@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ruchir.gulati@tcs.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>Also the MIC volume is coming as 27500, where as I guess the allowd
values are between 0 and 100. Can anybody please tell me what the
possible problem might be??

Oss.pdf again. Left channel 8 bits and right channel 8 bits are depicted
as as RRLL for the 16 bits to the volume ioctl. You can have 0 to 100
for either RR or LL. 27500 =3D 0x6B6C =3D=3D> Left =3D 0x6C and right =
=3D 0x6B=20

Regards,

Nishanth Menon

=20

=20
