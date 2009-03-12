From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
 reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 14:12:02 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
 <87zlfq6497.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_7A436F7769CA33409C6B44B358BFFF0CFF51E139dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZCLTMR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2009 15:12:17 -0400
In-Reply-To: <87zlfq6497.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

--_002_7A436F7769CA33409C6B44B358BFFF0CFF51E139dlee02entticom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kevin,
Some more isolation:
The l-o master branch does not have an issue, only the pm branch seems to h=
ave the problem - probably some commit(s?) missing in pm branch. Since brid=
ge is based off the pm branch, wont make sense to regress on it :(.

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, March 12, 2009 7:27 PM
> To: Menon, Nishanth
> Cc: Guzman Lugo, Fernando; linux-omap@vger.kernel.org; Kanigeri, Hari;
> Woodruff, Richard; Lakhani, Amish; Gupta, Ramesh; Ameya Palande
> Subject: Re: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
> reloading dspbridge several times due to a memory leak.)

> Which of these physical addresses causes an increasing virtual
> address?  The addresses in the 0x48xxxxxx (L4, L4_WKUP) range should
> just trigger static mapping via the arch-specific ioremap, so those
> should always map to the same virt address.
>=20
> Could you do the experiment with a smaller number of mappings?  Maybe
> just one at a time of the non L4 mappings?  Probably starting with
> only the BASE,SIZE mapping.
>=20
Attached is the patch for pm branch.=20
Codebase:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2=
.6.git
git checkout -b pm --track origin/pm
git branch iotest-pm
git apply 0001-MISC-dummy-driver-to-test-ioremap.patch

make omap_3430sdp_defconfig
make uImage && make modules

bootargs: console=3DttyS0,115200n8 noinitrd ip=3Ddhcp root=3D/dev/nfs rw nf=
sroot=3D<server>:<fsPath>,nolock,wsize=3D1024,rsize=3D1024 mem=3D64M

I reorganized the driver from the previous version I had send, so that we c=
an provide base address,size and number of io_remaps to try as module param=
s. And tested with the following shell script:
#!/bin/bash
slee()
{
        echo "Sleep "
#sleep 5
}
try=3D1
while [ $try -lt 13 ]; do
	  i=3D0
        while [ $i -lt 100 ]; do
                echo "insmod $i base=3D0x87000000 size=3D0x600000 try=3D$tr=
y"
                insmod  ./dummy.ko base=3D0x87000000 size=3D0x600000 try=3D=
$try
                if [ $? -ne 0 ]; then
                        echo "QUIT IN INSMOD $i"
                        exit 1;
                fi
                slee
                echo "rmmod $i"
                rmmod dummy
                if [ $? -ne 0 ]; then
                        echo "QUIT IN RMMOD $i"
                        exit 1;
                fi
                i=3D`expr $i + 1`
                slee
        done
        try=3D$(( $try + 1 ))
done

