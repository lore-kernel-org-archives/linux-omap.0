From: kabbin <kabbin26@yahoo.com.tw>
Subject: IP-Config: Failed to open eth0
Date: Thu, 31 Aug 2006 11:37:46 +0800 (CST)
Message-ID: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hello
    I use arm-linux-gcc 3.4.1 to build kernel 2.6.10 for omap2420h4=20
but I cannot mount NFS

I got the following message:

/************************************************************************=
*******

NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2

IP-Config: Failed to open eth0
IP-Config: Complete:
      device=3Dbond0, addr=3D140.92.60.146, mask=3D255.255.255.0, gw=3D25=
5.255.255.255,
     host=3Dtqm, domain=3D, nis-domain=3D(none),
     bootserver=3D140.92.60.138, rootserver=3D140.92.60.138, rootpath=3D

Looking up port of RPC 100003/2 on 140.92.60.138
portmap: server 140.92.60.138 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 140.92.60.138
portmap: server 140.92.60.138 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 140.92.60.138 not responding, timed out
Root-NFS: Server returned error -5 while mounting /data/fs-mp3/
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))

/************************************************************************=
**********
Is there something wrong with my kernel configuration?
Could anybody help me, please? Thanks .


___________________________________________________=20
 =B1z=AA=BA=A5=CD=AC=A1=A7Y=AE=C9=B3q =A1=D0 =B7=BE=B3q=A1B=AET=BC=D6=A1B=
=A5=CD=AC=A1=A1B=A4u=A7@=A4@=A6=B8=B7d=A9w=A1I=20
 http://messenger.yahoo.com.tw/
