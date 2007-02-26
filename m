From: "Piotr Filipiuk" <piotr.filipiuk@gmail.com>
Subject: osk 5912 tftpboot problem
Date: Mon, 26 Feb 2007 22:44:31 +0100
Message-ID: <5d18bc9a0702261344g7d40d0f9gc9796e57bfb9870e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,
While trying to send uImage to the board by tftp I get following message:

OMAP5912 OSK # tftpboot 0x10000000 uImage
TFTP from server 192.168.1.2; our IP address is 192.168.1.3
Filename 'uImage'.
Load address: 0x10000000
Loading: T T T T T T T T T T
Retry count exceeded; starting again
TFTP from server 192.168.1.2; our IP address is 192.168.1.3
Filename 'uImage'.
Load address: 0x10000000
Loading: T T T T T T T T T T
Abort

Could anyone explain me what is the problem...

log files:
/var/log/syslog

Feb 26 22:27:32 filip-desktop kernel: [17182455.224000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=265 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=138 DPT=138 LEN=245
Feb 26 22:27:32 filip-desktop kernel: [17182455.224000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=78 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=58

/var/log/messages

Feb 26 22:27:32 filip-desktop kernel: [17182455.224000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=265 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=138 DPT=138 LEN=245
Feb 26 22:27:32 filip-desktop kernel: [17182455.224000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=78 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=58
Feb 26 22:32:32 filip-desktop kernel: [17182755.244000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=78 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=58
Feb 26 22:37:22 filip-desktop kernel: [17183045.600000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=265 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=138 DPT=138 LEN=245
Feb 26 22:37:22 filip-desktop kernel: [17183045.600000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=78 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=58
Feb 26 22:42:33 filip-desktop kernel: [17183356.364000] Unknown OutputIN=
OUT=eth0 SRC=192.168.1.2 DST=192.168.1.255 LEN=78 TOS=0x00 PREC=0x00 TTL=64
ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=58
