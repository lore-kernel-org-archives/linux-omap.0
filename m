From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Use gpmc_cs_get_base_addr for H4 smc91x
Date: Fri, 16 Jun 2006 05:08:52 -0700
Message-ID: <1150459732.2583.263972498@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_115045973225830";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--_----------=_115045973225830
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Fri, 16 Jun 2006 12:08:52 UT

Tested on H4 with NFS.

---Komal Shah
http://komalshah.blogspot.com

--=20
http://www.fastmail.fm - And now for something completely different=85


--_----------=_115045973225830
Content-Disposition: attachment; filename="0001-gpmcsmc91x.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-gpmcsmc91x.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Fri, 16 Jun 2006 12:08:52 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBG
cmksIDE2IEp1biAyMDA2IDIzOjA1OjUwICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBVc2UgZ3BtY19jc19nZXRfYmFzZV9hZGRyIGZvciBI
NCBzbWM5MXgKClNpZ25lZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFsX3No
YWg4MDIwMDNAeWFob28uY29tPgoKLS0tCgogYXJjaC9hcm0vbWFjaC1vbWFw
Mi9ib2FyZC1oNC5jIHwgICAgNiArKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKMDZkMmNmNzI0ODdh
MzcxNmU0MzYwYWQyNTkxZDdhYmQwMDEwZmRmYwpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1oNC5jIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9ib2FyZC1oNC5jCmluZGV4IDQ5MzNmY2UuLjA1ZWJhOTIgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtaDQuYworKysgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWg0LmMKQEAgLTM2LDYgKzM2LDcg
QEAgI2luY2x1ZGUgPGFzbS9hcmNoL2NvbW1vbi5oPgogI2luY2x1ZGUgPGFz
bS9hcmNoL2tleXBhZC5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL21lbmVsYXVz
Lmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvZG1hLmg+CisjaW5jbHVkZSA8YXNt
L2FyY2gvZ3BtYy5oPgogI2luY2x1ZGUgInByY20tcmVncy5oIgogCiAjaW5j
bHVkZSA8YXNtL2lvLmg+CkBAIC0xMzQsOCArMTM1LDYgQEAgc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgaDRfZmxhc2hfZAogCiBzdGF0aWMgc3Ry
dWN0IHJlc291cmNlIGg0X3NtYzkxeF9yZXNvdXJjZXNbXSA9IHsKIAlbMF0g
PSB7Ci0JCS5zdGFydCAgPSBPTUFQMjRYWF9FVEhSX1NUQVJULCAgICAgICAg
ICAvKiBQaHlzaWNhbCAqLwotCQkuZW5kICAgID0gT01BUDI0WFhfRVRIUl9T
VEFSVCArIDB4ZiwKIAkJLmZsYWdzICA9IElPUkVTT1VSQ0VfTUVNLAogCX0s
CiAJWzFdID0gewpAQCAtMjkwLDYgKzI4OSw5IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBfX2luaXQgaDRfaW5pdF9zbWM5MXgKIAkJcmV0dXJuOwogCX0KIAlv
bWFwX3NldF9ncGlvX2RpcmVjdGlvbihPTUFQMjRYWF9FVEhSX0dQSU9fSVJR
LCAxKTsKKworCWg0X3NtYzkxeF9yZXNvdXJjZXNbMF0uc3RhcnQgPSBncG1j
X2NzX2dldF9iYXNlX2FkZHIoMSkgKyAweDMwMDsKKwloNF9zbWM5MXhfcmVz
b3VyY2VzWzBdLmVuZCAgID0gaDRfc21jOTF4X3Jlc291cmNlc1swXS5zdGFy
dCArIDB4ZjsKIH0KIAogc3RhdGljIHZvaWQgX19pbml0IG9tYXBfaDRfaW5p
dF9pcnEodm9pZCkKLS0gCjEuMy4zCgo=

--_----------=_115045973225830
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_115045973225830--
