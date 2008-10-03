From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] Adds custom SOC_SINGLE_TLV for tlv320aic23 codec
Date: Fri, 3 Oct 2008 17:07:30 +0530
Message-ID: <dfeb90390810030436sc40bb8bt5148514b607ac540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3743_16615078.1223033850499"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:7252 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbYJCLhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:37:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1636186rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 04:37:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

------=_Part_3743_16615078.1223033850499
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Replaces SOC_ENUM with custom SOC_SINGLE_TLV for Sidetone volume

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/tlv320aic23.c |   53 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c2d35e9..bb7cfb8 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -113,7 +113,6 @@ static int tlv320aic23_write(struct snd_soc_codec
*codec, unsigned int reg,

 static const char *rec_src_text[] = { "Line", "Mic" };
 static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
-static const char *sidetone_text[] = {"-6db", "-9db", "-12db", "-18db", "0db"};

 static const struct soc_enum rec_src_enum =
 	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
@@ -125,11 +124,56 @@ static const struct soc_enum tlv320aic23_rec_src =
 	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
 static const struct soc_enum tlv320aic23_deemph =
 	SOC_ENUM_SINGLE(TLV320AIC23_DIGT, 1, 4, deemph_text);
-static const struct soc_enum tlv320aic23_sidetone =
-	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 6, 5, sidetone_text);

 static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -12100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(input_gain_tlv, -1725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(sidetone_vol_tlv, -1800, 300, 0);
+
+static int snd_soc_tlv320aic23_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 val, reg;
+
+	val = (ucontrol->value.integer.value[0] & 0x07);
+
+	/* linear conversion to userspace
+	* 000	=	-6db
+	* 001	=	-9db
+	* 010	=	-12db
+	* 011	=	-18db (Min)
+	* 100	=	0db (Max)
+	*/
+	val = (val >= 4) ? 4  : (3 - val);
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANLG) & (~0x1C0);
+	tlv320aic23_write(codec, TLV320AIC23_ANLG, reg | (val << 6));
+
+	return 0;
+}
+
+static int snd_soc_tlv320aic23_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 val;
+
+	val = tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANLG) & (0x1C0);
+	val = val >> 6;
+	val = (val >= 4) ? 4  : (3 -  val);
+	ucontrol->value.integer.value[0] = val;
+	return 0;
+
+}
+
+#define SOC_TLV320AIC23_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_tlv320aic23_get_volsw,\
+	.put = snd_soc_tlv320aic23_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }

 static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", TLV320AIC23_LCHNVOL,
@@ -141,7 +185,8 @@ static const struct snd_kcontrol_new
tlv320aic23_snd_controls[] = {
 			 TLV320AIC23_RINVOL, 0, 31, 0, input_gain_tlv),
 	SOC_SINGLE("Mic Input Switch", TLV320AIC23_ANLG, 1, 1, 1),
 	SOC_SINGLE("Mic Booster Switch", TLV320AIC23_ANLG, 0, 1, 0),
-	SOC_ENUM("Sidetone Gain", tlv320aic23_sidetone),
+	SOC_TLV320AIC23_SINGLE_TLV("Sidetone Volume", TLV320AIC23_ANLG,
+				  6, 4, 0, sidetone_vol_tlv),
 	SOC_ENUM("Playback De-emphasis", tlv320aic23_deemph),
 };

-- 
1.5.3.4

------=_Part_3743_16615078.1223033850499
Content-Type: text/x-patch;
 name=0001-Adds-custom-SOC_SINGLE_TLV-for-tlv320aic23-codec.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fluqpzwz0
Content-Disposition: attachment;
 filename=0001-Adds-custom-SOC_SINGLE_TLV-for-tlv320aic23-codec.patch

