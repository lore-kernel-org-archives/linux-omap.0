From: "Kanagesh R" <kanagesh@india.com>
Subject: USB functionality on OMAP2430 SDP
Date: Tue, 26 Jun 2007 20:05:01 +0800
Message-ID: <20070626120501.57C377AF01@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello all,

I have been working with an OMAP2430 SDP board trying to get USB ethernet w=
orking to a Windows XP host machine.  I have compiled the USB Gadget driver=
s and the Ethernet Gadget driver with RNDIS support as modules and register=
 them with the kernel once the board boots.

On registering the modules, if I issue an 'ifconfig -a' command, I can see =
that a usb0 interface has been brought up.  On checking registering of inte=
rrupts, there are three interrupts being registered for the USB - omap_udc,=
 omap_udc_pio, omap_udc_iso.  However, nothing happens beyond that.  On ins=
ertion of the USB cable, I see that there are no interrupts being received.

I have verified if USB ethernet works between a Linux target and a Windows =
host using the OMAP5912 OSK board.  I am able to configure a USB ethernet l=
ink between the OSK target running Linux and a Windows XP host machine.  Th=
is board has been tested with Linux-2.6.15, patched with OMAP patches from =
www.muru.com.

May I know if anyone has tested any USB functionality or USB gadget functio=
nality on the OMAP2430 SDP board?  The kernels that I am using for testing =
the USB eth functionality has been downloaded from http://linux.omap.com/pu=
b/kernel/2430sdp/source/ (Linux-2.6.14-omap2-v2 and Linux-2.6.14-omap2-v3).

Thanks in advance for your time,

Regards,
Kanagesh



=3D


--=20
_______________________________________________
Search for products and services at:=20
http://search.mail.com
