From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: [PATCH] mkuboot.sh: quit elegantly on not finding mkimage
Date: Tue, 8 May 2007 19:17:33 -0500
Message-ID: <782515bb0705081717jaea0fdbj3b4cbd3325fcbbe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_134064_29772870.1178669853552"
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_134064_29772870.1178669853552
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
A tiny patch: when mkimage is not found return 1 instead of 0. helps
to ensure that the make uImage fails if mkimage is not in path.

Could not find a vgers list for scripts.. hence posting here..

Regards,
Nishanth menon

------=_Part_134064_29772870.1178669853552
Content-Type: application/octet-stream;
	name=01-mkuboot.sh-quit-elegantly-on-not-finding-mkimage.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1h199vi
Content-Disposition: attachment;
	filename="01-mkuboot.sh-quit-elegantly-on-not-finding-mkimage.patch"

bWt1Ym9vdC5zaDogcXVpdCBlbGVnYW50bHkgb24gbm90IGZpbmRpbmcgbWtpbWFnZQoKU2lnbmVk
LW9mZi1ieTogTmlzaGFudGggTWVub24gPG1lbm9uLm5pc2hhbnRoQGdtYWlsLmNvbT4KCi0tLQpj
b21taXQgNGM5N2NkYzQ5ODVhMzk3Y2ZmYWY0OGRiMjMwMjgwMmQwNDNmYmVhOAp0cmVlIDYzNTlk
Y2Q2NzUxMTE4YzVjMDVjNWI4N2FhNWRlYjkyZjk3MTYzNTYKcGFyZW50IGQ3MmUwMThiNzdmNWI1
MTNhYjA1YTU5ZTAyYWMwNzI2MDIxNWY3OWMKYXV0aG9yIE5pc2hhbnRoIE1lbm9uIDxtZW5vbi5u
aXNoYW50aEBnbWFpbC5jb20+IFR1ZSwgMDggTWF5IDIwMDcgMTg6NTY6MDUgLTA1MDAKY29tbWl0
dGVyIE5pc2hhbnRoIE1lbm9uIDxtZW5vbi5uaXNoYW50aEBnbWFpbC5jb20+IFR1ZSwgMDggTWF5
IDIwMDcgMTg6NTY6MDUgLTA1MDAKCiBzY3JpcHRzL21rdWJvb3Quc2ggfCAgICAyICstCiAxIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zY3JpcHRzL21rdWJvb3Quc2ggYi9zY3JpcHRzL21rdWJvb3Quc2gKaW5kZXggMmUzZDNjZC4u
NDQ2NzM5YyAxMDA3NTUKLS0tIGEvc2NyaXB0cy9ta3Vib290LnNoCisrKyBiL3NjcmlwdHMvbWt1
Ym9vdC5zaApAQCAtMTEsNyArMTEsNyBAQCBpZiBbIC16ICIke01LSU1BR0V9IiBdOyB0aGVuCiAJ
aWYgWyAteiAiJHtNS0lNQUdFfSIgXTsgdGhlbgogCQkjIERvZXNuJ3QgZXhpc3QKIAkJZWNobyAn
Im1raW1hZ2UiIGNvbW1hbmQgbm90IGZvdW5kIC0gVS1Cb290IGltYWdlcyB3aWxsIG5vdCBiZSBi
dWlsdCcgPiYyCi0JCWV4aXQgMDsKKwkJZXhpdCAxOwogCWZpCiBmaQogCg==
------=_Part_134064_29772870.1178669853552
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_134064_29772870.1178669853552--
