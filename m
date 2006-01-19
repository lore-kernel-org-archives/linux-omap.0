From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Ethernet issue in most recent git?
Date: Thu, 19 Jan 2006 18:49:41 +0100
Message-ID: <43CFD135.4090604@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

has anybody else problems with ethernet with 2.6.16-rc1-omap1 on OSK?

# mount -t nfs -o nolock 192.0.0.1:/home/omap_linux/nfs /mnt/nfs
NETDEV WATCHDOG: eth0: transmit timed out
mount: RPC: Unable to receive; errno = No route to host
mount: nfsmount failed: Bad file descriptor
mount: Mounting 192.0.0.1:/home/omap_linux/nfs on /mnt/nfs failed: 
Invalid argument
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0E:99:02:02:42
           inet addr:192.0.0.2  Bcast:192.0.0.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:20 errors:1 dropped:0 overruns:0 carrier:1
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:840 (840.0 B)
           Interrupt:160 Base address:0x1300 DMA chan:ff
# cat /proc/interrupts
            CPU0
...
160:          1   eth0
...
Err:          0

Telnet and ping don't work as well. I imagine that I doesn't change any 
configuration, only kernel update form git. UBoots tftpboot works quite 
well.

Regards

Dirk
