From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Fix OMAP2 build
Date: Mon, 25 Sep 2006 15:33:17 +0530
Message-ID: <1159178597.7339.271740632@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_115917859773392";
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

--_----------=_115917859773392
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 25 Sep 2006 10:03:17 UT

Doyu-San/Tony,

This patch fixes OMAP2 build, as Mailbox base is not defined.

Error message:
arch/arm/mach-omap2/devices.c:75: error: `OMAP24XX_MAILBOX_BASE' undeclared here (not in a function)
arch/arm/mach-omap2/devices.c:75: error: initializer element is not constant
arch/arm/mach-omap2/devices.c:75: error: (near initialization for `mbox_resources[0].start')
arch/arm/mach-omap2/devices.c:76: error: initializer element is not constant
arch/arm/mach-omap2/devices.c:76: error: (near initialization for `mbox_resources[0].end')
arch/arm/mach-omap2/devices.c:78: error: initializer element is not constant
arch/arm/mach-omap2/devices.c:78: error: (near initialization for `mbox_resources[0]')
arch/arm/mach-omap2/devices.c:82: error: initializer element is not constant
arch/arm/mach-omap2/devices.c:82: error: (near initialization for `mbox_resources[1]')
arch/arm/mach-omap2/devices.c:86: error: initializer element is not constant
arch/arm/mach-omap2/devices.c:86: error: (near initialization for `mbox_resources[2]')
make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - A fast, anti-spam email service.


--_----------=_115917859773392
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Fix-OMAP2-build-when-CONFIG_DSP-is-enabled.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Fix-OMAP2-build-when-CONFIG_DSP-is-enabled.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 25 Sep 2006 10:03:17 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBN
b24sIDI1IFNlcCAyMDA2IDIxOjAwOjQ4ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBGaXggT01BUDIgYnVpbGQgd2hlbiBDT05GSUdfRFNQ
IGlzIGVuYWJsZWQKClNpZ25lZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFs
X3NoYWg4MDIwMDNAeWFob28uY29tPgoKLS0tCgogaW5jbHVkZS9hc20tYXJt
L2FyY2gtb21hcC9vbWFwMjR4eC5oIHwgICAgMiArKwogMSBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgo4NjdjNTJk
OWY4ODYyNTU0ODVhNzNlYjMzZDJkODc1MTYwZDY5ODYxCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL29tYXAyNHh4LmggYi9pbmNs
dWRlL2FzbS1hcm0vYXJjaC1vbWFwL29tYXAyNHh4LmgKaW5kZXggYjcwMDYz
My4uYTE3ZmE2MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tYXJtL2FyY2gt
b21hcC9vbWFwMjR4eC5oCisrKyBiL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9t
YXAvb21hcDI0eHguaApAQCAtMjgsNSArMjgsNyBAQCAjZGVmaW5lIE9NQVAy
NFhYX0RTUF9NRU1fQkFTRQkoT01BUDI0WFhfCiAjZGVmaW5lIE9NQVAyNFhY
X0RTUF9JUElfQkFTRQkoT01BUDI0WFhfRFNQX0JBU0UgKyAweDEwMDAwMDAp
CiAjZGVmaW5lIE9NQVAyNFhYX0RTUF9NTVVfQkFTRQkoT01BUDI0WFhfRFNQ
X0JBU0UgKyAweDIwMDAwMDApCiAKKyNkZWZpbmUgT01BUDI0WFhfTUFJTEJP
WF9CQVNFCShMNF8yNFhYX0JBU0UgKyAweDk0MDAwKQorCiAjZW5kaWYgLyog
X19BU01fQVJDSF9PTUFQMjRYWF9IICovCiAKLS0gCjEuMy4zCgo=

--_----------=_115917859773392
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_115917859773392--
