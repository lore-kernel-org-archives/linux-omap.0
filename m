From: "Kanagesh R" <kanagesh@india.com>
Subject: Enabling UART 2 on OSK
Date: Thu, 18 May 2006 14:13:39 +0800
Message-ID: <20060518061339.6A275CA0A7@ws5-11.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hello,

I am using an OMAP5912 OSK with linux kernel 2.6.15-omap2 for my developmen=
t.  I have a custom add on card to the OSK that sits on connector P11 (Conn=
ector B) of the OSK's expansion slot.  The custom board has a serial port t=
hat needs to receive data and hence the signals used on the expansion slot =
are UART2.RX, UART2.TX, UART2.RTS and GPIO4.=20=20

However, when I plug in the card and boot my board, this serial port is not=
 detected.  Reading the kernel source (drivers/serial/serial_core.c and dri=
vers/serial/8250.c) give me information that 4 serial ports are initialized=
 and hence the serial port on the add on card must be detected.

What do I need to enable in the kernel and what changes are to be made in t=
he serial driver for the kernel to detect UART2?

Thanks in advance,

Warm regards,
Kanagesh

--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
