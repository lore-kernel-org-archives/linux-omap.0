From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Tue, 28 Feb 2012 19:34:05 +0530
Message-ID: <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
References: <4F3E0EB7.9060803@ti.com> <874nuizfyf.fsf@ti.com>
 <4F4613B7.8010601@kynesim.co.uk> <4F4B9405.9070702@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae9d2f2625e7c4304ba06b494
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46347 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab2B1OE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 09:04:27 -0500
Received: by eekc41 with SMTP id c41so1149506eek.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 06:04:26 -0800 (PST)
In-Reply-To: <4F4B9405.9070702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

--14dae9d2f2625e7c4304ba06b494
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Feb 27, 2012 at 8:02 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wro=
te:
> Hi,
>
> On 02/23/2012 12:23 PM, Richard Watts wrote:
>> On 22/02/12 22:00, Kevin Hilman wrote:
>>> The first thing I try when I see these regulator failures is to add
>>> CONFIG_REGULATOR_DUMMY=3Dy to the .config to see if that helps. =A0If s=
o,
>>> then the board file needs some help configuring the right regulators.
>
> Thanks for the hint Kevin
>
>> =A0Apologies for the malformed patch, but I don't have time to clean it =
up
>> this morning (or test it in its cleaned state); however, the following
>> fixes the problem for me.
>>
>> =A0It used to be masked because u-boot turns the regulator on to activat=
e
>> ethernet on Beagle xM and no-one ever turns it off again, but some versi=
ons
>> of u-boot don't identify xM rev C correctly, so never turn it on ..
>>
>> =A0Anyway, it's neater for the kernel to know what it's doing. And remov=
es
>> a whole two lines of kernel startup output :-)
>
> I have did similar thing as well, but it did not helped. The two line
> complaining about the regulator was gone, but still neither the ethernet
> nor the USB ports were working.
> The LED between the USB ports are lit, shich indicates that the LAN9514
> should have the needed power.
> With the REGULATOR_DUMMY enabled I have this in the kernel log:
>
> beagle-gentoo ~ # dmesg | grep ehci-omap
> [ =A0 =A01.443420] _regulator_get: ehci-omap.0 supply hsusb0 not found,
> using dummy regulator
> [ =A0 =A01.452026] _regulator_get: ehci-omap.0 supply hsusb1 not found,
> using dummy regulator
> [ =A0 =A02.465637] ehci-omap ehci-omap.0: phy reset operation timed out
> [ =A0 =A03.473449] ehci-omap ehci-omap.0: phy reset operation timed out
> [ =A0 =A03.479766] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=3D0=
 cc=3D1
> pcc=3D3 ordered ports=3D3
> [ =A0 =A03.488586] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1
> uframes 256/512/1024 park
> [ =A0 =A03.497436] ehci-omap ehci-omap.0: reset command 0080b02 =A0park=
=3D3
> ithresh=3D8 period=3D1024 Reset HALT
> [ =A0 =A03.506774] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> [ =A0 =A03.524871] ehci-omap ehci-omap.0: new USB bus registered, assigne=
d
> bus number 1
> [ =A0 =A03.532806] ehci-omap ehci-omap.0: park 0
> [ =A0 =A03.537139] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> [ =A0 =A03.543121] ehci-omap ehci-omap.0: init command 0010005 (park)=3D0
> ithresh=3D1 period=3D512 RUN
> [ =A0 =A03.567260] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> [ =A0 =A03.609771] usb usb1: SerialNumber: ehci-omap.0
> [ =A0 =A03.690460] ehci-omap ehci-omap.0: ...powerup ports...
>
> I have a faint recollection that the ethernet port along with the USB
> ports were working in some ancient kernel (2.6.3x) - I think it was the
> distro which come with board...
>
> It might be that I have everything built into the kernel?
> Will debug this further when time allows...

The issue seems to a mux conflict issue, uart2_rx mux is been taken
by uart init and gpio_147 needed for usb phy init is not in mux mode4
as set by bootloader.

On beagle I see no other uarts being used other than uart3 as console_uart.
So I think it should be okay to init only uart3 from beagle board data.
Here is the patch [1] to do the same. (Tested on Beagle Xm Rev.C)

(Any other approach is welcome)

[1]:


>From f1b43f983a2926c637e6bc6ab5d1e5044339ffd3 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 28 Feb 2012 19:16:33 +0530
Subject: [PATCH] omap3_beagle: Init only uart3 used for console

On beagle some of uart mux lines are used for other
purpose so init only uart3.

