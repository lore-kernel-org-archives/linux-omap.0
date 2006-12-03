From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] GPMC driver warning fix
Date: Sun, 3 Dec 2006 14:38:27 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE1C@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171A.FC98098A"
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

------_=_NextPart_001_01C7171A.FC98098A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

This patch is to fix a GPMC driver warning / error.

=20

Regards,

Khasim


------_=_NextPart_001_01C7171A.FC98098A
Content-Type: application/octet-stream;
	name="gpmc_errorfix.patch"
Content-Transfer-Encoding: base64
Content-Description: gpmc_errorfix.patch
Content-Disposition: attachment;
	filename="gpmc_errorfix.patch"

VG8gZml4IHJldHVybiB0eXBlIGZvciBHUE1DIGFwaS4KClNpZ25lZC1vZmYtYnk6IFN5ZWQgTW9o
YW1tZWQgS2hhc2ltICA8eDBraGFzaW1AdGkuY29tPgoKRmlsZXMgQ2hhbmdlZDoKIGdwbWMuYyB8
ICAgIDMgKystCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KZGlmZiAtcHVyTiBsaW51eC1vbWFwL2FyY2gvYXJtL21h
Y2gtb21hcDIvZ3BtYy5jIGRldnB0X2JyYW5jaC9hcmNoL2FybS9tYWNoLW9tYXAyL2dwbWMuYwot
LS0gbGludXgtb21hcC9hcmNoL2FybS9tYWNoLW9tYXAyL2dwbWMuYwkyMDA2LTEyLTAxIDAxOjE4
OjM2LjAwMDAwMDAwMCAtMDYwMAorKysgZGV2cHRfYnJhbmNoL2FyY2gvYXJtL21hY2gtb21hcDIv
Z3BtYy5jCTIwMDYtMTItMDMgMTI6MTM6MDIuMDAwMDAwMDAwIC0wNjAwCkBAIC0yNjQsMTMgKzI2
NCwxNCBAQCBzdGF0aWMgaW50IGdwbWNfY3NfbWVtX2VuYWJsZWQoaW50IGNzKQogCXJldHVybiBs
ICYgKDEgPDwgNik7CiB9CiAKLXZvaWQgZ3BtY19jc19zZXRfcmVzZXJ2ZWQoaW50IGNzLCBpbnQg
cmVzZXJ2ZWQpCitpbnQgZ3BtY19jc19zZXRfcmVzZXJ2ZWQoaW50IGNzLCBpbnQgcmVzZXJ2ZWQp
CiB7CiAJaWYgKGNzID4gR1BNQ19DU19OVU0pCiAJCXJldHVybiAtRU5PREVWOwogCiAJZ3BtY19j
c19tYXAgJj0gfigxIDw8IGNzKTsKIAlncG1jX2NzX21hcCB8PSAocmVzZXJ2ZWQgPyAxIDogMCkg
PDwgY3M7CisJcmV0dXJuIDA7CiB9CiAKIGludCBncG1jX2NzX3Jlc2VydmVkKGludCBjcykK

------_=_NextPart_001_01C7171A.FC98098A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171A.FC98098A--
