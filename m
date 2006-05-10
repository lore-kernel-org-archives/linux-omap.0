From: =?gb2312?B?WWFuZyBMdSAtIMK90fQ=?= <Yang.Lu@palmsource.com>
Subject: there are no interrupts for usb device
Date: Wed, 10 May 2006 09:22:13 +0800
Message-ID: <D144B143F3CB4E4FB70C13B5DA622CE1058F7A@mtnex2.mtn.palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have ported linux 2.6.14 to omap730 board and want to usb it as a usb =
device.

=20

USB general purpose IRQ, "non-iso" IRQ and iso IRQ have registered =
successfully in=20

=20

omap_udc_probe function with irq_number 52, 61, 62. Usually, when =
hotplug usb devices,

=20

general purpose IRQ ,"non-iso" IRQ and isp1301 IRQ will occur. But now =
there are no=20

=20

general purpose IRQ ,"non-iso" IRQ except isp1301 IRQ for it.

=20

please give me some suggests!

=20

Thanks!

                  =20

                   Richard
