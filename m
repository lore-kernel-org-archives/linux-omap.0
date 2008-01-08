From: "Phanee Sistla" <phaneesistla@gmail.com>
Subject: Copying executables into H2 board
Date: Tue, 8 Jan 2008 13:20:04 -0600
Message-ID: <99165b620801081120j2e1b70e0xe12e2fb4f5b528dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

I have the linux 2.6.9 kernel up and running on the OMAP1610 H2 board.
Booting the kernel from H2 board generates the follwoing o/p on the minicom
terminal:


MUX: Setting register MMC_DAT0
      FUNC_MUX_CTRL_B (0xfffe1030) = 0x00000000 -> 0x00000000
      PU_PD_SEL_2 (0xfffe10bc) = 0x0041f000 -> 0x0041f000
      PULL_DWN_CTRL_2 (0xfffe1048) = 0x00000410 -> 0x00000410

 MMC card not present
MMC1: Unable to get IRQ for MMC cover switch
OMAP16XX TSC2101 Audio support initialized
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 129.119.113.107, my address is
129.119.126.126
IP-Config: Complete:
      device=eth0, addr=129.119.126.126, mask=255.255.255.0, gw=
129.119.126.1,
     host= 129.119.126.126, domain=seas.smu.edu, nis-domain=(none),
     bootserver=129.119.113.107, rootserver=129.119.124.64 , rootpath=<7>
evbug.c: Event. Dev: <NULL>, Type: 1, Code: 184, Value: 2
Looking up port of RPC 100003/2 on 129.119.124.64
Looking up port of RPC 100005/1 on 129.119.124.64
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing init memory: 104K
init started:  BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call binary

******************************************
Starting System Init for innovator
******************************************

Please press Enter to activate this console.


The target board has a root file system that is NFS mounted from the host
pc. I tried to run a simple c program " Helloworld.c" from the H2 board. For
this I cross compiled the source code using snapgear toolchain. This
generated an executable "Helloworld". I dont know how to load this
executable into the H2 board. Kindly help me in this regard.

Thanking you in advance,
Phanee