Result:
insmod 21 base=3D0x87000000 size=3D0x600000 try=3D1
vmap allocation failed: use vmalloc=3D<size> to increase size.
Map[0] - virt=3D0x00000000 phy=3D0x87000000 size=3D0x00600000
Allocation failed idx=3D0
insmod: cannot insert `./dummy.ko': Cannot allocate memory (-1): Cannot all=
ocate memory
QUIT IN INSMOD 21

In terms of virtual addresses generated:
0xCD800000
0xCE000000
0xCE800000
0xCF000000
0xCF800000
0xD0000000
0xD0800000
0xD1000000
...
[iteration 20] 0xD7800000

The next one fails.

The same patch will apply on linux-omap master branch also, but patching dr=
ivers/misc/Makefile will break with my patch - need to trivial hand merge i=
t..

commitIDs tested against:
linux-omap master: cc2b459c066361098704c586f3134c3c3ac13be3 (the entire scr=
ipt runs through)
linux-omap pm: 4f422d583e2e233c19eb20754b8cfad6ed9e460a (the script fails a=
round 21st iteration with try=3D1)

Regards,
Nishanth Menon

--_002_7A436F7769CA33409C6B44B358BFFF0CFF51E139dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-MISC-dummy-driver-to-test-ioremap.patch"
Content-Description: 0001-MISC-dummy-driver-to-test-ioremap.patch
Content-Disposition: attachment;
	filename="0001-MISC-dummy-driver-to-test-ioremap.patch"; size=3997;
	creation-date="Thu, 12 Mar 2009 13:54:03 GMT";
	modification-date="Thu, 12 Mar 2009 14:06:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNDJkN2ZiZDg1ZjJhOWI5ZWE5YzVkZGI3MGE3ZDNiZjA3NTFhOTVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPgpEYXRlOiBUaHUs
IDEyIE1hciAyMDA5IDEzOjQ2OjM0IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gTUlTQzogZHVtbXkg
ZHJpdmVyIHRvIHRlc3QgaW9yZW1hcAogdGhlIHNjcmlwdCBzdWNoIGFzIHRoZSBmb2xsb3dpbmcg
dGVzdHMgaW9yZW1hcCBvbiBzZHAzNDMwCiBib290YXJncyBtZW09NjRNIGZvciBzZHAzNDMwIGZv
ciB0aGUgdGVzdAogc2xlZSgpCiB7CiAJZWNobyAiU2xlZXAgIgogfQogdHJ5PTEKIHdoaWxlIFsg
JHRyeSAtbHQgMTMgXTsgZG8KCWk9MAogCXdoaWxlIFsgJGkgLWx0IDEwMCBdOyBkbwogCQllY2hv
ICJpbnNtb2QgJGkgYmFzZT0weDg3MDAwMDAwIHNpemU9MHg2MDAwMDAgdHJ5PSR0cnkiCiAJCWlu
c21vZCAgLi9kdW1teS5rbyBiYXNlPTB4ODcwMDAwMDAgc2l6ZT0weDYwMDAwMCB0cnk9JHRyeQog
CQlpZiBbICQ/IC1uZSAwIF07IHRoZW4KIAkJCWVjaG8gIlFVSVQgSU4gSU5TTU9EICRpIgogCQkJ
ZXhpdCAxOwogCQlmaQogCQlzbGVlCiAJCWVjaG8gInJtbW9kICRpIgogCQlybW1vZCBkdW1teQog
CQlpZiBbICQ/IC1uZSAwIF07IHRoZW4KIAkJCWVjaG8gIlFVSVQgSU4gUk1NT0QgJGkiCiAJCQll
eGl0IDE7CiAJCWZpCiAJCWk9YGV4cHIgJGkgKyAxYAogCQlzbGVlCiAJZG9uZQogCXRyeT0kKCgg
JHRyeSArIDEgKSkKIGRvbmUKCgpTaWduZWQtb2ZmLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGku
Y29tPgotLS0KIGRyaXZlcnMvbWlzYy9LY29uZmlnICB8ICAgIDQgKysKIGRyaXZlcnMvbWlzYy9N
YWtlZmlsZSB8ICAgIDEgKwogZHJpdmVycy9taXNjL2R1bW15LmMgIHwgICA5MSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQs
IDk2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9taXNjL2R1bW15LmMKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvS2NvbmZpZyBiL2Ry
aXZlcnMvbWlzYy9LY29uZmlnCmluZGV4IGExMWUyYTAuLjI5MzRjNGEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbWlzYy9LY29uZmlnCisrKyBiL2RyaXZlcnMvbWlzYy9LY29uZmlnCkBAIC0xMyw2ICsx
MywxMCBAQCBtZW51Y29uZmlnIE1JU0NfREVWSUNFUwogCiBpZiBNSVNDX0RFVklDRVMKIAorY29u
ZmlnIE1JU0NfRFVNTVkKKwl0cmlzdGF0ZSAiZHVtbXkgbGlsIGRyaXZlciIKKwlkZWZhdWx0IG0K
KwogY29uZmlnIEFUTUVMX1BXTQogCXRyaXN0YXRlICJBdG1lbCBBVDMyL0FUOTEgUFdNIHN1cHBv
cnQiCiAJZGVwZW5kcyBvbiBBVlIzMiB8fCBBUkNIX0FUOTFTQU05MjYzIHx8IEFSQ0hfQVQ5MVNB
TTlSTCB8fCBBUkNIX0FUOTFDQVA5CmRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvTWFrZWZpbGUg
Yi9kcml2ZXJzL21pc2MvTWFrZWZpbGUKaW5kZXggNzhiZTEzNC4uOWU3YjJhNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9taXNjL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbWlzYy9NYWtlZmlsZQpAQCAt
Miw2ICsyLDcgQEAKICMgTWFrZWZpbGUgZm9yIG1pc2MgZGV2aWNlcyB0aGF0IHJlYWxseSBkb24n
dCBmaXQgYW55d2hlcmUgZWxzZS4KICMKIG9iai0gOj0gbWlzYy5vCSMgRHVtbXkgcnVsZSB0byBm
b3JjZSBidWlsdC1pbi5vIHRvIGJlIG1hZGUKK29iai0kKENPTkZJR19NSVNDX0RVTU1ZKQkrPSBk
dW1teS5vCiAKIG9iai0kKENPTkZJR19JQk1fQVNNKQkJKz0gaWJtYXNtLwogb2JqLSQoQ09ORklH
X0hEUFVfRkVBVFVSRVMpCSs9IGhkcHVmdHJzLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2R1
bW15LmMgYi9kcml2ZXJzL21pc2MvZHVtbXkuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwLi45YzY1MDBmCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9taXNjL2R1bW15LmMK
QEAgLTAsMCArMSw5MSBAQAorCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4
L21tLmg+CisjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KKworc3RhdGljIGludCBzaXpl
OworbW9kdWxlX3BhcmFtKHNpemUsIGludCwgMCk7CitNT0RVTEVfUEFSTV9ERVNDKHNpemUsICJz
aXplIGRlZmF1bHQgPTB4ODcwMDAwMDAiKTsKKworc3RhdGljIGludCBiYXNlOworbW9kdWxlX3Bh
cmFtKGJhc2UsIGludCwgMCk7CitNT0RVTEVfUEFSTV9ERVNDKGJhc2UsICJCYXNlYWRkcmVzcyBk
ZWZhdWx0IDB4NjAwMDAwMCIpOworCitzdHJ1Y3QgbWVtX3MgeworCXZvaWQgKnZpcjsKKwl1MzIg
cGh5OworCXUzMiBzaXplOworfTsKKworc3RhdGljIHN0cnVjdCBtZW1fcyBiW10gPSB7CisJezAs
IDAsIDB9LAkJLyogRmlsbCBtZSB1cCBzY290dHkgKi8KKwl7MCwgMHg1ZDAwMDAwMCwgNDA5Nn0s
CisJezAsIDB4NWM3ZjgwMDAsIDk4MzA0fSwKKwl7MCwgMHg1Y2UwMDAwMCwgMzI3Njh9LAorCXsw
LCAweDVjZjA0MDAwLCA4MTkyMH0sCisJezAsIDB4NDgzMDYwMDAsIDQwOTZ9LAorCXswLCAweDQ4
MDA0MDAwLCA0MDk2fSwKKwl7MCwgMHg0ODA5NDAwMCwgNDA5Nn0sCisJezAsIDB4NDgwMDIwMDAs
IDQwOTZ9LAorCXswLCAweDQ4MDA1MDAwLCA0MDk2fSwKKwl7MCwgMHg0ODMwNzAwMCwgNDA5Nn0s
CisJezAsIDB4NDgzMDZhMDAsIDQwOTZ9LAorfTsKKworc3RhdGljIGludCB0cnk7Cittb2R1bGVf
cGFyYW0odHJ5LCBpbnQsIChzaXplb2YoYikgLyBzaXplb2Yoc3RydWN0IG1lbV9zKSkpOworTU9E
VUxFX1BBUk1fREVTQyh0cnksICJ0cnk9MTIiKTsKKworc3RhdGljIGludCBfX2luaXQgZHVtbXlf
aW5pdCh2b2lkKQoreworCWludCBpOworCWJbMF0ucGh5ID0gYmFzZTsKKwliWzBdLnNpemUgPSBz
aXplOworCWlmICghdHJ5KQorCQl0cnkgPSAoc2l6ZW9mKGIpIC8gc2l6ZW9mKHN0cnVjdCBtZW1f
cykpOworCWlmICghYmFzZSkKKwkJYmFzZSA9IDB4ODcwMDAwMDA7CisJaWYgKCFzaXplKQorCQlz
aXplID0gMHg2MDAwMDA7CisJaWYgKHRyeSA+IChzaXplb2YoYikgLyBzaXplb2Yoc3RydWN0IG1l
bV9zKSkpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJHaXZlIG1lIHByb3BlciB0cnkgdmFsdWVcbiIp
OworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJZm9yIChpID0gMDsgaSA8IHRyeTsgaSsrKSB7CisJ
CWJbaV0udmlyID0gaW9yZW1hcChiW2ldLnBoeSwgYltpXS5zaXplKTsKKwkJcHJpbnRrKEtFUk5f
SU5GTworCQkgICAgICAgIk1hcFslZF0gLSB2aXJ0PTB4JTA4WCBwaHk9MHglMDhYIHNpemU9MHgl
MDhYXG4iLCBpLAorCQkgICAgICAgKHUzMikgKGJbaV0udmlyKSwgYltpXS5waHksIGJbaV0uc2l6
ZSk7CisJCWlmIChiW2ldLnZpciA9PSBOVUxMKSB7CisJCQlwcmludGsoS0VSTl9FUlIgIkFsbG9j
YXRpb24gZmFpbGVkIGlkeD0lZFxuIiwgaSk7CisJCQkvKiBGcmVlIHVwIGFsbCB0aGUgcHJldiBh
bGxvY3MgKi8KKwkJCWktLTsKKwkJCXdoaWxlIChpID49IDApIHsKKwkJCQlpb3VubWFwKGJbaV0u
dmlyKTsKKwkJCQlpLS07CisJCQl9CisJCQlyZXR1cm4gLUVOT01FTTsKKworCQl9CisJfQorCXJl
dHVybiAwOworfQorCittb2R1bGVfaW5pdChkdW1teV9pbml0KTsKKworc3RhdGljIHZvaWQgX19l
eGl0IGR1bW15X2V4aXQodm9pZCkKK3sKKwlpbnQgaTsKKwlmb3IgKGkgPSAwOyBpIDwgdHJ5OyBp
KyspIHsKKwkJcHJpbnRrKEtFUk5fSU5GTworCQkgICAgICAgIlVubWFwWyVkXSAtIHZpcnQ9MHgl
MDhYIHBoeT0weCUwOFggc2l6ZT0weCUwOFhcbiIsIGksCisJCSAgICAgICAodTMyKSBiW2ldLnZp
ciwgYltpXS5waHksIGJbaV0uc2l6ZSk7CisJCWlvdW5tYXAoYltpXS52aXIpOworCX0KK30KKwor
bW9kdWxlX2V4aXQoZHVtbXlfZXhpdCk7CisKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKLS0gCjEu
NS40LjMKCg==

--_002_7A436F7769CA33409C6B44B358BFFF0CFF51E139dlee02entticom_--
