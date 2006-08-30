From: kabbin <kabbin26@yahoo.com.tw>
Subject: RE: Building kenel error (uImage)
Date: Wed, 30 Aug 2006 18:15:28 +0800 (CST)
Message-ID: <20060830101528.41242.qmail@web17801.mail.tpe.yahoo.com>
References: <20060829104307.77524.qmail@web17808.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060829104307.77524.qmail@web17808.mail.tpe.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear all
    I use arm-linux-gcc 3.4.1 to build kernel 2.6.10 for omap2420h4=20
  (http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap2=
430.tgz) =20
 # make clean
 # make omap_h4_2420_defconfig
 # make uImage

However,when I boot kernel through NFS, I got

//***********************************************************************=
*****
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2

IP-Config: Failed to open eth0                     <-----------
IP-Config: No network devices available.           <-----------

Looking up port of RPC 100003/2 on 140.92.60.138
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
//***********************************************************************=
*****

Maybe something wrong with the network driver?=20
I have tried to modified the kernel configure through menuconfig,
but it still worked fail.
Could anybody tell me how to use the correct configuration ? =20

Thanks , best regards.

___________________________________________________=20
 =B1z=AA=BA=A5=CD=AC=A1=A7Y=AE=C9=B3q =A1=D0 =B7=BE=B3q=A1B=AET=BC=D6=A1B=
=A5=CD=AC=A1=A1B=A4u=A7@=A4@=A6=B8=B7d=A9w=A1I=20
 http://messenger.yahoo.com.tw/
