From: kabbin <kabbin26@yahoo.com.tw>
Subject: Re: IP-Config: Failed to open eth0
Date: Thu, 31 Aug 2006 17:06:34 +0800 (CST)
Message-ID: <20060831090634.93519.qmail@web17805.mail.tpe.yahoo.com>
References: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
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

Dear all:=20
  I cannot boot from NFS. Could anyone help me please?  My board is omap2=
420h4,  kernel 2.6.10 =20


Does following means that the network driver configuration is wrong?
Why Invalid ethernet MAC address ?  I have setenv ethaddr already.

I got :

Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at 0xc4858300 IRQ 188 [nowait]
eth0: Invalid ethernet MAC address.  Please set using ifconfig
=2E
=2E
=2E
=2E
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
IP-Config: Failed to open eth0
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
      device=3Dbond0, addr=3D140.92.60.146, mask=3D255.255.0.0, gw=3D255.=
255.255.255,
     host=3D140.92.60.146, domain=3D, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D140.92.60.138, rootpath=3D
Looking up port of RPC 100003/2 on 140.92.60.138
portmap: server 140.92.60.138 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 140.92.60.138
portmap: server 140.92.60.138 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 140.92.60.138 not responding, timed out
Root-NFS: Server returned error -5 while mounting data/fs-mp3/
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block=
(2,0)


___________________________________________________=20
 =B1z=AA=BA=A5=CD=AC=A1=A7Y=AE=C9=B3q =A1=D0 =B7=BE=B3q=A1B=AET=BC=D6=A1B=
=A5=CD=AC=A1=A1B=A4u=A7@=A4@=A6=B8=B7d=A9w=A1I=20
 http://messenger.yahoo.com.tw/
