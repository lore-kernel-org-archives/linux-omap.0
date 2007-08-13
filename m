From: "balaji  narayanam" <narayanamb@rediffmail.com>
Subject: REGARDING THE ADDITIONAL SERIAL PORT OF OSK5912
Date: 13 Aug 2007 10:43:46 -0000
Message-ID: <20070813104346.15059.qmail@f5mail16.rediffmail.com>
Reply-To: balaji narayanam <narayanamb@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
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
To: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

 =A0=0AHI=0A =0A=0A I am using an OMAP5912 OSK with linux kernel=0A 2.6.15-=
omap1 for my development.  =0A I have a custom add on card to the OSK that =
sits on=0A connector P11 (Connector B) of the OSK's expansion=0A slot.  The=
 custom board has a serial port that needs=0A to receive data and hence the=
 signals used on the=0A expansion slot are UART2.RX,UART2.TX and UART2.RTS=
=0A =0A However, when I plug in the card and boot my board,=0A this serial =
port is not detected.  Reading the=0A kernel source (drivers/serial/serial_=
core.c and drivers/serial/8250.c) give me information that 4=0A serial port=
s are initialized and hence the serial=0A port  on the add on card must be =
detected.=0A =0A What do I need to enable in the kernel and what=0A changes=
 are to be made in the serial driver for the=0A kernel to detect UART2?=0A =
=0A Same problem already posted in MAy2005 by Mr.Kangesh. But=0A no  respon=
se was posted by our friends.=0A=0AWith Warm Regards=0A=0ABalaji.N=0A=0A
