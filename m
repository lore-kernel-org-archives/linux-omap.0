From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Mon, 21 May 2012 15:02:44 +0200
Message-ID: <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b33d50ea834be04c08b84ed
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>, Anna Suman <s-anna@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Iliyan Malchev <malchev@google.com>, Brian Swetland <swetland@google.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, John Williams <john.williams@petalogix.com>, Clark Rob <rob@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>, Mark Grosen <mgrosen@ti.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

--047d7b33d50ea834be04c08b84ed
Content-Type: multipart/alternative; boundary=047d7b33d50ea834b104c08b84eb

--047d7b33d50ea834b104c08b84eb
Content-Type: text/plain; charset=ISO-8859-1

Hi Ohad,

2012/5/17 Ohad Ben-Cohen <ohad@wizery.com>

> Hi Michal,
>
> On Sat, Mar 17, 2012 at 8:39 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > IOW: you can probably just wait a bit until this patch is ready and
> > take it into your tree. It will most likely bring back the behavior you
> > need :)
>
> Does something like the attached help ?
>

I have looked at it and tested on latest and greatest and the problem is
still there.  If you look at debug output below
you see that vrings are allocated before carveout area which is causing
that rtos text is not placed at 0x0 address.

I have looked at the code and path is
rproc_fw_config_virtio -> rproc_handliefirtion_rsc -> rproc_handle_vdev


~ # zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0,
2 vrings
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, qsz 256,
align 256
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256,
align 256
zynq_remoteproc 0.remoteproc-test: vring0: va d1000000 dma 0 size 2000 idr 0
zynq_remoteproc 0.remoteproc-test: vring1: va d1002000 dma 2000 size 2000
idr 1
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2353146
zynq_remoteproc 0.remoteproc-test: iommu not found
zynq_remoteproc 0.remoteproc-test: rsc: type 0
zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20,
flags 0
zynq_remoteproc 0.remoteproc-test: carveout va d1400000, dma 400000, len
0x20ec20
zynq_remoteproc 0.remoteproc-test: rsc: type 3
zynq_remoteproc 0.remoteproc-test: rsc: type 2


For me it is necessary to ensure that dma_alloc_coherent in
rproc_alloc_vring is called after carveout allocation
just because dma_alloc_cohorent takes mermory from preallocated pool which
starts at 0x0. I also don't have
any other advance mechanism how to ensure mapping for the second arm core.

Here is log which I need to get. Look at attached patch which exactly show
you what I need to do which I have tested.
Maybe it is not big deal and I can use mainline remoteproc version and use
this patch to be in sync with mainline code.

zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20,
flags 0
zynq_remoteproc 0.remoteproc-test: carveout va d1000000, dma 0, len 0x20ec20
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 2
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0,
2 vrings
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, qsz 256,
align 4096
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256,
align 4096
zynq_remoteproc 0.remoteproc-test: vring0: va d1400000 dma 400000 size 3000
idr 0
zynq_remoteproc 0.remoteproc-test: vring1: va d1404000 dma 404000 size 3000
idr 1
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2353146
zynq_remoteproc 0.remoteproc-test: iommu not found
zynq_remoteproc 0.remoteproc-test: rsc: type 0
zynq_remoteproc 0.remoteproc-test: rsc: type 3
zynq_remoteproc 0.remoteproc-test: rsc: type 2

Thanks,
Michal

--047d7b33d50ea834b104c08b84eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ohad,<br><br><div class=3D"gmail_quote">2012/5/17 Ohad Ben-Cohen <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:ohad@wizery.com" target=3D"_blank">ohad@wi=
zery.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Michal,<br>
<div class=3D"im"><br>
On Sat, Mar 17, 2012 at 8:39 AM, Ohad Ben-Cohen &lt;<a href=3D"mailto:ohad@=
wizery.com">ohad@wizery.com</a>&gt; wrote:<br>
&gt; IOW: you can probably just wait a bit until this patch is ready and<br=
>
&gt; take it into your tree. It will most likely bring back the behavior yo=
u<br>
&gt; need :)<br>
<br>
</div>Does something like the attached help ?<br></blockquote><div><br>I ha=
ve looked at it and tested on latest and greatest and the problem is still =
there.=A0 If you look at debug output below<br>you see that vrings are allo=
cated before carveout area which is causing that rtos text is not placed at=
 0x0 address. <br>
