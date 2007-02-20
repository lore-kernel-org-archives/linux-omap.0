From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 0/3] OMAP MMU framework patches
Date: Tue, 20 Feb 2007 09:54:20 +0200
Message-ID: <20070220095420.5d93f64c.Hiroshi.DOYU@nokia.com>
References: <5d5443650702192251k1cf06891x4414b0188ede7216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Tue__20_Feb_2007_09_54_20_+0200_6.rwNB.qqiMMAWcQ"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702192251k1cf06891x4414b0188ede7216@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__20_Feb_2007_09_54_20_+0200_6.rwNB.qqiMMAWcQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Soni,

On Tue, 20 Feb 2007 12:21:41 +0530
"ext Trilok Soni" <soni.trilok@gmail.com> wrote:

> These three patches adds OMAP MMU framework developed by Paul Mundt,
> Doyu-San and Toshihiro San. Let me know if there are any changes
> required to it.

I guess that there are 3 points to check before merging into public
tree.

First off, though this code was enough tested with N800(omap2), it can
_break_ omap1 compatibility. So we should make sure that this would work
fine with omap1, at least with some dspgw test programs, preferably N770.

Secondly, this MMU framework can be used with iva and camera
driver. So kernel config should be separated as CONFIG_OMAP_MMU_FRW or
something.

Thirdly, it's necessary to make sure that this can be compiled as
kernel module, along with dspgw and mailbox compiled as kernel module.

For reference I've attached the patch for omap1, but I havn't had
enough time to test this with N770, probably something is still
missing.

	Hiroshi DOYU

> 
> I have just continued the jihad of "struct class_device" to "struct
> device" conversion and made it compile :-)
> 
> -- 
> --Trilok Soni

--Multipart=_Tue__20_Feb_2007_09_54_20_+0200_6.rwNB.qqiMMAWcQ
Content-Type: application/octet-stream;
 name="commit-101fe44"
Content-Disposition: attachment;
 filename="commit-101fe44"
Content-Transfer-Encoding: base64

Y29tbWl0IDEwMWZlNDRkOTY3N2YyZmQ2NDExMmU4ZGRhYzg0NzUyNzAyN2I3OGQKQXV0aG9yOiBI
aXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+CkRhdGU6ICAgV2VkIE9jdCAxMSAx
MDoyMjo0MyAyMDA2ICswMzAwCgogICAgdGVtcAogICAgCiAgICBTaWduZWQtb2ZmLWJ5OiBIaXJv
c2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMS9tbXUuaCBiL2FyY2gvYXJtL21hY2gtb21hcDEvbW11LmgKaW5kZXggMzFjZTNi
OC4uM2FjYmI4NCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMS9tbXUuaAorKysgYi9h
cmNoL2FybS9tYWNoLW9tYXAxL21tdS5oCkBAIC0xMDcsMTMgKzEwNywxMyBAQCBzdHJ1Y3Qgb21h
cF9tbXVfdGxiX2VudHJ5IHsKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hvcnQKIG9tYXBfbW11
X3JlYWRfcmVnKHN0cnVjdCBvbWFwX21tdSAqbW11LCB1bnNpZ25lZCBsb25nIHJlZykKIHsKLQly
ZXR1cm4gb21hcF9yZWFkdyhtbXUtPmJhc2UgKyByZWcpOworCXJldHVybiBfX3Jhd19yZWFkdyht
bXUtPmJhc2UgKyByZWcpOwogfQogCiBzdGF0aWMgdm9pZCBvbWFwX21tdV93cml0ZV9yZWcoc3Ry
dWN0IG9tYXBfbW11ICptbXUsCiAJCQkgICAgICAgdW5zaWduZWQgc2hvcnQgdmFsLCB1bnNpZ25l
ZCBsb25nIHJlZykKIHsKLQlvbWFwX3dyaXRldyh2YWwsIG1tdS0+YmFzZSArIHJlZyk7CisJX19y
YXdfd3JpdGV3KHZhbCwgbW11LT5iYXNlICsgcmVnKTsKIH0KIAogaW50IG9tYXBfZHNwX3JlcXVl
c3RfbWVtKHZvaWQpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC9tbXUuaCBi
L2FyY2gvYXJtL3BsYXQtb21hcC9kc3AvbW11LmgKaW5kZXggZDYxZmQwOS4uMjFmYjVmNCAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC9tbXUuaAorKysgYi9hcmNoL2FybS9wbGF0
LW9tYXAvZHNwL21tdS5oCkBAIC03LDcgKzcsNyBAQAogc3RydWN0IG9tYXBfbW11IGRzcF9tbXUg
PSB7CiAJLm5hbWUJCT0gImRzcCIsCiAJLnR5cGUJCT0gT01BUF9NTVVfRFNQLAotCS5iYXNlCQk9
IE9NQVAxNVhYX0RTUF9TVEFSVCwKKwkuYmFzZQkJPSBEU1BfTU1VX0JBU0UsCiAJLm1lbWJhc2UJ
PSBPTUFQMTVYWF9EU1BfQkFTRSwKIAkubWVtc2l6ZQk9IE9NQVAxNVhYX0RTUF9TSVpFLAogCS5u
cl90bGJfZW50cmllcwk9IDMyLApAQCAtMTksNyArMTksNyBAQCBzdHJ1Y3Qgb21hcF9tbXUgZHNw
X21tdSA9IHsKIHN0cnVjdCBvbWFwX21tdSBkc3BfbW11ID0gewogCS5uYW1lCQk9ICJkc3AiLAog
CS50eXBlCQk9IE9NQVBfTU1VX0RTUCwKLQkuYmFzZQkJPSBPTUFQMTZYWF9EU1BfU1RBUlQsCisJ
LmJhc2UJCT0gRFNQX01NVV9CQVNFLAogCS5tZW1iYXNlCT0gT01BUDE2WFhfRFNQX0JBU0UsCiAJ
Lm1lbXNpemUJPSBPTUFQMTZYWF9EU1BfU0laRSwKIAkubnJfdGxiX2VudHJpZXMJPSAzMiwKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9kc3Avb21hcDFfZHNwLmggYi9hcmNoL2FybS9w
bGF0LW9tYXAvZHNwL29tYXAxX2RzcC5oCmluZGV4IDhkZmU0ZDYuLjQ1ZmRiNTAgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL3BsYXQtb21hcC9kc3Avb21hcDFfZHNwLmgKKysrIGIvYXJjaC9hcm0vcGxh
dC1vbWFwL2RzcC9vbWFwMV9kc3AuaApAQCAtMTAzLDcgKzEwMyw3IEBACiAvKgogICogRFNQIE1N
VQogICovCi0jZGVmaW5lIERTUF9NTVVfQkFTRQkJCSgweGZmZmVkMjAwKQorI2RlZmluZSBEU1Bf
TU1VX0JBU0UJCQkoMHhmZWZlZDIwMCkKICNkZWZpbmUgRFNQX01NVV9QUkVGRVRDSAkJKERTUF9N
TVVfQkFTRSArIDB4MDApCiAjZGVmaW5lIERTUF9NTVVfV0FMS0lOR19TVAkJKERTUF9NTVVfQkFT
RSArIDB4MDQpCiAjZGVmaW5lIERTUF9NTVVfQ05UTAkJCShEU1BfTU1VX0JBU0UgKyAweDA4KQoK

--Multipart=_Tue__20_Feb_2007_09_54_20_+0200_6.rwNB.qqiMMAWcQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Multipart=_Tue__20_Feb_2007_09_54_20_+0200_6.rwNB.qqiMMAWcQ--
