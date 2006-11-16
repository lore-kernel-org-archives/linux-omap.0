From: David Brownell <david-b@pacbell.net>
Subject: Re: Configuring UDEV rules for MMC/SD hot-plugging
Date: Wed, 15 Nov 2006 20:15:37 -0800
Message-ID: <200611152015.37738.david-b@pacbell.net>
References: <093F85CB9FC9B6438B4D52D70E499AB90625D6E8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <093F85CB9FC9B6438B4D52D70E499AB90625D6E8@dlee06.ent.ti.com>
Content-Disposition: inline
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

On Monday 13 November 2006 5:19 pm, Katorgi, Maher wrote:
> Hi,
> 
> I am running 2.6.10 on OMAP2430.  When I plug SD card I get the
> following at the Linux prompt, however the card does not automount.  I
> do have The MMC hot plug scripts /etc/hotplug/mmc.agent and the system
> hot plug script /sbin/hotplug present in the file system but they do not
> get called.
> 
> # mmc0: host does not support reading read-only switch. assuming
> write-enable.
> mmcblk0: mmc0:a95c SD01G 992000KiB
>  mmcblk0: p1

That suggests that the hotplug scripts ARE getting called ... all they
do is ensure that the right drivers are loaded.  FWIW on current systems
you can probably use the appended script instead of /sbin/hotplug, and
get better results.


> I can mount manually with no problem.  

I don't think "hotplug" issues "mount" commands.  But I'm fairly sure
that some folk have "udev" riles that do that; check your current PC
distros to see what they do with block devices.

- Dave



#!/bin/ash
#
# "hotplug" initializes devices ... hardware drivers get modprobed and
# create class devices.  then later udev handles /dev node creation and
# invokes programs that make userspace aware of the new device node.
#
# install as /sbin/hotplug

if [ ! -d /sys ]
then
	exit 1
fi
cd /sys

if [ "$ACTION" = "add" -a "$SUBSYSTEM" = "mmc" ]
then
	# MMC doesn't support modalias yet, but this is
	# the only choice until we have SDIO support.
	MODALIAS=mmc_block
fi

if [ "$ACTION" = "add" -a -n "$MODALIAS" -a ! -L $DEVPATH/driver ]
then
	# most important subsystems now have $MODALIAS support:
	modprobe -q $MODALIAS
fi

if [ -n "$DEVPATH" ]
then
	/sbin/udevsend $1
fi
