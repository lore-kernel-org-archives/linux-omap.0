From: "James Selvam" <james.iisc@gmail.com>
Subject: OPIE on Innovator 1510
Date: Wed, 24 May 2006 16:49:31 +0530
Message-ID: <fd1e34b0605240419k2a874d47w97d4a908d3e0e9b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Hi All,

Im trying to use OPIE on my OMAP 1510 Innovator board. I have used the root
file system image available at familiar.handhelds.org (
opie-image-v0.8.4-rc1-h6300.rootfs.tar.bz2).

I have enabled the Touchscreen as an input device and configured the OMAP
Innovator touchscreen. This has indeed been enabled as seen from the
following messages at bootup:

ts: Compaq touchscreen protocol output
input: omap_ts as /class/input/input0
OMAP touchscreen driver initialized

The innovator, however, comes to the startup screen and stops there waiting
to be tapped. It does not take the tapping.

The debug console shows that the udev is unable to create the
/dev/input/input0/event0 device.

There seems to be a missing link between the drivers and the application. I=
f
anybody has faced similar issues plz let me know.

Thanx,
James.
