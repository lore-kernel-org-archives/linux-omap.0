From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH] ARM: OMAP: Palm Tungsten E board update
Date: Thu, 28 Sep 2006 22:22:07 +0200
Message-ID: <fb249edb0609281322u45c15f32wf62a92940aa6eab0@mail.gmail.com>
References: <fb249edb0609230339h66a97190r9f7f5408c688652c@mail.gmail.com>
	<20060928140440.GK29453@atomide.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_63226_9841063.1159474927927"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060928140440.GK29453@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_63226_9841063.1159474927927
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 28/09/06, Tony Lindgren <tony@atomide.com> wrote:
> * andrzej zaborowski <balrog@zabor.org> [060923 13:45]:
> > General update of the board file for Palm Tungsten E. Registers the
> > platform devices contained in the PDA (ROM chip, keypad, infra-red)
> > and updates the configuration for USB and MMC, whose config values
> > were previously guessed in most cases due to lack of documentation
> > (and now are confirmed by a number of users). Macros for GPIO pins are
> > moved to a file in include/asm-arm/arch-omap.
> >
> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
>
> Pushing today.

Many thanks.
One thing though: the patch added a new file at
include/asm-arm/arch-omap/board-palmte.h which didn't get merged and
include/asm-arm/arch-omap/hardware.h now tries to #include the file.
Can you add this header? (the attached diff contains this file alone)

Regards,
Andrew

------=_Part_63226_9841063.1159474927927
Content-Type: application/octet-stream; name=linux-palmte-defines.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esnky8kr
Content-Disposition: attachment; filename="linux-palmte-defines.patch"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtcGFsbXRlLmggYi9p
bmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLXBhbG10ZS5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLmNkMjIwMzUKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2Fz
bS1hcm0vYXJjaC1vbWFwL2JvYXJkLXBhbG10ZS5oCkBAIC0wLDAgKzEsMzQgQEAKKy8qCisgKiBs
aW51eC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLXBhbG10ZS5oCisgKgorICogSGFy
ZHdhcmUgZGVmaW5pdGlvbnMgZm9yIHRoZSBQYWxtIFR1bmdzdGVuIEUgZGV2aWNlLgorICoKKyAq
IE1haW50YWludGVycyA6CWh0dHA6Ly9wYWxtdGVsaW51eC5zZi5uZXQKKyAqCQkJcGFsbXRlbGlu
dXgtZGV2ZWxvcHBlcnNAbGlzdHMuc2YubmV0CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAy
IGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLwor
CisjaWZuZGVmIF9fT01BUF9CT0FSRF9QQUxNVEVfSAorI2RlZmluZSBfX09NQVBfQk9BUkRfUEFM
TVRFX0gKKworI2luY2x1ZGUgPGFzbS9hcmNoL2dwaW8uaD4KKworI2RlZmluZSBQQUxNVEVfVVNC
REVURUNUX0dQSU8JMAorI2RlZmluZSBQQUxNVEVfVVNCX09SX0RDX0dQSU8JMQorI2RlZmluZSBQ
QUxNVEVfVFNDX0dQSU8JCTQKKyNkZWZpbmUgUEFMTVRFX1BJTlREQVZfR1BJTwk2CisjZGVmaW5l
IFBBTE1URV9NTUNfV1BfR1BJTwk4CisjZGVmaW5lIFBBTE1URV9NTUNfUE9XRVJfR1BJTwk5Cisj
ZGVmaW5lIFBBTE1URV9IRFFfR1BJTwkJMTEKKyNkZWZpbmUgUEFMTVRFX0hFQURQSE9ORVNfR1BJ
TwkxNAorI2RlZmluZSBQQUxNVEVfU1BFQUtFUl9HUElPCTE1CisjZGVmaW5lIFBBTE1URV9EQ19H
UElPCQlPTUFQX01QVUlPKDIpCisjZGVmaW5lIFBBTE1URV9NTUNfU1dJVENIX0dQSU8JT01BUF9N
UFVJTyg0KQorI2RlZmluZSBQQUxNVEVfTU1DMV9HUElPCU9NQVBfTVBVSU8oNikKKyNkZWZpbmUg
UEFMTVRFX01NQzJfR1BJTwlPTUFQX01QVUlPKDcpCisjZGVmaW5lIFBBTE1URV9NTUMzX0dQSU8J
T01BUF9NUFVJTygxMSkKKworI2VuZGlmCS8qIF9fT01BUF9CT0FSRF9QQUxNVEVfSCAqLwo=
------=_Part_63226_9841063.1159474927927
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_63226_9841063.1159474927927--
