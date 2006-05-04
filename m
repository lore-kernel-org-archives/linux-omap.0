From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Linux audio driver OMAP5912
Date: Thu, 4 May 2006 08:41:10 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638034F7D9A@dlee03.ent.ti.com>
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

Usually, I don't face buffer underflow/overrun unless I have a data rate
difference. E.g. I configure the hardware to 48K sampling rate, but the
file operations rate is 1k. The kernel's intermediate buffers can handle
the rate difference to a limit for some time at least, however, if the
data rate difference is too much over the head, then you'd end up where
the fileops take too much time compared to the read and the kernel's
audio buffer overflows/underflows. There are various means to handle
this. My favorite suggestion is to use dedicated threads to pull
data/throw data in, while another thread does fileops. This forces the
application to do buffering on its own (in addition to kernel's
buffering mechanism).  FileIO overheads are upto the apps to handle, the
kernel buffers are basically targeted at OS being not consistent is
scheduling the read/write thread (vanilla linux being not 100% real
time)- this can handle scenarios on an overloaded system where the
kernel schedules the audio app in varying durations. My second favourite
suggestion would be to use a faster fileio filesystem (such as flash on
jffs2 rather than NFS over a heavily loaded network).

=20

I suggest ALSA over OSS as the buffering logic used there is common for
all platforms - which implies, the problems that you might be seeing on
OSS (which has omap specific buffering logic), would have already been
solved. But then, if you so prefer, you can isolate the fileio overheads
before giving up on OSS (write and read to intermediate buffers,
complete ops, and then do fileio).

=20

Regards,

Nishanth Menon

=20

________________________________

From: ruchir.gulati@tcs.com [mailto:ruchir.gulati@tcs.com]=20
Sent: Thursday, May 04, 2006 7:29 AM
To: Menon, Nishanth; linux-omap-open-source@linux.omap.com
Subject: RE: Linux audio driver OMAP5912

=20


Hi,=20

Is it so that the OSS driver on the OMAP5912will not work in the
full-dulpex mode at all? I think the problem I am facing presently is of
buffer underrun while audio playback, and hope to resolve it by trying
different fragment sizes. I really hope this works! Any more help/tips
on this topic??=20
Please let me know if switching to ALSA would be absolutely necessary
for supporting full-duplex sort of functioning on the OMAP5912=20

Thanks & Regards,
Ruchir Gulati




"Menon, Nishanth" <x0nishan@ti.com>=20

04/26/2006 08:08 PM=20

To

<ruchir.gulati@tcs.com>, <linux-omap-open-source@linux.omap.com>=20

cc

=20

Subject

RE: Linux audio driver OMAP5912

=20

=20

=20




Hi Ruchir,=20
> Sometimes it gives the error message like Omap_audio: DMA IRQ received
for non-existing buffer. Ultimately the board hangs and a reboot needs
to be done.=20
This points at some sort of buffer handling issues on the audio layer.
The OSS driver is kind of deprecated now-a-days. Have you tried alsa
driver yet? This should be present in the latest omap-linux git tree.=20
 =20
> Can someone please tell me where the problem is? If the problem is
with device fragment size, then what is the correct procedure for
setting the same, and to what value should it be set? If somone working
on the OMAP 5912 has come across similar problems, and fixed them, then
please throw some light on the solution for me also!=20
Check out oss.pdf again for DSP_SETFRAGMENTS ioctl for adjusting the
kernel buffer parameters.=20
 =20
Regards,=20
Nishanth Menon=20
ForwardSourceID:NT0000473A    =20

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
=20
=20