<br>I have looked at the code and path is <br>rproc_fw_config_virtio -&gt; =
rproc_handliefirtion_rsc -&gt; rproc_handle_vdev<br><br><br>
~ # zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0<=
br>
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3<br>
zynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0, =
2 vrings<br>
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, qsz 256, al=
ign 256<br>
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256, al=
ign 256<br>
zynq_remoteproc 0.remoteproc-test: vring0: va d1000000 dma 0 size 2000 idr =
0<br>
zynq_remoteproc 0.remoteproc-test: vring1: va d1002000 dma 2000 size 2000 i=
dr 1<br>
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test<br>
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2353146<br>
zynq_remoteproc 0.remoteproc-test: iommu not found<br>
zynq_remoteproc 0.remoteproc-test: rsc: type 0<br>
zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20, fl=
ags 0<br>
zynq_remoteproc 0.remoteproc-test: carveout va d1400000, dma 400000, len 0x=
20ec20<br>
zynq_remoteproc 0.remoteproc-test: rsc: type 3<br>
zynq_remoteproc 0.remoteproc-test: rsc: type 2<br>
<br><br>For me it is necessary to ensure that dma_alloc_coherent in rproc_a=
lloc_vring is called after carveout allocation<br>just because dma_alloc_co=
horent takes mermory from preallocated pool which starts at 0x0. I also don=
&#39;t have<br>
any other advance mechanism how to ensure mapping for the second arm core.<=
br><br>Here is log which I need to get. Look at attached patch which exactl=
y show you what I need to do which I have tested.<br>Maybe it is not big de=
al and I can use mainline remoteproc version and use this patch to be in sy=
nc with mainline code.<br>
<br>zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0<=
br>zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20,=
 flags 0<br>zynq_remoteproc 0.remoteproc-test: carveout va d1000000, dma 0,=
 len 0x20ec20<br>
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3<br>z=
ynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 2<br>zy=
nq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0<br>
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3<br>z=
ynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0, 2=
 vrings<br>zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, =
qsz 256, align 4096<br>
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256, al=
ign 4096<br>zynq_remoteproc 0.remoteproc-test: vring0: va d1400000 dma 4000=
00 size 3000 idr 0<br>zynq_remoteproc 0.remoteproc-test: vring1: va d140400=
0 dma 404000 size 3000 idr 1<br>
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test<br>zynq_re=
moteproc 0.remoteproc-test: Booting fw image test, size 2353146<br>zynq_rem=
oteproc 0.remoteproc-test: iommu not found<br>zynq_remoteproc 0.remoteproc-=
test: rsc: type 0<br>
zynq_remoteproc 0.remoteproc-test: rsc: type 3<br>zynq_remoteproc 0.remotep=
roc-test: rsc: type 2<br><br>Thanks,<br>Michal<br></div></div>

--047d7b33d50ea834b104c08b84eb--

--047d7b33d50ea834be04c08b84ed
Content-Type: application/octet-stream;
	name="0001-remoteproc-Allocate-carveout-area-before-vrings-allo.patch"
Content-Disposition: attachment;
	filename="0001-remoteproc-Allocate-carveout-area-before-vrings-allo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2hixj061

