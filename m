From: Joel Porquet <joel@porquet.org>
Subject: [PATCH v2 0/3] arm:irchip: IRQCHIP_DECLARE macro is now accessible
Date: Tue, 13 Oct 2015 14:56:12 +0200
Message-ID: <1444740975-31948-1-git-send-email-joel@porquet.org>
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
To: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, kgene@kernel.org, k.kozlowski@samsung.com, shawnguo@kernel.org, kernel@pengutronix.de, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joel Porquet <joel@porquet.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

VGhlIElSUUNISVBfREVDTEFSRSBtYWNybyBtaWdyYXRlZCB0byAnaW5jbHVkZS9saW51eC9pcnFj
aGlwLmgnLCBtYWtpbmcgaXQKZ2xvYmFsbHkgYWNjZXNzaWJsZS4KClNlZSBjb21taXQgOTFlMjBi
NTA0MGM2N2M1MWFhZDg4Y2Y4N2RiNDMwNWM1YmQ3Zjc5ZCAoImlycWNoaXA6IE1vdmUKSVJRQ0hJ
UF9ERUNMQVJFIG1hY3JvIHRvIGluY2x1ZGUvbGludXgvaXJxY2hpcC5oIikuCgpUaGlzIHNlcmll
cyBvZiBwYXRjaGVzIGFkZCBpbmNsdXNpb25zIG9mICdpbmNsdWRlL2xpbnV4L2lycWNoaXAuaCcg
YW5kCnJlcGxhY2VzIHVzZXMgb2YgbWFjcm8gT0ZfREVDTEFSRV8yIHdpdGggSVJRQ0hJUF9ERUNM
QVJFIGZvciBwbGF0Zm9ybXMKZXh5bm9zLCBpbXggYW5kIG9tYXAyLgoKSSBoYWQgc3VibWl0dGVk
IGEgc2luZ2xlIHBhdGNoIGEgZmV3IG1vbnRocyBhZ28KKGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE1LzcvNy8xMDY5KSwgYnV0IGl0IG5ldmVyIGdvdCBtZXJnZWQgYWx0aG91Z2ggaXQKaGFkIGJl
ZW4gYWNrZWQgYnkgYWxsIHRoZSBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMuIEhvcGVmdWxseSwgc3Bs
aXR0aW5nIHRoZQpwYXRjaCBpbnRvIHRoZXNlIGluZGVwZW5kZW50IHBhdGNoZXMgdGhhdCBjYW4g
YmUgYXBwbGllZCBzZXBhcmF0ZWx5IHNob3VsZApoZWxwLgoKSm/Dq2wKCkpvZWwgUG9ycXVldCAo
Myk6CiAgYXJtOmV4eW5vczogSVJRQ0hJUF9ERUNMQVJFIG1hY3JvIGlzIG5vdyBhY2Nlc3NpYmxl
CiAgYXJtOmlteDogSVJRQ0hJUF9ERUNMQVJFIG1hY3JvIGlzIG5vdyBhY2Nlc3NpYmxlCiAgYXJt
Om9tYXAyOiBJUlFDSElQX0RFQ0xBUkUgbWFjcm8gaXMgbm93IGFjY2Vzc2libGUKCiBhcmNoL2Fy
bS9tYWNoLWV4eW5vcy9zdXNwZW5kLmMgICAgICAgfCAzICsrLQogYXJjaC9hcm0vbWFjaC1pbXgv
Z3BjLmMgICAgICAgICAgICAgIHwgNyArKy0tLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXAt
d2FrZXVwZ2VuLmMgfCA3ICsrLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkKCi0tIAoyLjYuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
