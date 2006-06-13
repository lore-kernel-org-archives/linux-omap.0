From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Check gpio_fck not gpio_ick.
Date: Tue, 13 Jun 2006 04:20:15 -0700
Message-ID: <1150197615.26712.263694540@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1150197615267120";
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

--_----------=_1150197615267120
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Tue, 13 Jun 2006 11:20:15 UT


-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free


--_----------=_1150197615267120
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Check-gpio_fck-not-gpio_ick.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Check-gpio_fck-not-gpio_ick.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Tue, 13 Jun 2006 11:20:15 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBU
dWUsIDEzIEp1biAyMDA2IDIyOjE4OjI5ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBDaGVjayBncGlvX2ZjayBub3QgZ3Bpb19pY2suCgpT
aWduZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlh
aG9vLmNvbT4KCi0tLQoKIGFyY2gvYXJtL3BsYXQtb21hcC9ncGlvLmMgfCAg
ICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCjYwY2EwODM0ZDI3YTNiMTM4ZTY1ZDE2MDdhM2ZkYWM2
MWFjZDEzM2YKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9ncGlv
LmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZ3Bpby5jCmluZGV4IGU3NWEyY2Eu
LmZkZGE1YjkgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9ncGlv
LmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYwpAQCAtOTgzLDcg
Kzk4Myw3IEBAIHN0YXRpYyBpbnQgX19pbml0IF9vbWFwX2dwaW9faW5pdCh2
b2lkKQogCQllbHNlCiAJCQljbGtfZW5hYmxlKGdwaW9faWNrKTsKIAkJZ3Bp
b19mY2sgPSBjbGtfZ2V0KE5VTEwsICJncGlvc19mY2siKTsKLQkJaWYgKElT
X0VSUihncGlvX2ljaykpCisJCWlmIChJU19FUlIoZ3Bpb19mY2spKQogCQkJ
cHJpbnRrKCJDb3VsZCBub3QgZ2V0IGdwaW9zX2Zja1xuIik7CiAJCWVsc2UK
IAkJCWNsa19lbmFibGUoZ3Bpb19mY2spOwotLSAKMS4zLjMKCg==

--_----------=_1150197615267120
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1150197615267120--
