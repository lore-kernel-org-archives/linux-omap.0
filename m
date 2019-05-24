From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 6/7] ARM: dts: am335x-pcm-953: Remove eth phy delay
Date: Fri, 24 May 2019 15:20:02 +0200
Message-ID: <1558704003-393769-7-git-send-email-t.remmet@phytec.de>
References: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Schultz <d.schultz@phytec.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

RGVmYXVsdCB2YWx1ZXMgZml0IGJldHRlciB0aGFuIHRoZXNlIGhpc3RvcmljYWwgc2V0dGluZ3Mu
CkhhcmR3YXJlIGxheW91dCBoYWQgYmVlbiBhZGFwdGVkIGFjY29yZGluZ2x5IGFscmVhZHkgaW4K
YWxwaGEgc3RhZ2UuIFRoZXkgZGlkIG5vdCBjYXVzZSBwcm9ibGVtcyBmb3IgYSBsb25nIHRpbWUu
ClJlbW92ZWQgdmFsdWVzIG5vdy4KClNpZ25lZC1vZmYtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVt
bWV0QHBoeXRlYy5kZT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9hbTMzNXgtcGNtLTk1My5kdHNp
IHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wY20tOTUzLmR0c2kgYi9hcmNo
L2FybS9ib290L2R0cy9hbTMzNXgtcGNtLTk1My5kdHNpCmluZGV4IDcwZmI0YTE1Y2FkOS4uZGQ3
OGRiNzZjODc3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9hbTMzNXgtcGNtLTk1My5k
dHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wY20tOTUzLmR0c2kKQEAgLTEzNiwy
MiArMTM2LDYgQEAKICZkYXZpbmNpX21kaW8gewogCXBoeTE6IGV0aGVybmV0LXBoeUAyIHsKIAkJ
cmVnID0gPDI+OwotCi0JCS8qIFJlZ2lzdGVyIDI2MCAoMTA0aCkg4oCTIFJHTUlJIENsb2NrIGFu
ZCBDb250cm9sIFBhZCBTa2V3ICovCi0JCXJ4Yy1za2V3LXBzID0gPDE0MDA+OwotCQlyeGR2LXNr
ZXctcHMgPSA8MD47Ci0JCXR4Yy1za2V3LXBzID0gPDE0MDA+OwotCQl0eGVuLXNrZXctcHMgPSA8
MD47Ci0JCS8qIFJlZ2lzdGVyIDI2MSAoMTA1aCkg4oCTIFJHTUlJIFJYIERhdGEgUGFkIFNrZXcg
Ki8KLQkJcnhkMy1za2V3LXBzID0gPDA+OwotCQlyeGQyLXNrZXctcHMgPSA8MD47Ci0JCXJ4ZDEt
c2tldy1wcyA9IDwwPjsKLQkJcnhkMC1za2V3LXBzID0gPDA+OwotCQkvKiBSZWdpc3RlciAyNjIg
KDEwNmgpIOKAkyBSR01JSSBUWCBEYXRhIFBhZCBTa2V3ICovCi0JCXR4ZDMtc2tldy1wcyA9IDww
PjsKLQkJdHhkMi1za2V3LXBzID0gPDA+OwotCQl0eGQxLXNrZXctcHMgPSA8MD47Ci0JCXR4ZDAt
c2tldy1wcyA9IDwwPjsKIAl9OwogfTsKIAotLSAKMi43LjQKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
