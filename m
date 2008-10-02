From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 2/5 v2] Adds ASOC Support for osk5912
Date: Thu, 2 Oct 2008 15:02:45 +0530
Message-ID: <dfeb90390810020232n176b2862y67b5a0ff9cc9f33b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68191_32951389.1222939965554"
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
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, troy.kisky@boundarydevices.com
List-Id: linux-omap@vger.kernel.org

------=_Part_68191_32951389.1222939965554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adding ASOC machine driver for osk5912

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/Kconfig   |    8 ++
 sound/soc/omap/Makefile  |    2 +
 sound/soc/omap/osk5912.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/osk5912.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index aea27e7..8b7766b 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -13,3 +13,11 @@ config SND_OMAP_SOC_N810
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
+
+config SND_OMAP_SOC_OSK5912
+	tristate "SoC Audio support for omap osk5912"
+	depends on SND_OMAP_SOC && MACH_OMAP_OSK
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TLV320AIC23
+	help
+	  Say Y if you want to add support for SoC audio on osk5912.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index d8d8d58..e09d1f2 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o

 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-osk5912-objs := osk5912.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
new file mode 100644
index 0000000..0fe7337
--- /dev/null
+++ b/sound/soc/omap/osk5912.c
@@ -0,0 +1,232 @@
+/*
+ * osk5912.c  --  SoC audio for OSK 5912
+ *
+ * Copyright (C) 2008 Mistral Solutions
+ *
+ * Contact: Arun KS  <arunks@mistralsolutions.com>
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
+#include <linux/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/tlv320aic23.h"
+
+#define CODEC_CLOCK 	12000000
+
+static struct clk *tlv320aic23_mclk;
+
+static int osk_startup(struct snd_pcm_substream *substream)
+{
+	return clk_enable(tlv320aic23_mclk);
+}
+
+static void osk_shutdown(struct snd_pcm_substream *substream)
+{
+	clk_disable(tlv320aic23_mclk);
+}
+
+static int osk_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	/* Set codec DAI configuration */
+	err = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return err;
+	}
+
+	/* Set cpu DAI configuration */
+	err = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return err;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	err =
+	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
+
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return err;
+	}
+
+	return err;
+}
+
+static struct snd_soc_ops osk_ops = {
+	.startup = osk_startup,
+	.hw_params = osk_hw_params,
+	.shutdown = osk_shutdown,
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+
+static int osk_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+
+	/* Add osk5912 specific widgets */
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	/* Set up osk5912 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link osk_dai = {
+	.name = "TLV320AIC23",
+	.stream_name = "AIC23",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &tlv320aic23_dai,
+	.init = osk_tlv320aic23_init,
+	.ops = &osk_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_osk = {
+	.name = "OSK5912",
+	.dai_link = &osk_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device osk_snd_devdata = {
+	.machine = &snd_soc_machine_osk,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_tlv320aic23,
+};
+
+static struct platform_device *osk_snd_device;
+
+static int __init osk_soc_init(void)
+{
+	int err;
+	u32 curRate;
+	struct device *dev;
+
+	if (!(machine_is_omap_osk()))
+		return -ENODEV;
+
+	osk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!osk_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(osk_snd_device, &osk_snd_devdata);
+	osk_snd_devdata.dev = &osk_snd_device->dev;
+	*(unsigned int *)osk_dai.cpu_dai->private_data = 0;	/* McBSP1 */
+	err = platform_device_add(osk_snd_device);
+	if (err)
+		goto err1;
+
+	dev = &osk_snd_device->dev;
+
+	tlv320aic23_mclk = clk_get(dev, "mclk");
+	if (IS_ERR(tlv320aic23_mclk)) {
+		printk(KERN_ERR "Could not get mclk clock\n");
+		return -ENODEV;
+	}
+
+	if (clk_get_usecount(tlv320aic23_mclk) > 0) {
+		/* MCLK is already in use */
+		printk(KERN_WARNING
+		       "MCLK in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK);
+	}
+
+	/*
+	 * Configure 12 MHz output on MCLK.
+	 */
+	curRate = (uint) clk_get_rate(tlv320aic23_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(tlv320aic23_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR "Cannot set MCLK for AIC23 CODEC\n");
+			err = -ECANCELED;
+			goto err1;
+		}
+	}
+
+	printk(KERN_INFO "MCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK,
+	       clk_get_usecount(tlv320aic23_mclk));
+
+	return 0;
+err1:
+	clk_put(tlv320aic23_mclk);
+	platform_device_del(osk_snd_device);
+	platform_device_put(osk_snd_device);
+
+	return err;
+
+}
+
+static void __exit osk_soc_exit(void)
+{
+	platform_device_unregister(osk_snd_device);
+}
+
+module_init(osk_soc_init);
+module_exit(osk_soc_exit);
+
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_DESCRIPTION("ALSA SoC OSK 5912");
+MODULE_LICENSE("GPL");
-- 
1.5.3.4

