From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling Mistral touch screen driver
Date: Sat, 27 May 2006 08:57:32 -0700
Message-ID: <200605270857.32320.david-b@pacbell.net>
References: <4465A8C0.4020100@nextbitcpu.com>
	<200605140955.53619.david-b@pacbell.net>
	<4477F290.2090402@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sbHeEmrBRn/w8FP"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4477F290.2090402@gmail.com>
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

--Boundary-00=_sbHeEmrBRn/w8FP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 May 2006 11:32 pm, Dirk Behme wrote:

> don't forget to add 'modprobe omap_uwire' to your 
> configuration.

Hmm, I forgot about that stuff.  I've been having coldplug load
all the relevant platform drivers for me ... see the attached
script.  Sometime in 2.6.18 the special-casing for platform
devices can disappear, they'll support modalias correctly.

- Dave
 

--Boundary-00=_sbHeEmrBRn/w8FP
Content-Type: text/plain;
  charset="us-ascii";
  name="S00coldplug"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="S00coldplug"

#!/bin/ash
#
# "coldplug" ensures every hardware device present has its driver loaded,
# even if its hotplug event was ignored since it was too early in system
# startup for hotplug processing to work.
#
# Those drivers will create /sys/class or /sys/block nodes that receive
# normal udev processing through hotplug, leading to /dev node creation.
#
# Run this during system startup shortly after /dev has been initialized
# using udevstart.

if [ ! -d /sys/devices ]
then
	exit 1
fi

# "new style" kernel hotplug has module-init-tools do the thinking
cd /sys/devices
for DIR in $(find . -type d)
do
	if [ -f $DIR/modalias -a ! -L $DIR/driver ]
	then
		modprobe -q $(cat $DIR/modalias)
	fi
done

# REVISIT this part goes away sometime in 2.6.18 when platform_device
# gets full hotplug/modalias support
cd /sys/devices/platform
for DEV in *
do
	if [ "$DEV" != "power" -a ! -L $DEV/driver ]
	then
		# some platform drivers will need a MODULE_ALIAS()
		modprobe -q $DEV
	fi
done

--Boundary-00=_sbHeEmrBRn/w8FP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_sbHeEmrBRn/w8FP--
