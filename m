From: Stefan Hengelein <stefan.hengelein@fau.de>
Subject: Dead Kconfig Option OMAP4_ERRATA_I688
Date: Wed, 25 Feb 2015 18:10:08 +0100
Message-ID: <CABv5NL-bnfV0BoH+G=nX+1eo6xeT_LN8dOFtSnwvdpcvjJhUFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0160ac7a233448050fecb524
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

--089e0160ac7a233448050fecb524
Content-Type: text/plain; charset=UTF-8

During the research for my masters thesis i came across the
OMAP4_ERRATA_I688 option and realized, it is never possible to enable
this option.

The a62a6e98 commit added the "&& !ARCH_MULTIPLATFORM" dependency to
disable this option for multiplatforms. However, because of enclosing
dependencies, this option isn't available for non-MULTIPLATFORM
configurations either.

CONFIG_OMAP4_ERRATA_I688 is defined in the menu "TI OMAP/AM/DM/DRA
Family" which depends on ARCH_MULTI_V6 || ARCH_MULTI_V7. (in
arch/arm/mach-omap2/Kconfig)

ARCH_MULTI_V6 and ARCH_MULTI_V7 however are defined in the menu
"Multiple platform selection" which depends on ARCH_MULTIPLATFORM (in
arch/arm/Kconfig)

Which is a contradiction.

There are no selects on OMAP4_ERRATA_I688, which would ignore
dependencies, either.

The question is:
Was disabling this option for non-MULTIPLATFORM configurations also intentional?

i have added a minimal example of the problem.

--089e0160ac7a233448050fecb524
Content-Type: application/octet-stream; name="Kconfig.minimal"
Content-Disposition: attachment; filename="Kconfig.minimal"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6kz7hnz0

Y29uZmlnIE1NVQoJYm9vbCAiTU1VLWJhc2VkIFBhZ2VkIE1lbW9yeSBNYW5hZ2VtZW50IFN1cHBv
cnQiCglkZWZhdWx0IHkKCmNob2ljZQoJcHJvbXB0ICJBUk0gc3lzdGVtIHR5cGUiCglkZWZhdWx0
IEFSQ0hfTVVMVElQTEFURk9STSBpZiBNTVUKCmNvbmZpZyBBUkNIX01VTFRJUExBVEZPUk0KCWJv
b2wgIkFsbG93IG11bHRpcGxlIHBsYXRmb3JtcyB0byBiZSBzZWxlY3RlZCIKCWRlcGVuZHMgb24g
TU1VCgplbmRjaG9pY2UKCm1lbnUgIk11bHRpcGxlIHBsYXRmb3JtIHNlbGVjdGlvbiIKCWRlcGVu
ZHMgb24gQVJDSF9NVUxUSVBMQVRGT1JNCgpjb21tZW50ICJDUFUgQ29yZSBmYW1pbHkgc2VsZWN0
aW9uIgoKY29uZmlnIEFSQ0hfTVVMVElfVjYKCWJvb2wgIkFSTXY2IGJhc2VkIHBsYXRmb3JtcyAo
QVJNMTEpIgoKY29uZmlnIEFSQ0hfTVVMVElfVjcKCWJvb2wgIkFSTXY3IGJhc2VkIHBsYXRmb3Jt
cyAoQ29ydGV4LUEsIFBKNCwgU2NvcnBpb24sIEtyYWl0KSIKCWRlZmF1bHQgeQoKZW5kbWVudQoK
Cm1lbnUgIlRJIE9NQVAvQU0vRE0vRFJBIEZhbWlseSIKCWRlcGVuZHMgb24gQVJDSF9NVUxUSV9W
NiB8fCBBUkNIX01VTFRJX1Y3Cgpjb25maWcgU09DX09NQVA1Cglib29sICJUSSBPTUFQNSIKCWRl
cGVuZHMgb24gQVJDSF9NVUxUSV9WNwoJc2VsZWN0IEFSQ0hfT01BUDJQTFVTCgpjb25maWcgQVJD
SF9PTUFQNAoJYm9vbCAiVEkgT01BUDQiCglkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjcKCXNlbGVj
dCBBUkNIX09NQVAyUExVUwoKY29uZmlnIEFSQ0hfT01BUDJQTFVTCglib29sCgppZiBBUkNIX09N
QVAyUExVUwoKY29uZmlnIE9NQVA0X0VSUkFUQV9JNjg4Cglib29sICJPTUFQNCBlcnJhdGE6IEFz
eW5jIEJyaWRnZSBDb3JydXB0aW9uIgoJZGVwZW5kcyBvbiAoQVJDSF9PTUFQNCB8fCBTT0NfT01B
UDUpICYmICFBUkNIX01VTFRJUExBVEZPUk0KCmVuZGlmCgplbmRtZW51Cg==
--089e0160ac7a233448050fecb524--
