From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FSUSB Port 0 in OAMP2430 SDP
Date: Mon, 6 Aug 2007 14:29:22 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901967083@dlee13.ent.ti.com>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com><31e679430708051718q6b760029te6bb80c21f805dde@mail.gmail.com><78d6ed630708061154w5ed11bd3m5a8ee11e5a3e64fd@mail.gmail.com>
	<31e679430708061211n33200287wb057d6e520621462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <31e679430708061211n33200287wb057d6e520621462@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, Amit Gupta <amit_jobs05@inbox.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> I'm pretty sure you'll need a self-powered hub anyway 'cause MUSB can
> only provide 100mA and if you wanna power a non-otg usb device it uses
> up to 500mA. The self-powered hub masks this limits to the controller
> as it'll power the usb devices itself.

I think you are both right and wrong.  Its been a few years since I =
looked, so their probably have been some changes.

MUSB likely doesn't supply power to anyone.  The board's power supply =
will do this.  What its capacity is depends on how it was setup.  To be =
OTG stamp on it a device might need to stay at or below 100mA (might be =
self powered also).  For the omap-device to get the stamp it might have =
to at least supply 100.  Do both ends have the USB logo on them?  Do you =
need them to be?

An OTG device to get certified need to support many devices ether.  You =
can have a white list which allows limited support.

It might be you need to manually turn on some LDO or other on some =
detection interrupt.  There was one board with the fs-usb block which =
had this kind of logic I dealt with.  It had 2 ports, one gave just =
enough power for a target peripheral and another port gave lots of =
power.

I seem to recall some noise about raising the limits but that may have =
been a dream.

Regards,
Richard W.
