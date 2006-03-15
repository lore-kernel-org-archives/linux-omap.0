From: Matthew Percival <matthew@capgo.com>
Subject: Re: problem with root filesystem
Date: Thu, 16 Mar 2006 09:13:16 +1100
Message-ID: <1142460796.9059.11.camel@localhost.localdomain>
References: <26d3a31c0603150617g22cac272g990d8313c3b4ae99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <26d3a31c0603150617g22cac272g990d8313c3b4ae99@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> i followed newbie guide and i mounted the root filesystem using the NFS. i
> have given read/write access to that folder to all in the exports file .but
> i am unable to create single directory in the target .why is it so ?? how to
> overcome this problem . i have down loaded the root filesystem from the
> following website  http://linux.omap.com/pub/filesystem/rootfsosk.tar.bz2

	There are a few possible causes of this, but the most likely is that
you are mounting the filesystem as read-only; make sure you have `rw' in
the `bootargs' environmental variable in u-boot.  Here is what I set
them to when using NFS:

setenv bootargs console=ttyS0,115200n8 noinitrd ip=on root=/dev/nfs rw
nfsroot=${MY_IP}:${PATH_TO_ROOTFS},nolock
saveenv

	If that is not the problem, check the permissions as they are set on
the host system: it is possible, however unlikely, that you have them
set up in some strange way (eg -r-xr-xr-x).

	-- Matthew
