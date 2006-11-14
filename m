From: "Katorgi, Maher" <mkatorgi@ti.com>
Subject: Configuring UDEV rules for MMC/SD hot-plugging
Date: Mon, 13 Nov 2006 19:19:43 -0600
Message-ID: <093F85CB9FC9B6438B4D52D70E499AB90625D6E8@dlee06.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I am running 2.6.10 on OMAP2430.  When I plug SD card I get the
following at the Linux prompt, however the card does not automount.  I
do have The MMC hot plug scripts /etc/hotplug/mmc.agent and the system
hot plug script /sbin/hotplug present in the file system but they do not
get called.

# mmc0: host does not support reading read-only switch. assuming
write-enable.
mmcblk0: mmc0:a95c SD01G 992000KiB
 mmcblk0: p1

I can mount manually with no problem. =20

# ls mmc*
mmcblk0    mmcblk0p1
# mount /dev/mmcblk0p1 /mnt/mmc
# ls /mnt/mmc/
audio  dcim   palm

I need help configuring udev rules for hot plugging the SD card and
automatically running /sbin/hotplug script.  Any insight into how to do
that is appreciated. =20


Regards,
Maher Katorgi
Texas Instruments, Inc.