Uart2 rx line clashes with gpio_147 used for usb ehci
phy reset.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   50 +++++++++++++++++++++++++++=
+++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 817be06..a2e0052 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -493,6 +493,54 @@ static const struct usbhs_omap_board_data
usbhs_bdata __initconst =3D {
 static struct omap_board_mux board_mux[] __initdata =3D {
 	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad uart3_pads[] __initdata =3D {
+	{
+		.name	=3D "uart3_cts_rctx.uart3_cts_rctx",
+		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	=3D "uart3_rts_sd.uart3_rts_sd",
+		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	=3D "uart3_tx_irtx.uart3_tx_irtx",
+		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	=3D "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+		.idle	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data uart3_bdata;
+	uart3_bdata.flags     =3D 0;
+	uart3_bdata.pads      =3D uart3_pads;
+	uart3_bdata.pads_cnt  =3D ARRAY_SIZE(uart3_pads);
+	uart3_bdata.id        =3D 2;
+
+	/*
+	 * Init only uart3 used as console
+	 * don't init other uarts as uart mux lines
+	 * might be used for other purpose on beagle board
+	 * ex: uart2_rx used by gpio_147 for usb_ehci phy reset.
+	 */
+	omap_serial_init_port(&uart3_bdata, NULL);
+}
+#else
+
+/*
+ * If mux is disabled from kernel probably we
+ * are relying on boot-loaders so we init all uarts
+ */
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif

 static void __init beagle_opp_init(void)
@@ -549,7 +597,7 @@ static void __init omap3_beagle_init(void)
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-	omap_serial_init();
+	board_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);

--=20
1.7.5.4

--14dae9d2f2625e7c4304ba06b494
Content-Type: application/octet-stream;
	name="0001-omap3_beagle-Init-only-uart3-used-for-console.patch"
Content-Disposition: attachment;
	filename="0001-omap3_beagle-Init-only-uart3-used-for-console.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz70b7gd1

RnJvbSBmMWI0M2Y5ODNhMjkyNmM2MzdlNmJjNmFiNWQxZTUwNDQzMzlmZmQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiR292aW5kcmFqLlIiIDxnb3ZpbmRyYWoucmFqYUB0aS5jb20+
CkRhdGU6IFR1ZSwgMjggRmViIDIwMTIgMTk6MTY6MzMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBv
bWFwM19iZWFnbGU6IEluaXQgb25seSB1YXJ0MyB1c2VkIGZvciBjb25zb2xlCgpPbiBiZWFnbGUg
c29tZSBvZiB1YXJ0IG11eCBsaW5lcyBhcmUgdXNlZCBmb3Igb3RoZXIKcHVycG9zZSBzbyBpbml0
IG9ubHkgdWFydDMuCgpVYXJ0MiByeCBsaW5lIGNsYXNoZXMgd2l0aCBncGlvXzE0NyB1c2VkIGZv
ciB1c2IgZWhjaQpwaHkgcmVzZXQuCgpTaWduZWQtb2ZmLWJ5OiBHb3ZpbmRyYWouUiA8Z292aW5k
cmFqLnJhamFAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNiZWFn
bGUuYyB8ICAgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlcyBjaGFu
Z2VkLCA0OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNiZWFnbGUuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
Ym9hcmQtb21hcDNiZWFnbGUuYwppbmRleCA4MTdiZTA2Li5hMmUwMDUyIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzYmVhZ2xlLmMKKysrIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC1vbWFwM2JlYWdsZS5jCkBAIC00OTMsNiArNDkzLDU0IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdXNiaHNfb21hcF9ib2FyZF9kYXRhIHVzYmhzX2JkYXRhIF9faW5pdGNvbnN0
ID0gewogc3RhdGljIHN0cnVjdCBvbWFwX2JvYXJkX211eCBib2FyZF9tdXhbXSBfX2luaXRkYXRh
ID0gewogCXsgLnJlZ19vZmZzZXQgPSBPTUFQX01VWF9URVJNSU5BVE9SIH0sCiB9OworCitzdGF0
aWMgc3RydWN0IG9tYXBfZGV2aWNlX3BhZCB1YXJ0M19wYWRzW10gX19pbml0ZGF0YSA9IHsKKwl7
CisJCS5uYW1lCT0gInVhcnQzX2N0c19yY3R4LnVhcnQzX2N0c19yY3R4IiwKKwkJLmVuYWJsZQk9
IE9NQVBfUElOX0lOUFVUX1BVTExVUCB8IE9NQVBfTVVYX01PREUwLAorCX0sCisJeworCQkubmFt
ZQk9ICJ1YXJ0M19ydHNfc2QudWFydDNfcnRzX3NkIiwKKwkJLmVuYWJsZQk9IE9NQVBfUElOX09V
VFBVVCB8IE9NQVBfTVVYX01PREUwLAorCX0sCisJeworCQkubmFtZQk9ICJ1YXJ0M190eF9pcnR4
LnVhcnQzX3R4X2lydHgiLAorCQkuZW5hYmxlCT0gT01BUF9QSU5fT1VUUFVUIHwgT01BUF9NVVhf
TU9ERTAsCisJfSwKKwl7CisJCS5uYW1lCT0gInVhcnQzX3J4X2lycngudWFydDNfcnhfaXJyeCIs
CisJCS5mbGFncwk9IE9NQVBfREVWSUNFX1BBRF9SRU1VWCB8IE9NQVBfREVWSUNFX1BBRF9XQUtF
VVAsCisJCS5lbmFibGUJPSBPTUFQX1BJTl9JTlBVVCB8IE9NQVBfTVVYX01PREUwLAorCQkuaWRs
ZQk9IE9NQVBfUElOX0lOUFVUIHwgT01BUF9NVVhfTU9ERTAsCisJfSwKK307CisKK3N0YXRpYyBp
bmxpbmUgdm9pZCBib2FyZF9zZXJpYWxfaW5pdCh2b2lkKQoreworCXN0cnVjdCBvbWFwX2JvYXJk
X2RhdGEgdWFydDNfYmRhdGE7CisJdWFydDNfYmRhdGEuZmxhZ3MgICAgID0gMDsKKwl1YXJ0M19i
ZGF0YS5wYWRzICAgICAgPSB1YXJ0M19wYWRzOworCXVhcnQzX2JkYXRhLnBhZHNfY250ICA9IEFS
UkFZX1NJWkUodWFydDNfcGFkcyk7CisJdWFydDNfYmRhdGEuaWQgICAgICAgID0gMjsKKworCS8q
CisJICogSW5pdCBvbmx5IHVhcnQzIHVzZWQgYXMgY29uc29sZQorCSAqIGRvbid0IGluaXQgb3Ro
ZXIgdWFydHMgYXMgdWFydCBtdXggbGluZXMKKwkgKiBtaWdodCBiZSB1c2VkIGZvciBvdGhlciBw
dXJwb3NlIG9uIGJlYWdsZSBib2FyZAorCSAqIGV4OiB1YXJ0Ml9yeCB1c2VkIGJ5IGdwaW9fMTQ3
IGZvciB1c2JfZWhjaSBwaHkgcmVzZXQuCisJICovCisJb21hcF9zZXJpYWxfaW5pdF9wb3J0KCZ1
YXJ0M19iZGF0YSwgTlVMTCk7Cit9CisjZWxzZQorCisvKgorICogSWYgbXV4IGlzIGRpc2FibGVk
IGZyb20ga2VybmVsIHByb2JhYmx5IHdlCisgKiBhcmUgcmVseWluZyBvbiBib290LWxvYWRlcnMg
c28gd2UgaW5pdCBhbGwgdWFydHMKKyAqLworc3RhdGljIGlubGluZSB2b2lkIGJvYXJkX3Nlcmlh
bF9pbml0KHZvaWQpCit7CisJb21hcF9zZXJpYWxfaW5pdCgpOworfQogI2VuZGlmCiAKIHN0YXRp
YyB2b2lkIF9faW5pdCBiZWFnbGVfb3BwX2luaXQodm9pZCkKQEAgLTU0OSw3ICs1OTcsNyBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgb21hcDNfYmVhZ2xlX2luaXQodm9pZCkKIAlwbGF0Zm9ybV9hZGRf
ZGV2aWNlcyhvbWFwM19iZWFnbGVfZGV2aWNlcywKIAkJCUFSUkFZX1NJWkUob21hcDNfYmVhZ2xl
X2RldmljZXMpKTsKIAlvbWFwX2Rpc3BsYXlfaW5pdCgmYmVhZ2xlX2Rzc19kYXRhKTsKLQlvbWFw
X3NlcmlhbF9pbml0KCk7CisJYm9hcmRfc2VyaWFsX2luaXQoKTsKIAlvbWFwX3NkcmNfaW5pdCht
dDQ2aDMybTMybGY2X3NkcmNfcGFyYW1zLAogCQkJCSAgbXQ0NmgzMm0zMmxmNl9zZHJjX3BhcmFt
cyk7CiAKLS0gCjEuNy41LjQKCg==
--14dae9d2f2625e7c4304ba06b494--
