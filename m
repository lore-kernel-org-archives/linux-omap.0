From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] update board 2430 file for TWL PIH interrupts
Date: Sun, 3 Dec 2006 14:36:42 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE19@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171A.BDE3362B"
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7171A.BDE3362B
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

The attached patch updates the board 2430 file to handle TWL PIH
interrupts.

=20

Regards,

Khasim


------_=_NextPart_001_01C7171A.BDE3362B
Content-Type: application/octet-stream;
	name="board2430_twlirq.patch"
Content-Transfer-Encoding: base64
Content-Description: board2430_twlirq.patch
Content-Disposition: attachment;
	filename="board2430_twlirq.patch"

VGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBib2FyZC0yNDMwc2RwLmggZm9yIFRXTCBQSUggaW50ZXJy
dXB0cy4KClNpZ25lZC1vZmYtYnk6IFN5ZWQgTW9oYW1tZWQgS2hhc2ltICA8eDBraGFzaW1AdGku
Y29tPgoKRmlsZXMgQ2hhbmdlZDoKIGJvYXJkLTI0MzBzZHAuaCB8ICAgIDcgKysrKysrKwogMSBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmRpZmYg
LXB1ck4gbGludXgtb21hcC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLTI0MzBzZHAu
aCBkZXZwdF9icmFuY2gvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC0yNDMwc2RwLmgK
LS0tIGxpbnV4LW9tYXAvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC0yNDMwc2RwLmgJ
MjAwNi0xMS0yMCAyMTo1Njo1OC4wMDAwMDAwMDAgLTA2MDAKKysrIGRldnB0X2JyYW5jaC9pbmNs
dWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLTI0MzBzZHAuaAkyMDA2LTEyLTAzIDEzOjMwOjU5
LjAwMDAwMDAwMCAtMDYwMApAQCAtMzQsNiArMzQsMTMgQEAKICNkZWZpbmUgT01BUDI0WFhfRVRI
Ul9HUElPX0lSUQkJMTQ5CiAjZGVmaW5lIFNEUDI0MzBfQ1MwX0JBU0UJCTB4MDQwMDAwMDAKIAor
I2RlZmluZSBUV0w0MDMwX0lSUU5VTQkJCUlOVF8yNFhYX1NZU19OSVJRCisKKy8qIFRXTDQwMzAg
UHJpbWFyeSBJbnRlcnJ1cHQgSGFuZGxlciAoUElIKSBpbnRlcnJ1cHRzICovCisjZGVmaW5lIElI
X1RXTDQwMzBfQkFTRQkJSUhfQk9BUkRfQkFTRQorI2RlZmluZSBJSF9UV0w0MDMwX0VORAkJCShJ
SF9UV0w0MDMwX0JBU0UrOCkKKyNkZWZpbmUgTlJfSVJRUwkJCShJSF9UV0w0MDMwX0VORCkKKwo=

------_=_NextPart_001_01C7171A.BDE3362B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171A.BDE3362B--
