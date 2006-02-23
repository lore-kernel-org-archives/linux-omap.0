From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: NFS Mount a folder of host on OSK
Date: Thu, 23 Feb 2006 21:46:10 +0530
Message-ID: <26d3a31c0602230816t46c8880dnb5466b7919babae3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

I am using OMAP 5912 with the Linux kernel 2.4 that is supplied by the
vendor himself.
I have connected it to a Linux 9 Host PC via a serial and ethernet cable.
I am trying to mount a folder of the host PC on to the hardware.
I am using minicom on the Linux Host PC to talk to my hardware. I have not
installed my preview kit on the Linux host PC.
I have not changed any boot args of the hardware(OSK).

My /etc/exports file on the linux host is updated for the folder to be nfs
mounted. I have also executed the steps like
exportfs -a
portmap
nfsd

When i do a mount on the hardware (mount -t nfs <ip>:/osk /mnt) it fails
But i am able to ping my hardware ip from the linux host and also vice
versa.

Am i missing any step?
Advice me....

-vp
