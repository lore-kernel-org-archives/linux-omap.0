From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] I2C support for 2430 SDP
Date: Mon, 20 Nov 2006 23:55:25 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01F29AD0@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70D31.A43353FA"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70D31.A43353FA
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch enables I2C support in 2430 SDP default config.

Please do let me know if you find any issues with the same.

Thanks & Regards,
Khasim

------_=_NextPart_001_01C70D31.A43353FA
Content-Type: application/octet-stream;
	name="2430sdp_I2C_defconfig.patch"
Content-Transfer-Encoding: base64
Content-Description: 2430sdp_I2C_defconfig.patch
Content-Disposition: attachment;
	filename="2430sdp_I2C_defconfig.patch"

VGhpcyBwYXRjaCBhZGRzIEkyQyBzdXBwb3J0IGZvciAyNDMwIFNEUC4KClNpZ25lZC1vZmYtYnk6
IFN5ZWQgTW9oYW1tZWQgS2hhc2ltICA8eDBraGFzaW1AdGkuY29tPgoKRmlsZXMgQ2hhbmdlZDoK
IG9tYXBfMjQzMHNkcF9kZWZjb25maWcgfCAgIDQyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LW9tYXAvYXJjaC9hcm0v
Y29uZmlncy9vbWFwXzI0MzBzZHBfZGVmY29uZmlnCTIwMDYtMTEtMjAgMjE6NTM6NTYuMDAwMDAw
MDAwIC0wNjAwCisrKyBteV9saW51eF9kZXZwdC9hcmNoL2FybS9jb25maWdzL29tYXBfMjQzMHNk
cF9kZWZjb25maWcJMjAwNi0xMS0yMCAyMzozMzowNi4wMDAwMDAwMDAgLTA2MDAKQEAgLTEsNyAr
MSw3IEBACiAjCiAjIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBl
ZGl0Ci0jIExpbnV4IGtlcm5lbCB2ZXJzaW9uOiAyLjYuMTktcmM1LW9tYXAxCi0jIE1vbiBOb3Yg
MTMgMTk6Mjg6NDcgMjAwNgorIyBMaW51eCBrZXJuZWwgdmVyc2lvbjogMi42LjE5LXJjNi1vbWFw
MQorIyBNb24gTm92IDIwIDIzOjA1OjIwIDIwMDYKICMKIENPTkZJR19BUk09eQogIyBDT05GSUdf
R0VORVJJQ19USU1FIGlzIG5vdCBzZXQKQEAgLTY1Myw3ICs2NTMsNDMgQEAgQ09ORklHX0hXX1JB
TkRPTV9PTUFQPXkKICMKICMgSTJDIHN1cHBvcnQKICMKLSMgQ09ORklHX0kyQyBpcyBub3Qgc2V0
CitDT05GSUdfSTJDPXkKKyMgQ09ORklHX0kyQ19DSEFSREVWIGlzIG5vdCBzZXQKKworIworIyBJ
MkMgQWxnb3JpdGhtcworIworIyBDT05GSUdfSTJDX0FMR09CSVQgaXMgbm90IHNldAorIyBDT05G
SUdfSTJDX0FMR09QQ0YgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX0FMR09QQ0EgaXMgbm90IHNl
dAorCisjCisjIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAorIworIyBDT05GSUdfSTJDX09DT1JF
UyBpcyBub3Qgc2V0CitDT05GSUdfSTJDX09NQVA9eQorIyBDT05GSUdfSTJDX1BBUlBPUlRfTElH
SFQgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAorIyBDT05GSUdfSTJD
X1BDQV9JU0EgaXMgbm90IHNldAorCisjCisjIE1pc2NlbGxhbmVvdXMgSTJDIENoaXAgc3VwcG9y
dAorIworIyBDT05GSUdfU0VOU09SU19EUzEzMzcgaXMgbm90IHNldAorIyBDT05GSUdfU0VOU09S
U19EUzEzNzQgaXMgbm90IHNldAorIyBDT05GSUdfU0VOU09SU19FRVBST00gaXMgbm90IHNldAor
IyBDT05GSUdfU0VOU09SU19QQ0Y4NTc0IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFTlNPUlNfUENB
OTUzOSBpcyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAorIyBD
T05GSUdfVFBTNjUwMTAgaXMgbm90IHNldAorIyBDT05GSUdfU0VOU09SU19UTFYzMjBBSUMyMyBp
cyBub3Qgc2V0CisjIENPTkZJR19HUElPRVhQQU5ERVJfT01BUCBpcyBub3Qgc2V0CisjIENPTkZJ
R19NRU5FTEFVUyBpcyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX01BWDY4NzUgaXMgbm90IHNl
dAorIyBDT05GSUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX0RFQlVH
X0FMR08gaXMgbm90IHNldAorIyBDT05GSUdfSTJDX0RFQlVHX0JVUyBpcyBub3Qgc2V0CisjIENP
TkZJR19JMkNfREVCVUdfQ0hJUCBpcyBub3Qgc2V0CiAKICMKICMgU1BJIHN1cHBvcnQK

------_=_NextPart_001_01C70D31.A43353FA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C70D31.A43353FA--