------=_Part_68191_32951389.1222939965554
Content-Type: text/x-patch; name=0002-Adds-ASOC-Support-for-osk5912.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flt6uyl90
Content-Disposition: attachment;
 filename=0002-Adds-ASOC-Support-for-osk5912.patch

RnJvbSBiOTMyMjRkYjcyYTQ2OGIzMjRiZTVmZmY2NWIwMWVlMzJiZjk4NWNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFdlZCwgMSBPY3QgMjAwOCAyMzoyMzozOSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFk
ZHMgQVNPQyBTdXBwb3J0IGZvciBvc2s1OTEyCgpBZGRpbmcgQVNPQyBtYWNoaW5lIGRyaXZlciBm
b3Igb3NrNTkxMgoKU2lnbmVkLW9mZi1ieTogQXJ1biBLUyA8YXJ1bmtzQG1pc3RyYWxzb2x1dGlv
bnMuY29tPgotLS0KIHNvdW5kL3NvYy9vbWFwL0tjb25maWcgICB8ICAgIDggKysKIHNvdW5kL3Nv
Yy9vbWFwL01ha2VmaWxlICB8ICAgIDIgKwogc291bmQvc29jL29tYXAvb3NrNTkxMi5jIHwgIDIz
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVz
IGNoYW5nZWQsIDI0MiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHNvdW5kL3NvYy9vbWFwL29zazU5MTIuYwoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9v
bWFwL0tjb25maWcgYi9zb3VuZC9zb2Mvb21hcC9LY29uZmlnCmluZGV4IGFlYTI3ZTcuLjhiNzc2
NmIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9vbWFwL0tjb25maWcKKysrIGIvc291bmQvc29jL29t
YXAvS2NvbmZpZwpAQCAtMTMsMyArMTMsMTEgQEAgY29uZmlnIFNORF9PTUFQX1NPQ19OODEwCiAJ
c2VsZWN0IFNORF9TT0NfVExWMzIwQUlDM1gKIAloZWxwCiAJICBTYXkgWSBpZiB5b3Ugd2FudCB0
byBhZGQgc3VwcG9ydCBmb3IgU29DIGF1ZGlvIG9uIE5va2lhIE44MTAuCisKK2NvbmZpZyBTTkRf
T01BUF9TT0NfT1NLNTkxMgorCXRyaXN0YXRlICJTb0MgQXVkaW8gc3VwcG9ydCBmb3Igb21hcCBv
c2s1OTEyIgorCWRlcGVuZHMgb24gU05EX09NQVBfU09DICYmIE1BQ0hfT01BUF9PU0sKKwlzZWxl
Y3QgU05EX09NQVBfU09DX01DQlNQCisJc2VsZWN0IFNORF9TT0NfVExWMzIwQUlDMjMKKwloZWxw
CisJICBTYXkgWSBpZiB5b3Ugd2FudCB0byBhZGQgc3VwcG9ydCBmb3IgU29DIGF1ZGlvIG9uIG9z
azU5MTIuCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvb21hcC9NYWtlZmlsZSBiL3NvdW5kL3NvYy9v
bWFwL01ha2VmaWxlCmluZGV4IGQ4ZDhkNTguLmUwOWQxZjIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9vbWFwL01ha2VmaWxlCisrKyBiL3NvdW5kL3NvYy9vbWFwL01ha2VmaWxlCkBAIC03LDUgKzcs
NyBAQCBvYmotJChDT05GSUdfU05EX09NQVBfU09DX01DQlNQKSArPSBzbmQtc29jLW9tYXAtbWNi
c3AubwogCiAjIE9NQVAgTWFjaGluZSBTdXBwb3J0CiBzbmQtc29jLW44MTAtb2JqcyA6PSBuODEw
Lm8KK3NuZC1zb2Mtb3NrNTkxMi1vYmpzIDo9IG9zazU5MTIubwogCiBvYmotJChDT05GSUdfU05E
X09NQVBfU09DX044MTApICs9IHNuZC1zb2MtbjgxMC5vCitvYmotJChDT05GSUdfU05EX09NQVBf
U09DX09TSzU5MTIpICs9IHNuZC1zb2Mtb3NrNTkxMi5vCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
b21hcC9vc2s1OTEyLmMgYi9zb3VuZC9zb2Mvb21hcC9vc2s1OTEyLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uMGZlNzMzNwotLS0gL2Rldi9udWxsCisrKyBiL3NvdW5kL3Nv
Yy9vbWFwL29zazU5MTIuYwpAQCAtMCwwICsxLDIzMiBAQAorLyoKKyAqIG9zazU5MTIuYyAgLS0g
IFNvQyBhdWRpbyBmb3IgT1NLIDU5MTIKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDggTWlzdHJh
bCBTb2x1dGlvbnMKKyAqCisgKiBDb250YWN0OiBBcnVuIEtTICA8YXJ1bmtzQG1pc3RyYWxzb2x1
dGlvbnMuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiB2ZXJzaW9uIDIgYXMgcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dAorICog
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
ZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LiAgU2VlIHRoZSBHTlUKKyAqIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWls
cy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwg
d3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5r
bGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQQorICogMDIxMTAtMTMwMSBVU0EKKyAqCisg
Ki8KKworI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rl
dmljZS5oPgorI2luY2x1ZGUgPHNvdW5kL2NvcmUuaD4KKyNpbmNsdWRlIDxzb3VuZC9wY20uaD4K
KyNpbmNsdWRlIDxzb3VuZC9zb2MuaD4KKyNpbmNsdWRlIDxzb3VuZC9zb2MtZGFwbS5oPgorCisj
aW5jbHVkZSA8YXNtL21hY2gtdHlwZXMuaD4KKyNpbmNsdWRlIDxtYWNoL2hhcmR3YXJlLmg+Cisj
aW5jbHVkZSA8bGludXgvZ3Bpby5oPgorI2luY2x1ZGUgPG1hY2gvbWNic3AuaD4KKworI2luY2x1
ZGUgIm9tYXAtbWNic3AuaCIKKyNpbmNsdWRlICJvbWFwLXBjbS5oIgorI2luY2x1ZGUgIi4uL2Nv
ZGVjcy90bHYzMjBhaWMyMy5oIgorCisjZGVmaW5lIENPREVDX0NMT0NLIAkxMjAwMDAwMAorCitz
dGF0aWMgc3RydWN0IGNsayAqdGx2MzIwYWljMjNfbWNsazsKKworc3RhdGljIGludCBvc2tfc3Rh
cnR1cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKK3sKKwlyZXR1cm4gY2xr
X2VuYWJsZSh0bHYzMjBhaWMyM19tY2xrKTsKK30KKworc3RhdGljIHZvaWQgb3NrX3NodXRkb3du
KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQoreworCWNsa19kaXNhYmxlKHRs
djMyMGFpYzIzX21jbGspOworfQorCitzdGF0aWMgaW50IG9za19od19wYXJhbXMoc3RydWN0IHNu
ZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCisJCQkgc3RydWN0IHNuZF9wY21faHdfcGFyYW1z
ICpwYXJhbXMpCit7CisJc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVh
bS0+cHJpdmF0ZV9kYXRhOworCXN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpID0gcnRkLT5k
YWktPmNvZGVjX2RhaTsKKwlzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWkgPSBydGQtPmRhaS0+
Y3B1X2RhaTsKKwlpbnQgZXJyOworCisJLyogU2V0IGNvZGVjIERBSSBjb25maWd1cmF0aW9uICov
CisJZXJyID0gc25kX3NvY19kYWlfc2V0X2ZtdChjb2RlY19kYWksCisJCQkJICBTTkRfU09DX0RB
SUZNVF9EU1BfQSB8CisJCQkJICBTTkRfU09DX0RBSUZNVF9OQl9JRiB8CisJCQkJICBTTkRfU09D
X0RBSUZNVF9DQk1fQ0ZNKTsKKwlpZiAoZXJyIDwgMCkgeworCQlwcmludGsoS0VSTl9FUlIgImNh
bid0IHNldCBjb2RlYyBEQUkgY29uZmlndXJhdGlvblxuIik7CisJCXJldHVybiBlcnI7CisJfQor
CisJLyogU2V0IGNwdSBEQUkgY29uZmlndXJhdGlvbiAqLworCWVyciA9IHNuZF9zb2NfZGFpX3Nl
dF9mbXQoY3B1X2RhaSwKKwkJCQkgIFNORF9TT0NfREFJRk1UX0RTUF9BIHwKKwkJCQkgIFNORF9T
T0NfREFJRk1UX05CX0lGIHwKKwkJCQkgIFNORF9TT0NfREFJRk1UX0NCTV9DRk0pOworCWlmIChl
cnIgPCAwKSB7CisJCXByaW50ayhLRVJOX0VSUiAiY2FuJ3Qgc2V0IGNwdSBEQUkgY29uZmlndXJh
dGlvblxuIik7CisJCXJldHVybiBlcnI7CisJfQorCisJLyogU2V0IHRoZSBjb2RlYyBzeXN0ZW0g
Y2xvY2sgZm9yIERBQyBhbmQgQURDICovCisJZXJyID0KKwkgICAgc25kX3NvY19kYWlfc2V0X3N5
c2Nsayhjb2RlY19kYWksIDAsIENPREVDX0NMT0NLLCBTTkRfU09DX0NMT0NLX0lOKTsKKworCWlm
IChlcnIgPCAwKSB7CisJCXByaW50ayhLRVJOX0VSUiAiY2FuJ3Qgc2V0IGNvZGVjIHN5c3RlbSBj
bG9ja1xuIik7CisJCXJldHVybiBlcnI7CisJfQorCisJcmV0dXJuIGVycjsKK30KKworc3RhdGlj
IHN0cnVjdCBzbmRfc29jX29wcyBvc2tfb3BzID0geworCS5zdGFydHVwID0gb3NrX3N0YXJ0dXAs
CisJLmh3X3BhcmFtcyA9IG9za19od19wYXJhbXMsCisJLnNodXRkb3duID0gb3NrX3NodXRkb3du
LAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0IHRsdjMyMGFp
YzIzX2RhcG1fd2lkZ2V0c1tdID0geworCVNORF9TT0NfREFQTV9IUCgiSGVhZHBob25lIEphY2si
LCBOVUxMKSwKKwlTTkRfU09DX0RBUE1fTElORSgiTGluZSBJbiIsIE5VTEwpLAorCVNORF9TT0Nf
REFQTV9NSUMoIk1pYyBKYWNrIiwgTlVMTCksCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNu
ZF9zb2NfZGFwbV9yb3V0ZSBhdWRpb19tYXBbXSA9IHsKKwl7IkhlYWRwaG9uZSBKYWNrIiwgTlVM
TCwgIkxIUE9VVCJ9LAorCXsiSGVhZHBob25lIEphY2siLCBOVUxMLCAiUkhQT1VUIn0sCisKKwl7
IkxMSU5FSU4iLCBOVUxMLCAiTGluZSBJbiJ9LAorCXsiUkxJTkVJTiIsIE5VTEwsICJMaW5lIElu
In0sCisKKwl7Ik1JQ0lOIiwgTlVMTCwgIk1pYyBKYWNrIn0sCit9OworCitzdGF0aWMgaW50IG9z
a190bHYzMjBhaWMyM19pbml0KHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKK3sKKworCS8q
IEFkZCBvc2s1OTEyIHNwZWNpZmljIHdpZGdldHMgKi8KKwlzbmRfc29jX2RhcG1fbmV3X2NvbnRy
b2xzKGNvZGVjLCB0bHYzMjBhaWMyM19kYXBtX3dpZGdldHMsCisJCQkJICBBUlJBWV9TSVpFKHRs
djMyMGFpYzIzX2RhcG1fd2lkZ2V0cykpOworCisJLyogU2V0IHVwIG9zazU5MTIgc3BlY2lmaWMg
YXVkaW8gcGF0aCBhdWRpb19tYXAgKi8KKwlzbmRfc29jX2RhcG1fYWRkX3JvdXRlcyhjb2RlYywg
YXVkaW9fbWFwLCBBUlJBWV9TSVpFKGF1ZGlvX21hcCkpOworCisJc25kX3NvY19kYXBtX2VuYWJs
ZV9waW4oY29kZWMsICJIZWFkcGhvbmUgSmFjayIpOworCXNuZF9zb2NfZGFwbV9lbmFibGVfcGlu
KGNvZGVjLCAiTGluZSBJbiIpOworCXNuZF9zb2NfZGFwbV9lbmFibGVfcGluKGNvZGVjLCAiTWlj
IEphY2siKTsKKworCXNuZF9zb2NfZGFwbV9zeW5jKGNvZGVjKTsKKworCXJldHVybiAwOworfQor
CisvKiBEaWdpdGFsIGF1ZGlvIGludGVyZmFjZSBnbHVlIC0gY29ubmVjdHMgY29kZWMgPC0tPiBD
UFUgKi8KK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBvc2tfZGFpID0geworCS5uYW1l
ID0gIlRMVjMyMEFJQzIzIiwKKwkuc3RyZWFtX25hbWUgPSAiQUlDMjMiLAorCS5jcHVfZGFpID0g
Jm9tYXBfbWNic3BfZGFpWzBdLAorCS5jb2RlY19kYWkgPSAmdGx2MzIwYWljMjNfZGFpLAorCS5p
bml0ID0gb3NrX3RsdjMyMGFpYzIzX2luaXQsCisJLm9wcyA9ICZvc2tfb3BzLAorfTsKKworLyog
QXVkaW8gbWFjaGluZSBkcml2ZXIgKi8KK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19tYWNoaW5lIHNu
ZF9zb2NfbWFjaGluZV9vc2sgPSB7CisJLm5hbWUgPSAiT1NLNTkxMiIsCisJLmRhaV9saW5rID0g
Jm9za19kYWksCisJLm51bV9saW5rcyA9IDEsCit9OworCisvKiBBdWRpbyBzdWJzeXN0ZW0gKi8K
K3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kZXZpY2Ugb3NrX3NuZF9kZXZkYXRhID0geworCS5tYWNo
aW5lID0gJnNuZF9zb2NfbWFjaGluZV9vc2ssCisJLnBsYXRmb3JtID0gJm9tYXBfc29jX3BsYXRm
b3JtLAorCS5jb2RlY19kZXYgPSAmc29jX2NvZGVjX2Rldl90bHYzMjBhaWMyMywKK307CisKK3N0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvc2tfc25kX2RldmljZTsKKworc3RhdGljIGlu
dCBfX2luaXQgb3NrX3NvY19pbml0KHZvaWQpCit7CisJaW50IGVycjsKKwl1MzIgY3VyUmF0ZTsK
KwlzdHJ1Y3QgZGV2aWNlICpkZXY7CisKKwlpZiAoIShtYWNoaW5lX2lzX29tYXBfb3NrKCkpKQor
CQlyZXR1cm4gLUVOT0RFVjsKKworCW9za19zbmRfZGV2aWNlID0gcGxhdGZvcm1fZGV2aWNlX2Fs
bG9jKCJzb2MtYXVkaW8iLCAtMSk7CisJaWYgKCFvc2tfc25kX2RldmljZSkKKwkJcmV0dXJuIC1F
Tk9NRU07CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShvc2tfc25kX2RldmljZSwgJm9za19zbmRf
ZGV2ZGF0YSk7CisJb3NrX3NuZF9kZXZkYXRhLmRldiA9ICZvc2tfc25kX2RldmljZS0+ZGV2Owor
CSoodW5zaWduZWQgaW50ICopb3NrX2RhaS5jcHVfZGFpLT5wcml2YXRlX2RhdGEgPSAwOwkvKiBN
Y0JTUDEgKi8KKwllcnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKG9za19zbmRfZGV2aWNlKTsKKwlp
ZiAoZXJyKQorCQlnb3RvIGVycjE7CisKKwlkZXYgPSAmb3NrX3NuZF9kZXZpY2UtPmRldjsKKwor
CXRsdjMyMGFpYzIzX21jbGsgPSBjbGtfZ2V0KGRldiwgIm1jbGsiKTsKKwlpZiAoSVNfRVJSKHRs
djMyMGFpYzIzX21jbGspKSB7CisJCXByaW50ayhLRVJOX0VSUiAiQ291bGQgbm90IGdldCBtY2xr
IGNsb2NrXG4iKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJaWYgKGNsa19nZXRfdXNlY291
bnQodGx2MzIwYWljMjNfbWNsaykgPiAwKSB7CisJCS8qIE1DTEsgaXMgYWxyZWFkeSBpbiB1c2Ug
Ki8KKwkJcHJpbnRrKEtFUk5fV0FSTklORworCQkgICAgICAgIk1DTEsgaW4gdXNlIGF0ICVkIEh6
LiBXZSBjaGFuZ2UgaXQgdG8gJWQgSHpcbiIsCisJCSAgICAgICAodWludCkgY2xrX2dldF9yYXRl
KHRsdjMyMGFpYzIzX21jbGspLCBDT0RFQ19DTE9DSyk7CisJfQorCisJLyoKKwkgKiBDb25maWd1
cmUgMTIgTUh6IG91dHB1dCBvbiBNQ0xLLgorCSAqLworCWN1clJhdGUgPSAodWludCkgY2xrX2dl
dF9yYXRlKHRsdjMyMGFpYzIzX21jbGspOworCWlmIChjdXJSYXRlICE9IENPREVDX0NMT0NLKSB7
CisJCWlmIChjbGtfc2V0X3JhdGUodGx2MzIwYWljMjNfbWNsaywgQ09ERUNfQ0xPQ0spKSB7CisJ
CQlwcmludGsoS0VSTl9FUlIgIkNhbm5vdCBzZXQgTUNMSyBmb3IgQUlDMjMgQ09ERUNcbiIpOwor
CQkJZXJyID0gLUVDQU5DRUxFRDsKKwkJCWdvdG8gZXJyMTsKKwkJfQorCX0KKworCXByaW50ayhL
RVJOX0lORk8gIk1DTEsgPSAlZCBbJWRdLCB1c2Vjb3VudCA9ICVkXG4iLAorCSAgICAgICAodWlu
dCkgY2xrX2dldF9yYXRlKHRsdjMyMGFpYzIzX21jbGspLCBDT0RFQ19DTE9DSywKKwkgICAgICAg
Y2xrX2dldF91c2Vjb3VudCh0bHYzMjBhaWMyM19tY2xrKSk7CisKKwlyZXR1cm4gMDsKK2VycjE6
CisJY2xrX3B1dCh0bHYzMjBhaWMyM19tY2xrKTsKKwlwbGF0Zm9ybV9kZXZpY2VfZGVsKG9za19z
bmRfZGV2aWNlKTsKKwlwbGF0Zm9ybV9kZXZpY2VfcHV0KG9za19zbmRfZGV2aWNlKTsKKworCXJl
dHVybiBlcnI7CisKK30KKworc3RhdGljIHZvaWQgX19leGl0IG9za19zb2NfZXhpdCh2b2lkKQor
eworCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG9za19zbmRfZGV2aWNlKTsKK30KKworbW9k
dWxlX2luaXQob3NrX3NvY19pbml0KTsKK21vZHVsZV9leGl0KG9za19zb2NfZXhpdCk7CisKK01P
RFVMRV9BVVRIT1IoIkFydW4gS1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4iKTsKK01P
RFVMRV9ERVNDUklQVElPTigiQUxTQSBTb0MgT1NLIDU5MTIiKTsKK01PRFVMRV9MSUNFTlNFKCJH
UEwiKTsKLS0gCjEuNS4zLjQKCg==
------=_Part_68191_32951389.1222939965554
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_68191_32951389.1222939965554--