RnJvbSA1MWMyZmMzYjIxMmExMDhhYjY5Mzg5MzJlMWZlNTA4MjJjNGJhMTI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IEZyaSwgMyBPY3QgMjAwOCAxNzowMToxNiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFk
ZHMgY3VzdG9tIFNPQ19TSU5HTEVfVExWIGZvciB0bHYzMjBhaWMyMyBjb2RlYwoKUmVwbGFjZXMg
U09DX0VOVU0gd2l0aCBjdXN0b20gU09DX1NJTkdMRV9UTFYgZm9yIFNpZGV0b25lIHZvbHVtZQoK
U2lnbmVkLW9mZi1ieTogQXJ1biBLUyA8YXJ1bmtzQG1pc3RyYWxzb2x1dGlvbnMuY29tPgotLS0K
IHNvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMjMuYyB8ICAgNTMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWlj
MjMuYyBiL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMjMuYwppbmRleCBjMmQzNWU5Li5iYjdj
ZmI4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzIzLmMKKysrIGIvc291
bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5jCkBAIC0xMTMsNyArMTEzLDYgQEAgc3RhdGljIGlu
dCB0bHYzMjBhaWMyM193cml0ZShzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMsIHVuc2lnbmVk
IGludCByZWcsCiAKIHN0YXRpYyBjb25zdCBjaGFyICpyZWNfc3JjX3RleHRbXSA9IHsgIkxpbmUi
LCAiTWljIiB9Owogc3RhdGljIGNvbnN0IGNoYXIgKmRlZW1waF90ZXh0W10gPSB7Ik5vbmUiLCAi
MzJLaHoiLCAiNDQuMUtoeiIsICI0OEtoeiJ9Owotc3RhdGljIGNvbnN0IGNoYXIgKnNpZGV0b25l
X3RleHRbXSA9IHsiLTZkYiIsICItOWRiIiwgIi0xMmRiIiwgIi0xOGRiIiwgIjBkYiJ9OwogCiBz
dGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIHJlY19zcmNfZW51bSA9CiAJU09DX0VOVU1fU0lO
R0xFKFRMVjMyMEFJQzIzX0FOTEcsIDIsIDIsIHJlY19zcmNfdGV4dCk7CkBAIC0xMjUsMTEgKzEy
NCw1NiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIHRsdjMyMGFpYzIzX3JlY19zcmMg
PQogCVNPQ19FTlVNX1NJTkdMRShUTFYzMjBBSUMyM19BTkxHLCAyLCAyLCByZWNfc3JjX3RleHQp
Owogc3RhdGljIGNvbnN0IHN0cnVjdCBzb2NfZW51bSB0bHYzMjBhaWMyM19kZWVtcGggPQogCVNP
Q19FTlVNX1NJTkdMRShUTFYzMjBBSUMyM19ESUdULCAxLCA0LCBkZWVtcGhfdGV4dCk7Ci1zdGF0
aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIHRsdjMyMGFpYzIzX3NpZGV0b25lID0KLQlTT0NfRU5V
TV9TSU5HTEUoVExWMzIwQUlDMjNfQU5MRywgNiwgNSwgc2lkZXRvbmVfdGV4dCk7CiAKIHN0YXRp
YyBjb25zdCBERUNMQVJFX1RMVl9EQl9TQ0FMRShvdXRfZ2Fpbl90bHYsIC0xMjEwMCwgMTAwLCAw
KTsKIHN0YXRpYyBjb25zdCBERUNMQVJFX1RMVl9EQl9TQ0FMRShpbnB1dF9nYWluX3RsdiwgLTE3
MjUsIDc1LCAwKTsKK3N0YXRpYyBjb25zdCBERUNMQVJFX1RMVl9EQl9TQ0FMRShzaWRldG9uZV92
b2xfdGx2LCAtMTgwMCwgMzAwLCAwKTsKKworc3RhdGljIGludCBzbmRfc29jX3RsdjMyMGFpYzIz
X3B1dF92b2xzdyhzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKKwlzdHJ1Y3Qgc25kX2N0
bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMg
PSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7CisJdTE2IHZhbCwgcmVnOworCisJdmFsID0g
KHVjb250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdICYgMHgwNyk7CisKKwkvKiBsaW5lYXIg
Y29udmVyc2lvbiB0byB1c2Vyc3BhY2UKKwkqIDAwMAk9CS02ZGIKKwkqIDAwMQk9CS05ZGIKKwkq
IDAxMAk9CS0xMmRiCisJKiAwMTEJPQktMThkYiAoTWluKQorCSogMTAwCT0JMGRiIChNYXgpCisJ
Ki8KKwl2YWwgPSAodmFsID49IDQpID8gNCAgOiAoMyAtIHZhbCk7CisKKwlyZWcgPSB0bHYzMjBh
aWMyM19yZWFkX3JlZ19jYWNoZShjb2RlYywgVExWMzIwQUlDMjNfQU5MRykgJiAofjB4MUMwKTsK
Kwl0bHYzMjBhaWMyM193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfQU5MRywgcmVnIHwgKHZhbCA8
PCA2KSk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBzbmRfc29jX3RsdjMyMGFpYzIz
X2dldF92b2xzdyhzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKKwlzdHJ1Y3Qgc25kX2N0
bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMg
PSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7CisJdTE2IHZhbDsKKworCXZhbCA9IHRsdjMy
MGFpYzIzX3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBUTFYzMjBBSUMyM19BTkxHKSAmICgweDFDMCk7
CisJdmFsID0gdmFsID4+IDY7CisJdmFsID0gKHZhbCA+PSA0KSA/IDQgIDogKDMgLSAgdmFsKTsK
Kwl1Y29udHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVswXSA9IHZhbDsKKwlyZXR1cm4gMDsKKwor
fQorCisjZGVmaW5lIFNPQ19UTFYzMjBBSUMyM19TSU5HTEVfVExWKHhuYW1lLCByZWcsIHNoaWZ0
LCBtYXgsIGludmVydCwgdGx2X2FycmF5KSBcCit7CS5pZmFjZSA9IFNORFJWX0NUTF9FTEVNX0lG
QUNFX01JWEVSLCAubmFtZSA9IHhuYW1lLCBcCisJLmFjY2VzcyA9IFNORFJWX0NUTF9FTEVNX0FD
Q0VTU19UTFZfUkVBRCB8XAorCQkgU05EUlZfQ1RMX0VMRU1fQUNDRVNTX1JFQURXUklURSxcCisJ
LnRsdi5wID0gKHRsdl9hcnJheSksIFwKKwkuaW5mbyA9IHNuZF9zb2NfaW5mb192b2xzdywgLmdl
dCA9IHNuZF9zb2NfdGx2MzIwYWljMjNfZ2V0X3ZvbHN3LFwKKwkucHV0ID0gc25kX3NvY190bHYz
MjBhaWMyM19wdXRfdm9sc3csIFwKKwkucHJpdmF0ZV92YWx1ZSA9ICBTT0NfU0lOR0xFX1ZBTFVF
KHJlZywgc2hpZnQsIG1heCwgaW52ZXJ0KSB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyB0bHYzMjBhaWMyM19zbmRfY29udHJvbHNbXSA9IHsKIAlTT0NfRE9VQkxFX1Jf
VExWKCJEaWdpdGFsIFBsYXliYWNrIFZvbHVtZSIsIFRMVjMyMEFJQzIzX0xDSE5WT0wsCkBAIC0x
NDEsNyArMTg1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHRsdjMy
MGFpYzIzX3NuZF9jb250cm9sc1tdID0gewogCQkJIFRMVjMyMEFJQzIzX1JJTlZPTCwgMCwgMzEs
IDAsIGlucHV0X2dhaW5fdGx2KSwKIAlTT0NfU0lOR0xFKCJNaWMgSW5wdXQgU3dpdGNoIiwgVExW
MzIwQUlDMjNfQU5MRywgMSwgMSwgMSksCiAJU09DX1NJTkdMRSgiTWljIEJvb3N0ZXIgU3dpdGNo
IiwgVExWMzIwQUlDMjNfQU5MRywgMCwgMSwgMCksCi0JU09DX0VOVU0oIlNpZGV0b25lIEdhaW4i
LCB0bHYzMjBhaWMyM19zaWRldG9uZSksCisJU09DX1RMVjMyMEFJQzIzX1NJTkdMRV9UTFYoIlNp
ZGV0b25lIFZvbHVtZSIsIFRMVjMyMEFJQzIzX0FOTEcsCisJCQkJICA2LCA0LCAwLCBzaWRldG9u
ZV92b2xfdGx2KSwKIAlTT0NfRU5VTSgiUGxheWJhY2sgRGUtZW1waGFzaXMiLCB0bHYzMjBhaWMy
M19kZWVtcGgpLAogfTsKIAotLSAKMS41LjMuNAoK
------=_Part_3743_16615078.1223033850499--
