From: "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
Subject: Re: Regression with arm in next with stack protector
Date: Tue, 27 Mar 2018 16:29:12 +0800
Message-ID: <tencent_1DDCF65B56759D1B570EF7DD@qq.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
 <tencent_79FD53B203715FD7439C6EAB@qq.com>
 <20180326153714.GG5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180326153714.GG5700@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?VG9ueSBMaW5kZ3Jlbg==?= <tony@atomide.com>
Cc: =?utf-8?B?U3RlcGhlbiBSb3Rod2VsbA==?= <sfr@canb.auug.org.au>, =?utf-8?B?UmljaCBGZWxrZXI=?= <dalias@libc.org>, =?utf-8?B?UnVzc2VsbCBLaW5n?= <linux@arm.linux.org.uk>, =?utf-8?B?WW9zaGlub3JpIFNhdG8=?= <ysato@users.sourceforge.jp>, =?utf-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>, =?utf-8?B?UmFsZiBCYWVjaGxl?= <ralf@linux-mips.org>, =?utf-8?B?QW5kcmV3IE1vcnRvbg==?= <akpm@linux-foundation.org>, =?utf-8?B?bGludXgtb21hcA==?= <linux-omap@vger.kernel.org>, =?utf-8?B?RmFiaW8gRXN0ZXZhbQ==?= <festevam@gmail.com>, =?utf-8?B?SmFtZXMgSG9nYW4=?= <james.hogan@mips.com>, =?utf-8?B?bW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ==?= <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

QWxsd2lubmVyIGRldmljZXMgYXJlIE9LLCBFeHlub3MgZGV2aWNlcyAoZXhjZXB0IDQyMTApIGFy
ZSBPSy4NCiANCi0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0N
CkZyb206ICAiVG9ueSBMaW5kZ3JlbiI8dG9ueUBhdG9taWRlLmNvbT47DQpEYXRlOiAgTW9uLCBN
YXIgMjYsIDIwMTggMTE6MzcgUE0NClRvOiAgIumZiOWNjuaJjSI8Y2hlbmhjQGxlbW90ZS5jb20+
Ow0KQ2M6ICAiQW5kcmV3IE1vcnRvbiI8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47ICJGYWJp
byBFc3RldmFtIjxmZXN0ZXZhbUBnbWFpbC5jb20+OyAiU3RlcGhlbiBSb3Rod2VsbCI8c2ZyQGNh
bmIuYXV1Zy5vcmcuYXU+OyAiUmljaCBGZWxrZXIiPGRhbGlhc0BsaWJjLm9yZz47ICJSdXNzZWxs
IEtpbmciPGxpbnV4QGFybS5saW51eC5vcmcudWs+OyAiWW9zaGlub3JpIFNhdG8iPHlzYXRvQHVz
ZXJzLnNvdXJjZWZvcmdlLmpwPjsgImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47ICJSYWxmIEJhZWNobGUiPHJhbGZAbGludXgtbWlwcy5vcmc+OyAibGludXgtb21h
cCI8bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc+OyAiSmFtZXMgSG9nYW4iPGphbWVzLmhvZ2Fu
QG1pcHMuY29tPjsgIm1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBB
UkNISVRFQ1RVUkUiPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47DQpTdWJq
ZWN0OiAgUmU6IFJlZ3Jlc3Npb24gd2l0aCBhcm0gaW4gbmV4dCB3aXRoIHN0YWNrIHByb3RlY3Rv
cg0KIA0KKiDpmYjljY7miY0gPGNoZW5oY0BsZW1vdGUuY29tPiBbMTgwMzI2IDA2OjU5XToNCj4g
SGksIFRvbnkgYW5kIEZhYmlvLA0KPiANCj4gQ291bGQgeW91IHBsZWFzZSB1cGxvYWQgeW91ciBr
ZXJuZWwgYmluYXJ5IHRvIHNvbWV3aGVyZSBmb3IgbWU/IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkg
c29tZSBBUk0gYm9hcmRzIGlzIE9LIHdoaWxlIG90aGVycyBhcmUgYnJva2VuLg0KDQpXZWxsIHRo
ZSBrZXJuZWwgSSdtIHRlc3RpbmcgaXMganVzdCBjdXJyZW50IExpbnV4IG5leHQgY3Jvc3MNCmNv
bXBpbGVkIG9tYXAycGx1c19kZWZjb25maWcga2VybmVsLiBJIGRvIGhhdmUgZmV3IG1vcmUgY29u
ZmlnDQpvcHRpb25zIGVuYWJsZWQgbGlrZSBMT0NLREVQIGFuZCBERUJVR19BVE9NSUNfU0xFRVAs
IGJ1dCBJDQpkb3VidCB0aGV5IG1hdHRlciBoZXJlIDopDQoNClRoZW4gSSdtIHVzaW5nIGdjYy03
LjMuMCBhbmQgYmludXRpbHMtMi4zMCBidWlsdCB3aXRoIHRoZQ0KYnVpbGRhbGwuZ2l0IHNjcmlw
dHM6DQoNCmdpdDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL3NlZ2hlci9idWlsZGFsbC5naXQN
Cg0KSWYgeW91IHN0aWxsIG5lZWQgYmluYXJpZXMsIGxldCBtZSBrbm93Lg0KDQpEbyB5b3Uga25v
dyB3aGljaCBhcm0gZGV2aWNlcyBhcmUgd29ya2luZyB3aXRoIHlvdXIgcGF0Y2g/DQoNClJlZ2Fy
ZHMsDQoNClRvbnkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
