From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Linux audio driver OMAP5912
Date: Wed, 26 Apr 2006 09:38:28 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638033F0DD1@dlee03.ent.ti.com>
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
To: ruchir.gulati@tcs.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Ruchir,

> Sometimes it gives the error message like Omap_audio: DMA IRQ received
for non-existing buffer. Ultimately the board hangs and a reboot needs
to be done.=20
This points at some sort of buffer handling issues on the audio layer.
The OSS driver is kind of deprecated now-a-days. Have you tried alsa
driver yet? This should be present in the latest omap-linux git tree.

=20

> Can someone please tell me where the problem is? If the problem is
with device fragment size, then what is the correct procedure for
setting the same, and to what value should it be set? If somone working
on the OMAP 5912 has come across similar problems, and fixed them, then
please throw some light on the solution for me also!=20
Check out oss.pdf again for DSP_SETFRAGMENTS ioctl for adjusting the
kernel buffer parameters.

=20

Regards,

Nishanth Menon
