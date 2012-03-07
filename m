From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.
Date: Wed, 7 Mar 2012 19:40:07 +0530
Message-ID: <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
References: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f64697faaead104baa7b85a
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--e89a8f64697faaead104baa7b85a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 7, 2012 at 5:49 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>
> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
> (ex: usb host uhh module) in absence of this flag
> omap_hwmod_enable/disable_wakeup avoids configuring
> pad mux wakeup capability.
>
> Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
> try enabling/disabling wakeup from mux_pad pins.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c | =A0 30 ++++++++++++++++------------=
--
> =A01 files changed, 16 insertions(+), 14 deletions(-)

[...]

>
> @@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *=
oh)
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0u32 v;
>
> - =A0 =A0 =A0 if (!oh->class->sysc ||
> - =A0 =A0 =A0 =A0 =A0 !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> =A0 =A0 =A0 =A0spin_lock_irqsave(&oh->_lock, flags);
> - =A0 =A0 =A0 v =3D oh->_sysc_cache;
> - =A0 =A0 =A0 _disable_wakeup(oh, &v);
> - =A0 =A0 =A0 _write_sysconfig(v, oh);
> +
> + =A0 =A0 =A0 if (oh->class->sysc ||
> + =A0 =A0 =A0 =A0 =A0 (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))=
 {


This condition check should have been _and_ (&&)
sorry for the typo,

Here [1] is the updated patch.

--
Thanks,
Govindraj.R

[1]:

>From b3aa1dac5909cad1b959f5b97bbf408b2f974060 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Wed, 7 Mar 2012 17:14:02 +0530
Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.

Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
(ex: usb host uhh module) in absence of this flag
omap_hwmod_enable/disable_wakeup avoids configuring
pad mux wakeup capability.

Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
try enabling/disabling wakeup from mux_pad pins.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index eba6cd3..9605fad 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2475,14 +2475,15 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	unsigned long flags;
 	u32 v;

-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v =3D oh->_sysc_cache;
-	_enable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v =3D oh->_sysc_cache;
+		_enable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);

@@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh=
)
 	unsigned long flags;
 	u32 v;

-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v =3D oh->_sysc_cache;
-	_disable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v =3D oh->_sysc_cache;
+		_disable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);

--=20
1.7.5.4

--e89a8f64697faaead104baa7b85a
Content-Type: application/octet-stream;
	name="0001-omap_hwmod-Allow-io_ring-wakeup-configuration-for-al.patch"
Content-Disposition: attachment;
	filename="0001-omap_hwmod-Allow-io_ring-wakeup-configuration-for-al.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzig0bx50

