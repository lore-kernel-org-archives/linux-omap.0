From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Low Level Kernel Debug Prints
Date: Thu, 11 Jan 2007 08:29:59 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47080FA3@dlee13.ent.ti.com>
References: <7d8fdf6f0701110406j5d9e5ca8x60db38d381dc4a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Raghunandan Dhongadi <dk.raghu@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
=20
The plat-omap/omap24xx-uart.c is actually a centralized UART library for =
HSUART with DMA support. Its not a debug uart. We still use the standard =
uart driver in drivers for debug UART.
=20
To enable kernel debugging enable the low level kernel debugging option =
in menuconfig / Kernel hacking.=20
=20
What exactly are you looking for?
=20
Regards,
Khasim

________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of =
Raghunandan Dhongadi
Sent: Thu 1/11/2007 6:06 AM
To: linux-omap-open-source@linux.omap.com
Subject: Low Level Kernel Debug Prints



Hello All,

I have a OMAP2430 SDP board, I wanted to get the low level kernel
debug messaging, soon after the "Uncompressing Linux........." message
comes from the u-boot. I enabled the debugs in
"plat-omap/omap24xx-uart.c" file.

But I dont get any prints, is there anything else I need to do ?

Warm Regards,
Raghu.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
