From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: [PATCH] Update the Kconfig entry for omap-bl
Date: Tue, 22 May 2007 19:20:06 +0200
Message-ID: <fb249edb0705221020t271c2229m78808edfed2cb3d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_62187_13414649.1179854406292"
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
To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_62187_13414649.1179854406292
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 - CONFIG_BACKLIGHT_DEVICE now became CONFIG_BACKLIGHT_CLASS_DEVICE.
 - Re-add OMAPBL_MAX_INTENSITY usage that was removed in last commit
and the macro became unused.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_62187_13414649.1179854406292
Content-Type: text/plain; name=0003-OMAP-Update-omap-bl-Kconfig-entry.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f20oul0n
Content-Disposition: attachment;
	filename="0003-OMAP-Update-omap-bl-Kconfig-entry.txt"

RnJvbSBmZWI3OTgwMzllNWM2ZTA2ZjY0NTU2YWQ0ODJkYmJkMDIxMTUzYTFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGJhbHJvZ0B6YWJvci5vcmc+
CkRhdGU6IFR1ZSwgMjIgTWF5IDIwMDcgMTk6NTk6MTEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBP
TUFQOiBVcGRhdGUgb21hcC1ibCBLY29uZmlnIGVudHJ5LgoKIC0gQ09ORklHX0JBQ0tMSUdIVF9E
RVZJQ0UgaXMgbm93IENPTkZJR19CQUNLTElHSFRfQ0xBU1NfREVWSUNFLgogLSBSZS1hZGQgT01B
UEJMX01BWF9JTlRFTlNJVFkgdXNhZ2UgdGhhdCBiZWNhbWUgdW51c2VkIGFmdGVyIGxhc3QgY29t
bWl0LgotLS0KIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L0tjb25maWcgICB8ICAgIDIgKy0KIGRy
aXZlcnMvdmlkZW8vYmFja2xpZ2h0L29tYXBfYmwuYyB8ICAgIDEgKwogMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aWRlby9iYWNrbGlnaHQvS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L0tjb25maWcK
aW5kZXggMzNkNzFjMS4uYjcwNTQxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9iYWNrbGln
aHQvS2NvbmZpZworKysgYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9LY29uZmlnCkBAIC01OCw3
ICs1OCw3IEBAIGNvbmZpZyBCQUNLTElHSFRfSFA2ODAKIAogY29uZmlnIEJBQ0tMSUdIVF9PTUFQ
CiAJdHJpc3RhdGUgIk9NQVAgTENEIEJhY2tsaWdodCIKLQlkZXBlbmRzIG9uIEJBQ0tMSUdIVF9E
RVZJQ0UgJiYgKEFSQ0hfT01BUDEgfHwgQVJDSF9PTUFQMikKKwlkZXBlbmRzIG9uIEJBQ0tMSUdI
VF9DTEFTU19ERVZJQ0UgJiYgKEFSQ0hfT01BUDEgfHwgQVJDSF9PTUFQMikKIAlkZWZhdWx0IHkK
IAloZWxwCiAJICBUaGlzIGRyaXZlciBjb250cm9scyB0aGUgTENEIGJhY2tsaWdodCBsZXZlbCBh
bmQgcG93ZXIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L29tYXBfYmwuYyBi
L2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L29tYXBfYmwuYwppbmRleCBhOTUzMmZkLi4zMjQ5YmY4
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9vbWFwX2JsLmMKKysrIGIvZHJp
dmVycy92aWRlby9iYWNrbGlnaHQvb21hcF9ibC5jCkBAIC0xNzAsNiArMTcwLDcgQEAgc3RhdGlj
IGludCBvbWFwYmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlvbWFwX2Nm
Z19yZWcoUFdMKTsJLyogQ29uZmxpY3RzIHdpdGggVUFSVDMgKi8KIAogCWRldi0+cHJvcHMuZmJf
YmxhbmsgPSBGQl9CTEFOS19VTkJMQU5LOworCWRldi0+cHJvcHMubWF4X2JyaWdodG5lc3MgPSBP
TUFQQkxfTUFYX0lOVEVOU0lUWTsKIAlkZXYtPnByb3BzLmJyaWdodG5lc3MgPSBwZGF0YS0+ZGVm
YXVsdF9pbnRlbnNpdHk7CiAJb21hcGJsX3VwZGF0ZV9zdGF0dXMoZGV2KTsKIAotLSAKMS40LjQu
MwoK
------=_Part_62187_13414649.1179854406292
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_62187_13414649.1179854406292--