RnJvbSA0ODI1MGZhZWQ3YWVhZTdlOTY4YzM3NzkyMjFmYjQxMzIzOGUzYzYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWwgU2ltZWsgPG1vbnN0ckBtb25zdHIuZXU+CkRhdGU6
IE1vbiwgMjEgTWF5IDIwMTIgMTQ6MzA6NDUgKzAyMDAKU3ViamVjdDogW1BBVENIXSByZW1vdGVw
cm9jOiBBbGxvY2F0ZSBjYXJ2ZW91dCBhcmVhIGJlZm9yZSB2cmluZ3MgYWxsb2F0aW9uCgpaeW5x
IHJlcXVpcmVzIHRvIGNhcnZlb3V0IGFsbG9jYXRpb24gYmVmb3JlIHZyaW5ncwpiZWNhdXNlIGZp
cm13YXJlIG11c3QgYmUgcGxhY2VkIGZyb20gYWRkcmVzcyAweDAuClRoZXJlIGlzIG5vIGFueSBv
dGhlciBhZHZhbmNlIG1lY2hhbmlzbSB0byBiZSBhYmxlIHRvIHJlbWFwCmFkZHJlc3NlcyBmb3Ig
cmVtb3RlcHJvYy4gWnlucSBpcyB1c2luZyB0aGUgc2Vjb25kIGFybSBjb3JlLgoKU2lnbmVkLW9m
Zi1ieTogTWljaGFsIFNpbWVrIDxtb25zdHJAbW9uc3RyLmV1PgotLS0KIGRyaXZlcnMvcmVtb3Rl
cHJvYy9yZW1vdGVwcm9jX2NvcmUuYyB8ICAgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyBiL2Ry
aXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYwppbmRleCA0MGUyYjJkLi45NDM0ODYx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMKKysrIGIv
ZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jCkBAIC03NDgsNyArNzQ4LDcgQEAg
ZnJlZV9tYXBwaW5nOgogICogZW51bSBmd19yZXNvdXJjZV90eXBlLgogICovCiBzdGF0aWMgcnBy
b2NfaGFuZGxlX3Jlc291cmNlX3QgcnByb2NfaGFuZGxlX3JzY1tdID0gewotCVtSU0NfQ0FSVkVP
VVRdID0gKHJwcm9jX2hhbmRsZV9yZXNvdXJjZV90KXJwcm9jX2hhbmRsZV9jYXJ2ZW91dCwKKwlb
UlNDX0NBUlZFT1VUXSA9IE5VTEwsCiAJW1JTQ19ERVZNRU1dID0gKHJwcm9jX2hhbmRsZV9yZXNv
dXJjZV90KXJwcm9jX2hhbmRsZV9kZXZtZW0sCiAJW1JTQ19UUkFDRV0gPSAocnByb2NfaGFuZGxl
X3Jlc291cmNlX3QpcnByb2NfaGFuZGxlX3RyYWNlLAogCVtSU0NfVkRFVl0gPSBOVUxMLCAvKiBW
REVWcyB3ZXJlIGhhbmRsZWQgdXBvbiByZWdpc3RyYXJpb24gKi8KQEAgLTc5Myw2ICs3OTMsNDAg
QEAgcnByb2NfaGFuZGxlX2Jvb3RfcnNjKHN0cnVjdCBycHJvYyAqcnByb2MsIHN0cnVjdCByZXNv
dXJjZV90YWJsZSAqdGFibGUsIGludCBsZW4KIAlyZXR1cm4gcmV0OwogfQogCisvKiBoYW5kbGUg
Y2FydmVvdXQgZmlybXdhcmUgcmVzb3VyY2UgZW50cmllcyB3aGlsZSByZWdpc3RlcmluZyB0aGUg
cmVtb3RlIHByb2Nlc3NvciAqLworc3RhdGljIGludAorcnByb2NfaGFuZGxlX2NhcnZlb3V0X3Jz
YyhzdHJ1Y3QgcnByb2MgKnJwcm9jLCBzdHJ1Y3QgcmVzb3VyY2VfdGFibGUgKnRhYmxlLCBpbnQg
bGVuKQoreworCXN0cnVjdCBkZXZpY2UgKmRldiA9IHJwcm9jLT5kZXY7CisJaW50IHJldCA9IDAs
IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgdGFibGUtPm51bTsgaSsrKSB7CisJCWludCBvZmZzZXQg
PSB0YWJsZS0+b2Zmc2V0W2ldOworCQlzdHJ1Y3QgZndfcnNjX2hkciAqaGRyID0gKHZvaWQgKil0
YWJsZSArIG9mZnNldDsKKwkJaW50IGF2YWlsID0gbGVuIC0gb2Zmc2V0IC0gc2l6ZW9mKCpoZHIp
OworCQlzdHJ1Y3QgZndfcnNjX2NhcnZlb3V0ICpjcnNjOworCisJCS8qIG1ha2Ugc3VyZSB0YWJs
ZSBpc24ndCB0cnVuY2F0ZWQgKi8KKwkJaWYgKGF2YWlsIDwgMCkgeworCQkJZGV2X2VycihkZXYs
ICJyc2MgdGFibGUgaXMgdHJ1bmNhdGVkXG4iKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CisK
KwkJZGV2X2RiZyhkZXYsICIlczogcnNjIHR5cGUgJWRcbiIsIF9fZnVuY19fLCBoZHItPnR5cGUp
OworCisJCWlmIChoZHItPnR5cGUgIT0gUlNDX0NBUlZFT1VUKQorCQkJY29udGludWU7CisKKwkJ
Y3JzYyA9IChzdHJ1Y3QgZndfcnNjX2NhcnZlb3V0ICopaGRyLT5kYXRhOworCisJCXJldCA9IHJw
cm9jX2hhbmRsZV9jYXJ2ZW91dChycHJvYywgY3JzYywgYXZhaWwpOworCQlpZiAocmV0KQorCQkJ
YnJlYWs7CisJfQorCisJcmV0dXJuIHJldDsKK30KKwogLyogaGFuZGxlIGZpcm13YXJlIHJlc291
cmNlIGVudHJpZXMgd2hpbGUgcmVnaXN0ZXJpbmcgdGhlIHJlbW90ZSBwcm9jZXNzb3IgKi8KIHN0
YXRpYyBpbnQKIHJwcm9jX2hhbmRsZV92aXJ0aW9fcnNjKHN0cnVjdCBycHJvYyAqcnByb2MsIHN0
cnVjdCByZXNvdXJjZV90YWJsZSAqdGFibGUsIGludCBsZW4pCkBAIC0xMTA1LDYgKzExMzksMTEg
QEAgc3RhdGljIHZvaWQgcnByb2NfZndfY29uZmlnX3ZpcnRpbyhjb25zdCBzdHJ1Y3QgZmlybXdh
cmUgKmZ3LCB2b2lkICpjb250ZXh0KQogCWlmICghdGFibGUpCiAJCWdvdG8gb3V0OwogCisJLyog
bG9vayBmb3IgY2FydmVvdXQgYXJlYXMgYW5kIHJlZ2lzdGVyIHRoZW0gZmlyc3QgKi8KKwlyZXQg
PSBycHJvY19oYW5kbGVfY2FydmVvdXRfcnNjKHJwcm9jLCB0YWJsZSwgdGFibGVzeik7CisJaWYg
KHJldCkKKwkJZ290byBvdXQ7CisKIAkvKiBsb29rIGZvciB2aXJ0aW8gZGV2aWNlcyBhbmQgcmVn
aXN0ZXIgdGhlbSAqLwogCXJldCA9IHJwcm9jX2hhbmRsZV92aXJ0aW9fcnNjKHJwcm9jLCB0YWJs
ZSwgdGFibGVzeik7CiAJaWYgKHJldCkKLS0gCjEuNy4wLjQKCg==
--047d7b33d50ea834be04c08b84ed
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--047d7b33d50ea834be04c08b84ed--
