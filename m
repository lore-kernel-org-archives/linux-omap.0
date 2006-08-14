From: "Zhang, Jian" <jzhang@ti.com>
Subject: quick test OMAP ALSA driver on H2
Date: Mon, 14 Aug 2006 15:45:28 -0500
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA604151E79@dlee05.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi everyone,

=20

I managed to get a H2 board and booted an ALSA enabled kernel on it. The
kernel boot log shows "H2 TSC2101" as the #0 ALSA device. To do a quick
test, I have manually created a pcm device node:

=20

/dev/snd/pcmC0D0 116, 16, c

=20

Then I cat a random file to this device node. I got "write error: File
descriptor in bad state" . It looks like I missed some necessary
configuration prior to using cat command. The kernel also has OSS
emulation, cat the same file to /dev/sound/dsp has generated the
expected noise which tells me the driver is basically working.  Can
someone (Mika, Daniel, David, Komal?) tell me what is required? A short
shell command sequence that makes noise via ALSA API would be very
useful and is greatly appreciated. =20

=20

Regards,

Jian

=20
