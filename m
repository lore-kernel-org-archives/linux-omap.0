From: "Gabriel Teixeira" <gabrieldiegoteixeira@gmail.com>
Subject: =?iso-8859-1?q?USB_keyboard_doesn=B4t_work?=
Date: Tue, 4 Sep 2007 17:55:07 -0300
Message-ID: <664bb0260709041355t4994591ex173e76fba78c8e1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Linux-omap-open-source@linux.omap.com, Carlos Haas <carloshaascosta@gmail.com>, Ronaldo Husemann <rhusemann@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi

I=B4m currently using a DaVinci EVM board with MontaVista Linux and the USB
keyboard doesn=B4t works. I installed the musb_hdrc and the usbhid. The usb=
hid
module is installed as shows the lsmod command below:

Module                  Size  Used by
usbhid                 26272  0
dvt_dsa                 2544  0
dsplinkk               68632  0
cmemk                  12476  0
ipv6                  275344  14

And the musb_hdrc is also installed as show a part of the dmesg below:

musb_hdrc: version 2.2a/db-0.4.8 [pio] [host] [debug=3D0]
musb_hdrc: ConfigData=3D0x06 (UTMI-8, dyn FIFOs, SoftConn)
musb_hdrc: MHDRC RTL version 1.300
musb_hdrc: setup fifo_mode 1
musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, doublebuffer, max 512
musb_hdrc: hw_ep 2rx, doublebuffer, max 512
musb_hdrc: hw_ep 3shared, max 256
musb_hdrc: hw_ep 4shared, max 256
musb_hdrc: USB Host mode controller at c8060000 using PIO, IRQ 12
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected

But when a USB keyboard is connected, nothing happens, even the
/dev/input/event0 doesn=B4t show up. I=B4ve put a multimeter in the USB por=
t to
verify if the power was correctly being send and it indicated 5V between th=
e
first and the last track in the USB conector. I heard that this could be a
musb_hdrc issue in another list and this hypothesis is being considered by
me. So what could be?

thanks in advance
Gabriel Teixeira
