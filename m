From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] To fix OMAP2430 booting issue
Date: Tue, 9 Jan 2007 05:23:20 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470C5865@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C733E0.91FACE9C"
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

------_=_NextPart_001_01C733E0.91FACE9C
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

The Kernel booting on OMAP2430 breaks due to timer (32K) changes. This
patch fixes the same by adding the 32K timer base address for 2430.

Regards,
Khasim

------_=_NextPart_001_01C733E0.91FACE9C
Content-Type: application/octet-stream;
	name="2430_timer32fix.patch"
Content-Transfer-Encoding: base64
Content-Description: 2430_timer32fix.patch
Content-Disposition: attachment;
	filename="2430_timer32fix.patch"

VGhpcyBwYXRjaCBpcyB0byBmaXggdGhlIDI0MzAgYm9vdGluZyBpc3N1ZSBkdWUgdG8gd3Jvbmcg
YmFzZSBhZGRyZXNzIApmb3IgMzJLIHRpbWVyCgpTaWduZWQtb2ZmLWJ5OiBTeWVkIE1vaGFtbWVk
IEtoYXNpbSAgPHgwa2hhc2ltQHRpLmNvbT4KCkZpbGVzIENoYW5nZWQ6CiBjb21tb24uYyB8ICAg
IDQgKysrLQogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CgotLS0gbGludXgtb21hcC9hcmNoL2FybS9wbGF0LW9tYXAv
Y29tbW9uLmMJMjAwNy0wMS0wOCAxODo1NjowMC4wMDAwMDAwMDAgLTA2MDAKKysrIGluZF9kZXZw
dC9hcmNoL2FybS9wbGF0LW9tYXAvY29tbW9uLmMJMjAwNy0wMS0wOSAwNDo1NTozNS4wMDAwMDAw
MDAgLTA2MDAKQEAgLTE5MSw4ICsxOTEsMTAgQEAgY29uc29sZV9pbml0Y2FsbChvbWFwX2FkZF9z
ZXJpYWxfY29uc29sZQogCiAjaWYgZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMTZYWCkKICNkZWZp
bmUgVElNRVJfMzJLX1NZTkNIUk9OSVpFRAkJMHhmZmZiYzQxMAotI2VsaWYgZGVmaW5lZChDT05G
SUdfQVJDSF9PTUFQMjRYWCkKKyNlbGlmIGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDI0MjApCiAj
ZGVmaW5lIFRJTUVSXzMyS19TWU5DSFJPTklaRUQJCTB4NDgwMDQwMTAKKyNlbGlmIGRlZmluZWQo
Q09ORklHX0FSQ0hfT01BUDI0MzApCisjZGVmaW5lIFRJTUVSXzMyS19TWU5DSFJPTklaRUQJCTB4
NDkwMjAwMTAKICNlbmRpZgogCiAjaWZkZWYJVElNRVJfMzJLX1NZTkNIUk9OSVpFRAo=

------_=_NextPart_001_01C733E0.91FACE9C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C733E0.91FACE9C--
