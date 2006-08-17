From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: Backlight configuration struct
Date: Thu, 17 Aug 2006 22:40:16 +0200
Message-ID: <fb249edb0608171340g11e8ea1aj827dbcf1f0797940@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_33800_1440255.1155847216571"
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_33800_1440255.1155847216571
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This adds a structure that can be used in the omap board files to pass
data about backlight device when registering platform devices.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_33800_1440255.1155847216571
Content-Type: application/octet-stream; name=linux-arch-omap-backlight.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqzpxe5s
Content-Disposition: attachment; filename="linux-arch-omap-backlight.patch"

ZGlmZiAtcE5hdXIgYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLmggYi9pbmNsdWRl
L2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLmgKLS0tIGEvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21h
cC9ib2FyZC5oCTIwMDYtMDgtMTcgMTE6MjE6NTAuMDAwMDAwMDAwICswMDAwCisrKyBiL2luY2x1
ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQuaAkyMDA2LTA4LTE3IDIxOjExOjM5LjAwMDAwMDAw
MCArMDAwMApAQCAtMTA1LDYgKzEwNSwxNCBAQCBzdHJ1Y3Qgb21hcF9sY2RfY29uZmlnIHsKIAl1
OCAgIGRhdGFfbGluZXM7CiB9OwogCitzdHJ1Y3QgZGV2aWNlOworc3RydWN0IGZiX2luZm87Citz
dHJ1Y3Qgb21hcF9iYWNrbGlnaHRfY29uZmlnIHsKKwlpbnQgZGVmYXVsdF9pbnRlbnNpdHk7CisJ
aW50ICgqc2V0X3Bvd2VyKShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBzdGF0ZSk7CisJaW50ICgq
Y2hlY2tfZmIpKHN0cnVjdCBmYl9pbmZvICpmYik7Cit9OworCiBzdHJ1Y3Qgb21hcF9mYm1lbV9j
b25maWcgewogCXUzMiBzdGFydDsKIAl1MzIgc2l6ZTsK
------=_Part_33800_1440255.1155847216571
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_33800_1440255.1155847216571--
