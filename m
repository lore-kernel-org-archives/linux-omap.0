From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: Disable 32kHz timer warning
Date: Thu, 10 Aug 2006 08:49:17 +0200
Message-ID: <fb249edb0608092349l7af8a3a0sc34efd84013d8a8e@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_69930_16207733.1155192557771"
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

------=_Part_69930_16207733.1155192557771
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This makes the following warning conditional as the 32kHz timer is
only implemented for 16xx out of OMAP1 cpus:
arch/arm/mach-omap1/pm.c:138:2: warning: #warning Enable 32kHz OS
timer in order to allow sleep states in idle

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
-- 
balrog 2oo6

------=_Part_69930_16207733.1155192557771
Content-Type: application/octet-stream; name=linux-32ktimer-warning.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqow4yn6
Content-Disposition: attachment; filename="linux-32ktimer-warning.patch"

LS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMS9wbS5jCTIwMDYtMDctMDYgMDI6NDc6NTYuMDAwMDAw
MDAwICswMDAwCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDEvcG0uYwkyMDA2LTA4LTA4IDA1OjEy
OjA1LjAwMDAwMDAwMCArMDAwMApAQCAtMTM0LDcgKzEzNCw5IEBAIHZvaWQgb21hcF9wbV9pZGxl
KHZvaWQpCiAJdGltZXJfZHluX3JlcHJvZ3JhbSgpOwogCiAjaWZkZWYgQ09ORklHX09NQVBfTVBV
X1RJTUVSCisjaWZkZWYgQ09ORklHX0FSQ0hfT01BUDE2WFgKICN3YXJuaW5nIEVuYWJsZSAzMmtI
eiBPUyB0aW1lciBpbiBvcmRlciB0byBhbGxvdyBzbGVlcCBzdGF0ZXMgaW4gaWRsZQorI2VuZGlm
CiAJdXNlX2lkbGVjdDEgPSB1c2VfaWRsZWN0MSAmIH4oMSA8PCA5KTsKICNlbHNlCiAK
------=_Part_69930_16207733.1155192557771
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_69930_16207733.1155192557771--
