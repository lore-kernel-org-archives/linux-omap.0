From: ruchir.gulati@tcs.com
Subject: RE: Linux audio driver OMAP5912
Date: Wed, 26 Apr 2006 14:57:36 +0530
Message-ID: <OFE9C9DD1B.F16D3727-ON6525715C.00332E5F-6525715C.0033E7F9@tcs.com>
References: <520AB2AD990DC04082102F77CA17263803127532@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA17263803127532@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, "Menon, Nishanth" <x0nishan@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks for all the advise. Now I am able to play and record correctly=20
using Linux (OSS driver) on the OMAP 5912 board.
However as I am trying to make a complete application, I am facing some=20
more problems.

I am not able to record and play simultaneouly using the OSS driver.=20
Though I have opened the device in the "O_RDWR" mode, I am able to record=20
properly but not play. In fact whenever I try to play, if the device was=20
opened in the "O_RDWR" mode, playback does not happen correctly. Sometimes=20
it gives the error message like Omap_audio: DMA IRQ received for=20
non-existing buffer. Ultimately the board hangs and a reboot needs to be=20
done.
I have configured the device in the Full-Duplex mode and also also checked=20
whether it has the full-duplex capability, which it seems to have. Yet I=20
am not able to fix this problem.

Can someone please tell me where the problem is? If the problem is with=20
device fragment size, then what is the correct procedure for setting the=20
same, and to what value should it be set? If somone working on the OMAP=20
5912 has come across similar problems, and fixed them, then please throw=20
some light on the solution for me also!

Thanks & Regards,
Ruchir Gulati
Tata Consultancy Services Limited
M2 & N2, Sector V, Block GP,
Salt Lake Electronics Complex
Kolkata - 700091,West Bengal
India
Mailto: ruchir.gulati@tcs.com
Website: http://www.tcs.com



"Menon, Nishanth" <x0nishan@ti.com>=20
04/10/2006 08:05 PM

To
<ruchir.gulati@tcs.com>, <linux-omap-open-source@linux.omap.com>
cc

Subject
RE: Linux audio driver OMAP5912






>Also the MIC volume is coming as 27500, where as I guess the allowd=20
values are between 0 and 100. Can anybody please tell me what the possible=20
problem might be??
Oss.pdf again. Left channel 8 bits and right channel 8 bits are depicted=20
as as RRLL for the 16 bits to the volume ioctl. You can have 0 to 100 for=20
either RR or LL. 27500 =3D 0x6B6C =E8 Left =3D 0x6C and right =3D 0x6B=20
Regards,
Nishanth Menon
=20
=20
ForwardSourceID:NT000042F2=20
=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D
Notice: The information contained in this e-mail
message and/or attachments to it may contain=20
confidential or privileged information. If you are=20
not the intended recipient, any dissemination, use,=20
review, distribution, printing or copying of the=20
information contained in this e-mail message=20
and/or attachments to it are strictly prohibited. If=20
you have received this communication in error,=20
please notify us by reply e-mail or telephone and=20
immediately and permanently delete the message=20
and any attachments. Thank you
