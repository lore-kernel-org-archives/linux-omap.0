From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] dmaengine: edma/omap-dma: max_burst validity checking
Date: Tue, 3 Oct 2017 11:35:36 +0300
Message-ID: <20171003083538.11044-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

77u/SGksCgpDaGFuZ2VzIHNpbmNlIHYxOgotIEZpeGVkIHR5cG8gaW4gY29tbWl0IG1lc3NhZ2UK
LSBTZXBhcmF0ZWQgZnJvbSB0aGUgJ2RtYWVuZ2luZTogY29yZS9lZG1hL29tYXAtZG1hOiBtYXhp
bXVtIFNHIGxlbiByZXBvcnRpbmcnCiAgc2VyaWVzCgpCb3RoIGVETUEgYW5kIHNETUEgaGF2ZSBs
aW1pdCBvbiB0aGUgbWF4aW11bSBidXJzdCBzaXplLiBUaGUgdHdvIHBhdGNoCmltcGxlbWVudHMg
cHJvdGVjdGlvbiBhZ2FpbnN0IHRvbyBiaWcgYnVyc3Qgc2l6ZSBmb3IgYm90aCBkcml2ZXIuCgpS
ZWdhcmRzLApQZXRlcgotLS0KUGV0ZXIgVWpmYWx1c2kgKDIpOgogIGRtYWVuZ2luZTogZWRtYTog
SW1wbGVtZW50IHByb3RlY3Rpb24gZm9yIGludmFsaWQgbWF4X2J1cnN0CiAgZG1hZW5naW5lOiBv
bWFwLWRtYTogSW1wbGVtZW50IHByb3RlY3Rpb24gZm9yIGludmFsaWQgbWF4X2J1cnN0CgogZHJp
dmVycy9kbWEvZWRtYS5jICAgICB8IDUgKysrKysKIGRyaXZlcnMvZG1hL29tYXAtZG1hLmMgfCA1
ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCi0tIAoyLjE0LjIKCgpU
ZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxz
aW5raS4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2ls
ZTogSGVsc2lua2kKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
