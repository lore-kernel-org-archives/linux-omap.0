From: "Kevin.Chang" <ibmw007@gmail.com>
Subject: Severe network problem with omap5912 osk!
Date: Sat, 8 Jul 2006 10:37:56 +0800
Message-ID: <904143c50607071937ua6b09aax7a6bb5f65fd2d89d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

      I followed instructions to upload U-boot to the board by tftp. Tftp
server package has installed."tftpboot" directory is readable and
u-boot.binis inside. I removed "disable = yes" and restart xinetd
service on the
host.I also set ethaddr, ipaddr, serverip, netmask, gatewayip, saveenv on
the board. But when I entered " # tftpboot 0x10000000 u-boot.bin ". The
result was " Loading T T T T T T T T T T Retry count exceeded;starting again
". On the board, the led light D8 and D5 blinked at the same time. The
colorof D8 was green and D5 was red.

     I tried several times and I'm sure all the configuration is OK. So
what's the problem?

     I doubt there are several possibilities bellow:

    1. The network connector of the osk is bad.
    2. The flash can't be written. Actually I can't change or make any
directory on the board when I entered with minicom.
    3. Some jumper or other hardware configuration is not ture.

    I also tried nfs service. "/sbin/ifconfig eth0 192.168.100.10 up" After
I set the ip address on the board. I can't ping the  address form board to
host or form host to board. Does it strange?

   I bought the osk recently and never changed anything on the board.

   So what should I do? I really need you help!!!

 Kevin.Chang
