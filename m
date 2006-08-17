From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: Register LCD backlight on PalmTE
Date: Thu, 17 Aug 2006 22:49:07 +0200
Message-ID: <fb249edb0608171349k1ee31982w1cc0197d95d9235@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_34098_9765846.1155847747597"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_34098_9765846.1155847747597
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add the backlight device to the list of platform devices to register
on the Palm Tungsten E board. In the same way the device can be added
in other board files if a board has a single LCD with the backlight
controlled by OMAP PWL module.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_34098_9765846.1155847747597
Content-Type: application/octet-stream; name=linux-omap-palmte-backlight.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqzq2l14
Content-Disposition: attachment; filename="linux-omap-palmte-backlight.patch"

ZGlmZiAtcE5hdXIgYS9hcmNoL2FybS9tYWNoLW9tYXAxL2JvYXJkLXBhbG10ZS5jIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMS9ib2FyZC1wYWxtdGUuYwotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAxL2Jv
YXJkLXBhbG10ZS5jCTIwMDYtMDMtMjIgMTc6NDQ6MjQuMDAwMDAwMDAwICswMDAwCisrKyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDEvYm9hcmQtcGFsbXRlLmMJMjAwNi0wOC0xNyAyMjoxNDoyNi4wMDAw
MDAwMDAgKzAwMDAKQEAgLTQzLDggKzQzLDIxIEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlIHBhbG10ZV9sY2QKIAkuaWQJCT0gLTEsCiB9OwogCitzdGF0aWMgc3RydWN0IG9tYXBfYmFj
a2xpZ2h0X2NvbmZpZyBwYWxtdGVfYmFja2xpZ2h0X2NvbmZpZyA9IHsKKwkuZGVmYXVsdF9pbnRl
bnNpdHkJPSAweGEwLAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcGFsbXRl
X2JhY2tsaWdodF9kZXZpY2UgPSB7CisJLm5hbWUJCT0gIm9tYXAtYmwiLAorCS5pZAkJPSAtMSwK
KwkuZGV2CQk9IHsKKwkJLnBsYXRmb3JtX2RhdGEJPSAmcGFsbXRlX2JhY2tsaWdodF9jb25maWcs
CisJfSwKK307CisKIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXZpY2VzW10gX19p
bml0ZGF0YSA9IHsKIAkmcGFsbXRlX2xjZF9kZXZpY2UsCisJJnBhbG10ZV9iYWNrbGlnaHRfZGV2
aWNlLAogfTsKIAogc3RhdGljIHN0cnVjdCBvbWFwX3VzYl9jb25maWcgcGFsbXRlX3VzYl9jb25m
aWcgX19pbml0ZGF0YSA9IHsK
------=_Part_34098_9765846.1155847747597
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_34098_9765846.1155847747597--
