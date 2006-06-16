From: "Mouhammad Tayseer Alquoatli" <idoit.ief@gmail.com>
Subject: [PATCH] ARM: OMAP: exporting missing symbols for dspgateway module
	for 2.6.16
Date: Fri, 16 Jun 2006 15:35:10 +0300
Message-ID: <d8c9df6c0606160535v6e14edafyc81e446dfec8b8fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9006_5853724.1150461310888"
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

------=_Part_9006_5853724.1150461310888
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all:
there was some missing symbols needed when compiling dsp gateway as a
module, this patch only exports them to the kernel

-- 
Mouhammad Tayseer Alquoatli

------=_Part_9006_5853724.1150461310888
Content-Type: text/x-patch; name=dsp_module.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eoiizb2y
Content-Disposition: attachment; filename="dsp_module.patch"

ZXhwb3J0cyBtaXNzaW5nIHN5bWJvbHM6IGNwdV9hcmNoaXRlY3R1cmUsIHBtZF9jbGVhcl9iYWQg
bmVlZGVkIGZvciBjb21waWxpbmcgZHNwIGdhdGV3YXkgbW9kdWxlIG9uIGtlcm5lbCAyLjYuMTYt
b21hcDEKClNpZ25lZC1vZmYtYnk6IE1vdWhhbW1hZCBUYXlzZWVyIEFscXVvYXRsaSA8SURPSVQu
SUVGQGdtYWlsLmNvbT4KCi0tLQoKZGlmZiAtdU5wIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC9k
c3BfY29tbW9uLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZHNwL2RzcF9jb21tb24uYwotLS0gYS9h
cmNoL2FybS9wbGF0LW9tYXAvZHNwL2RzcF9jb21tb24uYwkyMDA2LTA2LTE2IDExOjA1OjQxLjAw
MDAwMDAwMCArMDMwMAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvZHNwL2RzcF9jb21tb24uYwky
MDA2LTA2LTE2IDExOjA2OjM0LjAwMDAwMDAwMCArMDMwMApAQCAtNTQyLDQgKzU0Miw2IEBAIEVY
UE9SVF9TWU1CT0woZHNwX3JlZ2lzdGVyX21lbV9jYik7CiBFWFBPUlRfU1lNQk9MKGRzcF91bnJl
Z2lzdGVyX21lbV9jYik7CiAKIEVYUE9SVF9TWU1CT0woX19jcHVfZmx1c2hfa2Vybl90bGJfcmFu
Z2UpOworRVhQT1JUX1NZTUJPTChjcHVfYXJjaGl0ZWN0dXJlKTsKK0VYUE9SVF9TWU1CT0wocG1k
X2NsZWFyX2JhZCk7CiAjZW5kaWYKCi0tCg==
------=_Part_9006_5853724.1150461310888
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_9006_5853724.1150461310888--
