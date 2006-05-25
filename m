From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question about USB mass storage on omap2420
Date: Thu, 25 May 2006 07:07:58 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A505E492AE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> The current usb source code can't support omap2420 but it's not
difficult
> to port from TI web 2.6.9 kernel Now USB gadget is working and the
windows
> recognizes the removable disk, and File-backed Storage Gadget.
> But I can't see real disk drive.

What do you mean real disks?

Above you are talking about the OMAP-USB-Device working for you when
compiled on.  This is good.  The OMAP-USB-Device can assume many
profiles.

I generally associate real disks with things like USB flash drives.
These are associated with OMAP-USB-Host.

If you want OMAP-USB-Host you need to compile that on and add needed
client drivers to handle host.  There are 3 combinations:
  host only (arch-init code + ohci driver + transceiver driver)
  device only (arch-init code + omap_udc driver + transceiver driver)
  OTG (arch-init code + ohci + omap_udc + transceiver)

The H4 board also likely has 2 transceivers attached.  You likely want
to use the OTG one.  I seem to recall both attach to USB0 so you can
only use one at a time.

At the 2.6.9 -> 2.6.10 level as can be found on the web I initially did
some amount of checking for usb-device only and usb-host only.  I don't
think the OTG was fully working with the public code.  Others have
touched that code since then so it might be working more, but I'm don't
recall it.

Regards,
Richard W.
