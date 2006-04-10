From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Is it possible to use NFS with built-in kernel on 5912 OSK?
Date: Mon, 10 Apr 2006 17:43:05 +0400
Message-ID: <9713be7f0604100643r394b2c5ct80caabf27c2225eb@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello, everybody!

I try to mount folder of host PC via NFS. From other PC it works
perfect. But from OMAP5912 OSK I have the following situation:

# insmod /lib/modules/2.4.20_mvl31-omap5912_osk/kernel/fs/nfsd/nfsd.o
# mkdir /tmp/nfs
# mount 192.168.0.16:/nfs /tmp/nfs
mount: 192.168.0.16:/nfs failed, reason given by server: Permission denied
mount: nfsmount failed: Bad file descriptor
NFS: mount program didn't pass remote address!
mount: Mounting 192.168.0.16:/nfs on /tmp/nfs failed: Invalid argument

What's wrong? I use standard kernel and rootfs shipped with the board.
By the way, why OMAP5912 OSK has 32M of flash onboard, but the size of
default rootfs is only 16M?

Thanks. Sergey.
