From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: [PATCH] 3430: Make naming consistent in io.h
Date: Wed, 14 Nov 2007 21:02:02 +0200
Message-ID: <52d486620711141102l3b7a3258uc5d832d116288413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4789_6490393.1195066922763"
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

------=_Part_4789_6490393.1195066922763
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Please find a patch attached to make the naming of IO address space
more consistent.

Regards,
Amit

--
Amit Kucheria, Linux developer

------=_Part_4789_6490393.1195066922763
Content-Type: application/octet-stream;
	name=0001-3430-Make-IO-mapping-names-consistent.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f907u1pb
Content-Disposition: attachment;
	filename=0001-3430-Make-IO-mapping-names-consistent.patch

RnJvbSA1NjA3ODAwNGFhNWRhNDgxYmI4M2E4OWNlNmU3YzM5ZjIzMzg1ZjVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVu
dC5jb20+CkRhdGU6IFdlZCwgMyBPY3QgMjAwNyAxNjo1NDozMyArMDMwMApTdWJqZWN0OiBbUEFU
Q0hdIDM0MzA6IE1ha2UgSU8gbWFwcGluZyBuYW1lcyBjb25zaXN0ZW50CgpTaWduZWQtb2ZmLWJ5
OiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb20+Ci0tLQogaW5jbHVk
ZS9hc20tYXJtL2FyY2gtb21hcC9pby5oICAgICAgIHwgICAgMiArLQogaW5jbHVkZS9hc20tYXJt
L2FyY2gtb21hcC9vbWFwMzR4eC5oIHwgICAgNiArKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWFy
bS9hcmNoLW9tYXAvaW8uaCBiL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvaW8uaAppbmRleCA4
M2I5ZTY2Li4xNjA1NzhlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2lv
LmgKKysrIGIvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9pby5oCkBAIC0xMjksNyArMTI5LDcg
QEAKICNkZWZpbmUgTDRfUEVSXzM0WFhfVklSVAkweGQ5MDAwMDAwCiAjZGVmaW5lIEw0X1BFUl8z
NFhYX1NJWkUJU1pfMU0KIAotI2RlZmluZSBMNF9FTVVfMzRYWF9QSFlTCUw0XzM0WFhfRU1VX0JB
U0UgLyogMHg1NDAwMDAwMCAqLworI2RlZmluZSBMNF9FTVVfMzRYWF9QSFlTCUw0X0VNVV8zNFhY
X0JBU0UgLyogMHg1NDAwMDAwMCAqLwogI2RlZmluZSBMNF9FTVVfMzRYWF9WSVJUCTB4ZTQwMDAw
MDAKICNkZWZpbmUgTDRfRU1VXzM0WFhfU0laRQlTWl82NE0KIApkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9hc20tYXJtL2FyY2gtb21hcC9vbWFwMzR4eC5oIGIvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21h
cC9vbWFwMzR4eC5oCmluZGV4IDZiYzdmOGEuLmUyMzA1OGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
YXNtLWFybS9hcmNoLW9tYXAvb21hcDM0eHguaAorKysgYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1v
bWFwL29tYXAzNHh4LmgKQEAgLTMxLDExICszMSwxMSBAQAogCiAjZGVmaW5lIEw0XzM0WFhfQkFT
RQkJMHg0ODAwMDAwMAogI2RlZmluZSBMNF9XS18zNFhYX0JBU0UJCTB4NDgzMDAwMDAKLSNkZWZp
bmUgTDRfV0tfT01BUF9CQVNFCQlMNF9XS19PTUFQX0JBU0UKKyNkZWZpbmUgTDRfV0tfT01BUF9C
QVNFCQlMNF9XS18zNFhYX0JBU0UKICNkZWZpbmUgTDRfUEVSXzM0WFhfQkFTRQkweDQ5MDAwMDAw
CiAjZGVmaW5lIEw0X1BFUl9PTUFQX0JBU0UJTDRfUEVSXzM0WFhfQkFTRQotI2RlZmluZSBMNF8z
NFhYX0VNVV9CQVNFCTB4NTQwMDAwMDAKLSNkZWZpbmUgTDRfRU1VX0JBU0UJCUw0XzM0WFhfRU1V
X0JBU0UKKyNkZWZpbmUgTDRfRU1VXzM0WFhfQkFTRQkweDU0MDAwMDAwCisjZGVmaW5lIEw0X0VN
VV9CQVNFCQlMNF9FTVVfMzRYWF9CQVNFCiAjZGVmaW5lIEwzXzM0WFhfQkFTRQkJMHg2ODAwMDAw
MAogI2RlZmluZSBMM19PTUFQX0JBU0UJCUwzXzM0WFhfQkFTRQogCi0tIAoxLjUuMi5HSVQKCg==

------=_Part_4789_6490393.1195066922763
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_4789_6490393.1195066922763--
