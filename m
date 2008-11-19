From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 1/1] ASoC: Add support for omap2evm board
Date: Wed, 19 Nov 2008 17:45:19 +0530
Message-ID: <dfeb90390811190415t5a1c7f9cj4f7ddc1cdb887370@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_72484_6417505.1227096919074"
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

------=_Part_72484_6417505.1227096919074
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds twl4030 audio support on omap2evm

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/Kconfig    |    9 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap2evm.c |  150 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap2evm.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index cf40e42..6c56277 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -30,4 +30,13 @@ config SND_OMAP_SOC_OVERO
 	help
 	  Say Y if you want to add support for SoC audio on the Gumstix Overo.

+config SND_OMAP_SOC_OMAP2EVM
+	tristate "SoC Audio support for OMAP2EVM board"
+	depends on SND_OMAP_SOC && MACH_OMAP2EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the omap2evm board.
+
+

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index fefc9be..f5da3cc 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -9,8 +9,10 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
+snd-soc-omap2evm-objs := omap2evm.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o

diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
new file mode 100644
index 0000000..c376213
--- /dev/null
+++ b/sound/soc/omap/omap2evm.c
@@ -0,0 +1,150 @@
+/*
+ * omap2evm.c  --  SoC audio machine driver for omap2evm board
+ *
+ * Author: Arun KS <arunks@mistralsolutions.com>
+ *
+ * Based on sound/soc/omap/overo.c by Steve Sakoman
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int omap2evm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap2evm_ops = {
+	.hw_params = omap2evm_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap2evm_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &omap2evm_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_omap2evm = {
+	.name = "omap2evm",
+	.dai_link = &omap2evm_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap2evm_snd_devdata = {
+	.machine = &snd_soc_machine_omap2evm,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap2evm_snd_device;
+
+static int __init omap2evm_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap2evm()) {
+		pr_debug("Not omap2evm!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "omap2evm SoC init\n");
+
+	omap2evm_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap2evm_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap2evm_snd_device, &omap2evm_snd_devdata);
+	omap2evm_snd_devdata.dev = &omap2evm_snd_device->dev;
+	*(unsigned int *)omap2evm_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(omap2evm_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap2evm_snd_device);
+
+	return ret;
+}
+module_init(omap2evm_soc_init);
+
+static void __exit omap2evm_soc_exit(void)
+{
+	platform_device_unregister(omap2evm_snd_device);
+}
+module_exit(omap2evm_soc_exit);
+
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_DESCRIPTION("ALSA SoC omap2evm");
+MODULE_LICENSE("GPL");
-- 
1.5.6.3

------=_Part_72484_6417505.1227096919074
Content-Type: text/x-patch;
 name=0001-ASoC-Add-support-for-omap2evm-board.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnpxsky30
Content-Disposition: attachment;
 filename=0001-ASoC-Add-support-for-omap2evm-board.diff

RnJvbSBmNzBmNzJkNzY3ODE5OGM5MmMxYjY4ZWQ5ZDUyZDQwYTM0OWQ3NmMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFdlZCwgMTkgTm92IDIwMDggMTc6MzE6NTMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
U29DOiBBZGQgc3VwcG9ydCBmb3Igb21hcDJldm0gYm9hcmQKClRoaXMgcGF0Y2ggYWRkcyB0d2w0
MDMwIGF1ZGlvIHN1cHBvcnQgb24gb21hcDJldm0KClNpZ25lZC1vZmYtYnk6IEFydW4gS1MgPGFy
dW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0tCiBzb3VuZC9zb2Mvb21hcC9LY29uZmlnICAg
IHwgICAgOSArKysKIHNvdW5kL3NvYy9vbWFwL01ha2VmaWxlICAgfCAgICAyICsKIHNvdW5kL3Nv
Yy9vbWFwL29tYXAyZXZtLmMgfCAgMTUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNjEgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2Mvb21hcC9vbWFwMmV2bS5jCgpk
aWZmIC0tZ2l0IGEvc291bmQvc29jL29tYXAvS2NvbmZpZyBiL3NvdW5kL3NvYy9vbWFwL0tjb25m
aWcKaW5kZXggY2Y0MGU0Mi4uNmM1NjI3NyAxMDA2NDQKLS0tIGEvc291bmQvc29jL29tYXAvS2Nv
bmZpZworKysgYi9zb3VuZC9zb2Mvb21hcC9LY29uZmlnCkBAIC0zMCw0ICszMCwxMyBAQCBjb25m
aWcgU05EX09NQVBfU09DX09WRVJPCiAJaGVscAogCSAgU2F5IFkgaWYgeW91IHdhbnQgdG8gYWRk
IHN1cHBvcnQgZm9yIFNvQyBhdWRpbyBvbiB0aGUgR3Vtc3RpeCBPdmVyby4KIAorY29uZmlnIFNO
RF9PTUFQX1NPQ19PTUFQMkVWTQorCXRyaXN0YXRlICJTb0MgQXVkaW8gc3VwcG9ydCBmb3IgT01B
UDJFVk0gYm9hcmQiCisJZGVwZW5kcyBvbiBTTkRfT01BUF9TT0MgJiYgTUFDSF9PTUFQMkVWTQor
CXNlbGVjdCBTTkRfT01BUF9TT0NfTUNCU1AKKwlzZWxlY3QgU05EX1NPQ19UV0w0MDMwCisJaGVs
cAorCSAgU2F5IFkgaWYgeW91IHdhbnQgdG8gYWRkIHN1cHBvcnQgZm9yIFNvQyBhdWRpbyBvbiB0
aGUgb21hcDJldm0gYm9hcmQuCisKKwogCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvb21hcC9NYWtl
ZmlsZSBiL3NvdW5kL3NvYy9vbWFwL01ha2VmaWxlCmluZGV4IGZlZmM5YmUuLmY1ZGEzY2MgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3NvYy9vbWFwL01ha2VmaWxlCisrKyBiL3NvdW5kL3NvYy9vbWFwL01h
a2VmaWxlCkBAIC05LDggKzksMTAgQEAgb2JqLSQoQ09ORklHX1NORF9PTUFQX1NPQ19NQ0JTUCkg
Kz0gc25kLXNvYy1vbWFwLW1jYnNwLm8KIHNuZC1zb2MtbjgxMC1vYmpzIDo9IG44MTAubwogc25k
LXNvYy1vc2s1OTEyLW9ianMgOj0gb3NrNTkxMi5vCiBzbmQtc29jLW92ZXJvLW9ianMgOj0gb3Zl
cm8ubworc25kLXNvYy1vbWFwMmV2bS1vYmpzIDo9IG9tYXAyZXZtLm8KIAogb2JqLSQoQ09ORklH
X1NORF9PTUFQX1NPQ19OODEwKSArPSBzbmQtc29jLW44MTAubwogb2JqLSQoQ09ORklHX1NORF9P
TUFQX1NPQ19PU0s1OTEyKSArPSBzbmQtc29jLW9zazU5MTIubwogb2JqLSQoQ09ORklHX1NORF9P
TUFQX1NPQ19PVkVSTykgKz0gc25kLXNvYy1vdmVyby5vCitvYmotJChDT05GSUdfTUFDSF9PTUFQ
MkVWTSkgKz0gc25kLXNvYy1vbWFwMmV2bS5vCiAKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9vbWFw
L29tYXAyZXZtLmMgYi9zb3VuZC9zb2Mvb21hcC9vbWFwMmV2bS5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLmMzNzYyMTMKLS0tIC9kZXYvbnVsbAorKysgYi9zb3VuZC9zb2Mv
b21hcC9vbWFwMmV2bS5jCkBAIC0wLDAgKzEsMTUwIEBACisvKgorICogb21hcDJldm0uYyAgLS0g
IFNvQyBhdWRpbyBtYWNoaW5lIGRyaXZlciBmb3Igb21hcDJldm0gYm9hcmQKKyAqCisgKiBBdXRo
b3I6IEFydW4gS1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4KKyAqCisgKiBCYXNlZCBv
biBzb3VuZC9zb2Mvb21hcC9vdmVyby5jIGJ5IFN0ZXZlIFNha29tYW4KKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisg
KiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZQorICogdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCisgKiBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZl
IHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIGFs
b25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJl
CisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGggRmxvb3IsIEJvc3Rv
biwgTUEKKyAqIDAyMTEwLTEzMDEgVVNBCisgKgorICovCisKKyNpbmNsdWRlIDxsaW51eC9jbGsu
aD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxzb3VuZC9j
b3JlLmg+CisjaW5jbHVkZSA8c291bmQvcGNtLmg+CisjaW5jbHVkZSA8c291bmQvc29jLmg+Cisj
aW5jbHVkZSA8c291bmQvc29jLWRhcG0uaD4KKworI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+
CisjaW5jbHVkZSA8bWFjaC9oYXJkd2FyZS5oPgorI2luY2x1ZGUgPG1hY2gvZ3Bpby5oPgorI2lu
Y2x1ZGUgPG1hY2gvbWNic3AuaD4KKworI2luY2x1ZGUgIm9tYXAtbWNic3AuaCIKKyNpbmNsdWRl
ICJvbWFwLXBjbS5oIgorI2luY2x1ZGUgIi4uL2NvZGVjcy90d2w0MDMwLmgiCisKK3N0YXRpYyBp
bnQgb21hcDJldm1faHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFt
LAorCXN0cnVjdCBzbmRfcGNtX2h3X3BhcmFtcyAqcGFyYW1zKQoreworCXN0cnVjdCBzbmRfc29j
X3BjbV9ydW50aW1lICpydGQgPSBzdWJzdHJlYW0tPnByaXZhdGVfZGF0YTsKKwlzdHJ1Y3Qgc25k
X3NvY19kYWkgKmNvZGVjX2RhaSA9IHJ0ZC0+ZGFpLT5jb2RlY19kYWk7CisJc3RydWN0IHNuZF9z
b2NfZGFpICpjcHVfZGFpID0gcnRkLT5kYWktPmNwdV9kYWk7CisJaW50IHJldDsKKworCS8qIFNl
dCBjb2RlYyBEQUkgY29uZmlndXJhdGlvbiAqLworCXJldCA9IHNuZF9zb2NfZGFpX3NldF9mbXQo
Y29kZWNfZGFpLAorCQkJCSAgU05EX1NPQ19EQUlGTVRfSTJTIHwKKwkJCQkgIFNORF9TT0NfREFJ
Rk1UX05CX05GIHwKKwkJCQkgIFNORF9TT0NfREFJRk1UX0NCTV9DRk0pOworCWlmIChyZXQgPCAw
KSB7CisJCXByaW50ayhLRVJOX0VSUiAiY2FuJ3Qgc2V0IGNvZGVjIERBSSBjb25maWd1cmF0aW9u
XG4iKTsKKwkJcmV0dXJuIHJldDsKKwl9CisKKwkvKiBTZXQgY3B1IERBSSBjb25maWd1cmF0aW9u
ICovCisJcmV0ID0gc25kX3NvY19kYWlfc2V0X2ZtdChjcHVfZGFpLAorCQkJCSAgU05EX1NPQ19E
QUlGTVRfSTJTIHwKKwkJCQkgIFNORF9TT0NfREFJRk1UX05CX05GIHwKKwkJCQkgIFNORF9TT0Nf
REFJRk1UX0NCTV9DRk0pOworCWlmIChyZXQgPCAwKSB7CisJCXByaW50ayhLRVJOX0VSUiAiY2Fu
J3Qgc2V0IGNwdSBEQUkgY29uZmlndXJhdGlvblxuIik7CisJCXJldHVybiByZXQ7CisJfQorCisJ
LyogU2V0IHRoZSBjb2RlYyBzeXN0ZW0gY2xvY2sgZm9yIERBQyBhbmQgQURDICovCisJcmV0ID0g
c25kX3NvY19kYWlfc2V0X3N5c2Nsayhjb2RlY19kYWksIDAsIDI2MDAwMDAwLAorCQkJCQkgICAg
U05EX1NPQ19DTE9DS19JTik7CisJaWYgKHJldCA8IDApIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJj
YW4ndCBzZXQgY29kZWMgc3lzdGVtIGNsb2NrXG4iKTsKKwkJcmV0dXJuIHJldDsKKwl9CisKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBzbmRfc29jX29wcyBvbWFwMmV2bV9vcHMgPSB7
CisJLmh3X3BhcmFtcyA9IG9tYXAyZXZtX2h3X3BhcmFtcywKK307CisKKy8qIERpZ2l0YWwgYXVk
aW8gaW50ZXJmYWNlIGdsdWUgLSBjb25uZWN0cyBjb2RlYyA8LS0+IENQVSAqLworc3RhdGljIHN0
cnVjdCBzbmRfc29jX2RhaV9saW5rIG9tYXAyZXZtX2RhaSA9IHsKKwkubmFtZSA9ICJUV0w0MDMw
IiwKKwkuc3RyZWFtX25hbWUgPSAiVFdMNDAzMCIsCisJLmNwdV9kYWkgPSAmb21hcF9tY2JzcF9k
YWlbMF0sCisJLmNvZGVjX2RhaSA9ICZ0d2w0MDMwX2RhaSwKKwkub3BzID0gJm9tYXAyZXZtX29w
cywKK307CisKKy8qIEF1ZGlvIG1hY2hpbmUgZHJpdmVyICovCitzdGF0aWMgc3RydWN0IHNuZF9z
b2NfbWFjaGluZSBzbmRfc29jX21hY2hpbmVfb21hcDJldm0gPSB7CisJLm5hbWUgPSAib21hcDJl
dm0iLAorCS5kYWlfbGluayA9ICZvbWFwMmV2bV9kYWksCisJLm51bV9saW5rcyA9IDEsCit9Owor
CisvKiBBdWRpbyBzdWJzeXN0ZW0gKi8KK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kZXZpY2Ugb21h
cDJldm1fc25kX2RldmRhdGEgPSB7CisJLm1hY2hpbmUgPSAmc25kX3NvY19tYWNoaW5lX29tYXAy
ZXZtLAorCS5wbGF0Zm9ybSA9ICZvbWFwX3NvY19wbGF0Zm9ybSwKKwkuY29kZWNfZGV2ID0gJnNv
Y19jb2RlY19kZXZfdHdsNDAzMCwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpvbWFwMmV2bV9zbmRfZGV2aWNlOworCitzdGF0aWMgaW50IF9faW5pdCBvbWFwMmV2bV9zb2Nf
aW5pdCh2b2lkKQoreworCWludCByZXQ7CisKKwlpZiAoIW1hY2hpbmVfaXNfb21hcDJldm0oKSkg
eworCQlwcl9kZWJ1ZygiTm90IG9tYXAyZXZtIVxuIik7CisJCXJldHVybiAtRU5PREVWOworCX0K
KwlwcmludGsoS0VSTl9JTkZPICJvbWFwMmV2bSBTb0MgaW5pdFxuIik7CisKKwlvbWFwMmV2bV9z
bmRfZGV2aWNlID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJzb2MtYXVkaW8iLCAtMSk7CisJaWYg
KCFvbWFwMmV2bV9zbmRfZGV2aWNlKSB7CisJCXByaW50ayhLRVJOX0VSUiAiUGxhdGZvcm0gZGV2
aWNlIGFsbG9jYXRpb24gZmFpbGVkXG4iKTsKKwkJcmV0dXJuIC1FTk9NRU07CisJfQorCisJcGxh
dGZvcm1fc2V0X2RydmRhdGEob21hcDJldm1fc25kX2RldmljZSwgJm9tYXAyZXZtX3NuZF9kZXZk
YXRhKTsKKwlvbWFwMmV2bV9zbmRfZGV2ZGF0YS5kZXYgPSAmb21hcDJldm1fc25kX2RldmljZS0+
ZGV2OworCSoodW5zaWduZWQgaW50ICopb21hcDJldm1fZGFpLmNwdV9kYWktPnByaXZhdGVfZGF0
YSA9IDE7IC8qIE1jQlNQMiAqLworCisJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX2FkZChvbWFwMmV2
bV9zbmRfZGV2aWNlKTsKKwlpZiAocmV0KQorCQlnb3RvIGVycjE7CisKKwlyZXR1cm4gMDsKKwor
ZXJyMToKKwlwcmludGsoS0VSTl9FUlIgIlVuYWJsZSB0byBhZGQgcGxhdGZvcm0gZGV2aWNlXG4i
KTsKKwlwbGF0Zm9ybV9kZXZpY2VfcHV0KG9tYXAyZXZtX3NuZF9kZXZpY2UpOworCisJcmV0dXJu
IHJldDsKK30KK21vZHVsZV9pbml0KG9tYXAyZXZtX3NvY19pbml0KTsKKworc3RhdGljIHZvaWQg
X19leGl0IG9tYXAyZXZtX3NvY19leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZGV2aWNlX3VucmVn
aXN0ZXIob21hcDJldm1fc25kX2RldmljZSk7Cit9Cittb2R1bGVfZXhpdChvbWFwMmV2bV9zb2Nf
ZXhpdCk7CisKK01PRFVMRV9BVVRIT1IoIkFydW4gS1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25z
LmNvbT4iKTsKK01PRFVMRV9ERVNDUklQVElPTigiQUxTQSBTb0Mgb21hcDJldm0iKTsKK01PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKLS0gCjEuNS42LjMKCg==
------=_Part_72484_6417505.1227096919074
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_72484_6417505.1227096919074--