RnJvbSBiM2FhMWRhYzU5MDljYWQxYjk1OWY1Yjk3YmJmNDA4YjJmOTc0MDYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiR292aW5kcmFqLlIiIDxnb3ZpbmRyYWoucmFqYUB0aS5jb20+
CkRhdGU6IFdlZCwgNyBNYXIgMjAxMiAxNzoxNDowMiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIG9t
YXBfaHdtb2Q6IEFsbG93IGlvX3Jpbmcgd2FrZXVwIGNvbmZpZ3VyYXRpb24gZm9yIGFsbAogbW9k
dWxlcy4KClNvbWUgbW9kdWxlcyBkb2Vzbid0IGhhdmUgU1lTQ19IQVNfRU5BV0FLRVVQIGJpdCBh
dmFpbGFibGUKKGV4OiB1c2IgaG9zdCB1aGggbW9kdWxlKSBpbiBhYnNlbmNlIG9mIHRoaXMgZmxh
ZwpvbWFwX2h3bW9kX2VuYWJsZS9kaXNhYmxlX3dha2V1cCBhdm9pZHMgY29uZmlndXJpbmcKcGFk
IG11eCB3YWtldXAgY2FwYWJpbGl0eS4KCkNvbmZpZ3VyZSBzeXNjIGlmIFNZU0NfSEFTX0VOQVdB
S0VVUCBpcyBhdmFpbGFibGUgYW5kIGZvciBvdGhlciBjYXNlcwp0cnkgZW5hYmxpbmcvZGlzYWJs
aW5nIHdha2V1cCBmcm9tIG11eF9wYWQgcGlucy4KCkNjOiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3
c2FuLmNvbT4KQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+CkNjOiBSYWplbmRyYSBO
YXlhayA8cm5heWFrQHRpLmNvbT4KU2lnbmVkLW9mZi1ieTogR292aW5kcmFqLlIgPGdvdmluZHJh
ai5yYWphQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2QuYyB8ICAg
MzAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
b21hcDIvb21hcF9od21vZC5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kLmMKaW5k
ZXggZWJhNmNkMy4uOTYwNWZhZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
X2h3bW9kLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kLmMKQEAgLTI0NzUs
MTQgKzI0NzUsMTUgQEAgaW50IG9tYXBfaHdtb2RfZW5hYmxlX3dha2V1cChzdHJ1Y3Qgb21hcF9o
d21vZCAqb2gpCiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAl1MzIgdjsKIAotCWlmICghb2gtPmNs
YXNzLT5zeXNjIHx8Ci0JICAgICEob2gtPmNsYXNzLT5zeXNjLT5zeXNjX2ZsYWdzICYgU1lTQ19I
QVNfRU5BV0FLRVVQKSkKLQkJcmV0dXJuIC1FSU5WQUw7Ci0KIAlzcGluX2xvY2tfaXJxc2F2ZSgm
b2gtPl9sb2NrLCBmbGFncyk7Ci0JdiA9IG9oLT5fc3lzY19jYWNoZTsKLQlfZW5hYmxlX3dha2V1
cChvaCwgJnYpOwotCV93cml0ZV9zeXNjb25maWcodiwgb2gpOworCisJaWYgKG9oLT5jbGFzcy0+
c3lzYyAmJgorCSAgICAob2gtPmNsYXNzLT5zeXNjLT5zeXNjX2ZsYWdzICYgU1lTQ19IQVNfRU5B
V0FLRVVQKSkgeworCQl2ID0gb2gtPl9zeXNjX2NhY2hlOworCQlfZW5hYmxlX3dha2V1cChvaCwg
JnYpOworCQlfd3JpdGVfc3lzY29uZmlnKHYsIG9oKTsKKwl9CisKIAlfc2V0X2lkbGVfaW9yaW5n
X3dha2V1cChvaCwgdHJ1ZSk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmb2gtPl9sb2NrLCBm
bGFncyk7CiAKQEAgLTI1MDYsMTQgKzI1MDcsMTUgQEAgaW50IG9tYXBfaHdtb2RfZGlzYWJsZV93
YWtldXAoc3RydWN0IG9tYXBfaHdtb2QgKm9oKQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdTMy
IHY7CiAKLQlpZiAoIW9oLT5jbGFzcy0+c3lzYyB8fAotCSAgICAhKG9oLT5jbGFzcy0+c3lzYy0+
c3lzY19mbGFncyAmIFNZU0NfSEFTX0VOQVdBS0VVUCkpCi0JCXJldHVybiAtRUlOVkFMOwotCiAJ
c3Bpbl9sb2NrX2lycXNhdmUoJm9oLT5fbG9jaywgZmxhZ3MpOwotCXYgPSBvaC0+X3N5c2NfY2Fj
aGU7Ci0JX2Rpc2FibGVfd2FrZXVwKG9oLCAmdik7Ci0JX3dyaXRlX3N5c2NvbmZpZyh2LCBvaCk7
CisKKwlpZiAob2gtPmNsYXNzLT5zeXNjICYmCisJICAgIChvaC0+Y2xhc3MtPnN5c2MtPnN5c2Nf
ZmxhZ3MgJiBTWVNDX0hBU19FTkFXQUtFVVApKSB7CisJCXYgPSBvaC0+X3N5c2NfY2FjaGU7CisJ
CV9kaXNhYmxlX3dha2V1cChvaCwgJnYpOworCQlfd3JpdGVfc3lzY29uZmlnKHYsIG9oKTsKKwl9
CisKIAlfc2V0X2lkbGVfaW9yaW5nX3dha2V1cChvaCwgZmFsc2UpOwogCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJm9oLT5fbG9jaywgZmxhZ3MpOwogCi0tIAoxLjcuNS40Cgo=
--e89a8f64697faaead104baa7b85a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--e89a8f64697faaead104baa7b85a--
