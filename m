From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 4/5 v2] ASOC adds destination and source port
	for dma
Date: Thu, 2 Oct 2008 15:05:49 +0530
Message-ID: <dfeb90390810020235v429c35cen3e80abdac41d7cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68205_33257011.1222940149516"
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

------=_Part_68205_33257011.1222940149516
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adds destination and source port for dma in platform driver as
required by OMAP1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-pcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 690bfea..e9084fd 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -97,7 +97,7 @@ static int omap_pcm_hw_params(struct
snd_pcm_substream *substream,
 	prtd->dma_data = dma_data;
 	err = omap_request_dma(dma_data->dma_req, dma_data->name,
 			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
-	if (!cpu_is_omap1510()) {
+	if (!err & !cpu_is_omap1510()) {
 		/*
 		 * Link channel with itself so DMA doesn't need any
 		 * reprogramming while looping the buffer
@@ -147,12 +147,14 @@ static int omap_pcm_prepare(struct
snd_pcm_substream *substream)
 		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
 		dma_params.src_start		= runtime->dma_addr;
 		dma_params.dst_start		= dma_data->port_addr;
+		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
 	} else {
 		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
 		dma_params.src_start		= dma_data->port_addr;
 		dma_params.dst_start		= runtime->dma_addr;
+		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
 	}
 	/*
 	 * Set DMA transfer frame size equal to ALSA period size and frame
-- 
1.5.3.4

------=_Part_68205_33257011.1222940149516
Content-Type: text/x-patch;
 name=0004-ASOC-adds-destination-and-source-port-for-dma.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flt706p80
Content-Disposition: attachment;
 filename=0004-ASOC-adds-destination-and-source-port-for-dma.patch

RnJvbSA5MzFmMjM5NjJhYjUxNmMxZjQ4NTA1YTlkNjUyZTc1M2QwMTA2OTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMzAgU2VwIDIwMDggMTM6MjY6MTggKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
U09DIGFkZHMgZGVzdGluYXRpb24gYW5kIHNvdXJjZSBwb3J0IGZvciBkbWEKCkFkZHMgZGVzdGlu
YXRpb24gYW5kIHNvdXJjZSBwb3J0IGZvciBkbWEgaW4gcGxhdGZvcm0gZHJpdmVyIGFzCnJlcXVp
cmVkIGJ5IE9NQVAxCgpTaWduZWQtb2ZmLWJ5OiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0
aW9ucy5jb20+Ci0tLQogc291bmQvc29jL29tYXAvb21hcC1wY20uYyB8ICAgIDQgKysrLQogMSBm
aWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL29tYXAvb21hcC1wY20uYyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtcGNtLmMK
aW5kZXggNjkwYmZlYS4uZTkwODRmZCAxMDA2NDQKLS0tIGEvc291bmQvc29jL29tYXAvb21hcC1w
Y20uYworKysgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLXBjbS5jCkBAIC05Nyw3ICs5Nyw3IEBAIHN0
YXRpYyBpbnQgb21hcF9wY21faHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtLAogCXBydGQtPmRtYV9kYXRhID0gZG1hX2RhdGE7CiAJZXJyID0gb21hcF9yZXF1ZXN0
X2RtYShkbWFfZGF0YS0+ZG1hX3JlcSwgZG1hX2RhdGEtPm5hbWUsCiAJCQkgICAgICAgb21hcF9w
Y21fZG1hX2lycSwgc3Vic3RyZWFtLCAmcHJ0ZC0+ZG1hX2NoKTsKLQlpZiAoIWNwdV9pc19vbWFw
MTUxMCgpKSB7CisJaWYgKCFlcnIgJiAhY3B1X2lzX29tYXAxNTEwKCkpIHsKIAkJLyoKIAkJICog
TGluayBjaGFubmVsIHdpdGggaXRzZWxmIHNvIERNQSBkb2Vzbid0IG5lZWQgYW55CiAJCSAqIHJl
cHJvZ3JhbW1pbmcgd2hpbGUgbG9vcGluZyB0aGUgYnVmZmVyCkBAIC0xNDcsMTIgKzE0NywxNCBA
QCBzdGF0aWMgaW50IG9tYXBfcGNtX3ByZXBhcmUoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpz
dWJzdHJlYW0pCiAJCWRtYV9wYXJhbXMuc3JjX29yX2RzdF9zeW5jaAk9IE9NQVBfRE1BX0RTVF9T
WU5DOwogCQlkbWFfcGFyYW1zLnNyY19zdGFydAkJPSBydW50aW1lLT5kbWFfYWRkcjsKIAkJZG1h
X3BhcmFtcy5kc3Rfc3RhcnQJCT0gZG1hX2RhdGEtPnBvcnRfYWRkcjsKKwkJZG1hX3BhcmFtcy5k
c3RfcG9ydAkJPSBPTUFQX0RNQV9QT1JUX01QVUk7CiAJfSBlbHNlIHsKIAkJZG1hX3BhcmFtcy5z
cmNfYW1vZGUJCT0gT01BUF9ETUFfQU1PREVfQ09OU1RBTlQ7CiAJCWRtYV9wYXJhbXMuZHN0X2Ft
b2RlCQk9IE9NQVBfRE1BX0FNT0RFX1BPU1RfSU5DOwogCQlkbWFfcGFyYW1zLnNyY19vcl9kc3Rf
c3luY2gJPSBPTUFQX0RNQV9TUkNfU1lOQzsKIAkJZG1hX3BhcmFtcy5zcmNfc3RhcnQJCT0gZG1h
X2RhdGEtPnBvcnRfYWRkcjsKIAkJZG1hX3BhcmFtcy5kc3Rfc3RhcnQJCT0gcnVudGltZS0+ZG1h
X2FkZHI7CisJCWRtYV9wYXJhbXMuc3JjX3BvcnQJCT0gT01BUF9ETUFfUE9SVF9NUFVJOwogCX0K
IAkvKgogCSAqIFNldCBETUEgdHJhbnNmZXIgZnJhbWUgc2l6ZSBlcXVhbCB0byBBTFNBIHBlcmlv
ZCBzaXplIGFuZCBmcmFtZQotLSAKMS41LjMuNAoK
------=_Part_68205_33257011.1222940149516
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_68205_33257011.1222940149516--
