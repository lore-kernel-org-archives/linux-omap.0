From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] To add OMAP 2430 Support
Date: Fri, 3 Nov 2006 16:49:51 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01CADC92@DLEE09.ent.ti.com>
References: <200611031400.29261.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6FF9A.5F720991"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <200611031400.29261.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com, Dirk Behme <dirk.behme@googlemail.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FF9A.5F720991
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dirk / David,

Many Thanks for the review.=20

Actually we can operate SMC91x in both edge and level. On H4 Ethernet
does work with IRQF_TRIGGER_LOW, I didn't want to break any existing
functionality on first try :).=20

Dirk, thanks for pointing the comment to me, due to my screen color I
missed it :). For now I can make both H4 and 2430SDP as
IRQF_TRIGGER_FALLING.

But if we agree, I can configure H4 and 2430SDP for IRQF_TRIGGER_LOW.

Thanks & Regards
Khasim


-----Original Message-----
From: David Brownell [mailto:david-b@pacbell.net]=20
Sent: Friday, November 03, 2006 4:00 PM
To: linux-omap-open-source@linux.omap.com
Cc: Dirk Behme; Syed Mohammed, Khasim
Subject: Re: [PATCH] To add OMAP 2430 Support

On Friday 03 November 2006 11:28 am, Dirk Behme wrote:

> Any chance (even if I don't see it at the moment ;) ) to=20
> integrate IRQF_TRIGGER_LOW instead into the existing=20
> SMC_IRQ_FLAGS using machine_is_omap_2430sdp and avoiding the=20
> additional #ifdef?

For that matter, why isn't H4 using TRIGGER_LOW?  The only
reason to use edge triggering on earlier hardware was that
the GPIOs didn't support level triggers.  The SMC chip is
actually level-triggered.

- Dave


------_=_NextPart_001_01C6FF9A.5F720991
Content-Type: application/octet-stream;
	name="ethernet_fix2_2430.patch"
Content-Transfer-Encoding: base64
Content-Description: ethernet_fix2_2430.patch
Content-Disposition: attachment;
	filename="ethernet_fix2_2430.patch"

VGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBpbnRlcnJ1cHQgbGluZSBiZWhhdmlvdXIgZm9yIDI0MzAg
U0RQLgoKU2lnbmVkLW9mZi1ieTogU3llZCBNb2hhbW1lZCBLaGFzaW0gIDx4MGtoYXNpbUB0aS5j
b20+CgpGaWxlcyBDaGFuZ2VkOgogc21jOTF4LmggfCAgICA2ICsrKystLQogMSBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGxpbnV4LW9tYXAvZHJpdmVycy9uZXQvc21jOTF4LmgJMjAwNi0xMS0wMiAwMDoxNjoy
MS4wMDAwMDAwMDAgLTA2MDAKKysrIGRldi1saW51eC1vbWFwLTIuNi5naXQvZHJpdmVycy9uZXQv
c21jOTF4LmgJMjAwNi0xMS0wMyAxNjo0NzowOS4wMDAwMDAwMDAgLTA2MDAKQEAgLTE5Nyw2ICsx
OTcsNyBAQCBTTUNfb3V0dyh1MTYgdmFsLCB2b2lkIF9faW9tZW0gKmlvYWRkciwgCiAJCXx8IG1h
Y2hpbmVfaXNfb21hcF9oMygpIFwKIAkJfHwgbWFjaGluZV9pc19vbWFwX2g0KCkgXAogCQl8fCAo
bWFjaGluZV9pc19vbWFwX2lubm92YXRvcigpICYmICFjcHVfaXNfb21hcDE1MTAoKSkgXAorCQl8
fCBtYWNoaW5lX2lzX29tYXBfMjQzMHNkcCgpIFwKIAkpID8gSVJRRl9UUklHR0VSX0ZBTExJTkcg
OiBJUlFGX1RSSUdHRVJfUklTSU5HKQogCiAK

------_=_NextPart_001_01C6FF9A.5F720991
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C6FF9A.5F720991--
