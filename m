From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Processing of command line mem=32M
Date: Fri, 12 Jan 2007 06:57:03 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50951CBAE@dlee02.ent.ti.com>
References: <7d8fdf6f0701120307gee02aa1j7ff80e5eac4eefe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73649.289CF1A3"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7d8fdf6f0701120307gee02aa1j7ff80e5eac4eefe9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Raghunandan Dhongadi <dk.raghu@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73649.289CF1A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That is an issue I've heard about a few times.  I looked at it a couple
of weeks back and generated an initial band aid patch which should work,
then a very large patch.  I expect it will take a little time for these
to make there way back onto the ftp site.  Give this a try...

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Raghunandan Dhongadi
> Sent: Friday, January 12, 2007 5:07 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Processing of command line mem=3D32M
>=20
> Hello All,
>=20
> I have Linux kernel 2.6.14-7 for OMAP2430 SDP board. The SDP has 128MB
> of SDRAM memory. I want to share the 128MB into 64MB for ARM core and
> 64MB for DSP core.
> I am giving the kernel command line parameter "mem=3D64M" but with =
this
> the boot process
> stops at "Uncompressing Kernel".
>=20
> But if I give a minimum of "mem=3D113M" it boots fine. Wanted to know
> where does the processing of command line parameters happen and what
> could be the issue ?
>=20
> Warm Regards,
> Raghu
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

------_=_NextPart_001_01C73649.289CF1A3
Content-Type: application/octet-stream;
	name="fix.diff"
Content-Transfer-Encoding: base64
Content-Description: fix.diff
Content-Disposition: attachment;
	filename="fix.diff"

ZGlmZiAtcHVyTiAyLjZfa2VybmVsL2FyY2gvYXJtL21tL2Jsb2Nrb3BzLmMgMi42X2tlcm5lbC1m
aXgvYXJjaC9hcm0vbW0vYmxvY2tvcHMuYwotLS0gMi42X2tlcm5lbC9hcmNoL2FybS9tbS9ibG9j
a29wcy5jCTIwMDYtMDgtMjQgMTY6MjU6NDIuMDAwMDAwMDAwIC0wNTAwCisrKyAyLjZfa2VybmVs
LWZpeC9hcmNoL2FybS9tbS9ibG9ja29wcy5jCTIwMDYtMTItMTIgMDk6MzM6NTEuMDAwMDAwMDAw
IC0wNjAwCkBAIC02OCw3ICs2OCw3IEBAIGJsa19kbWFfaW52X3JhbmdlX2hhcnZhcmQodW5zaWdu
ZWQgbG9uZyAKIAkidHN0CXIwLCAlMAkJCQkJCQkJXG5cCiAJbWNybmUJcDE1LCAwLCByMCwgYzcs
IGMxMCwgMQkJQCBjbGVhbiBEIGxpbmUJCQlcblwKIAl0c3QJcjEsICUwCQkJCQkJCQlcblwKLQlt
Y3JuZQlwMTUsIDAsIHIxLCBjNywgYzEwLCAxCQlAIGNsZWFuIEQgbGluZQkJCVxuXAorCW1jcm5l
CXAxNSwgMCwgcjEsIGM3LCBjMTQsIDEJCUAgY2xlYW4gJiBpbnZhbGlkYXRlIEQgbGluZQlcblwK
IAlzdWIJcjEsIHIxLCAjMQkJCQkJCQlcblwKIAkud29yZAkweGVjNDAxZjA2CUAgbWNycglwMTUs
IDAsIHIxLCByMCwgYzYsIDAJQCBibG9ja2luZwlcblwKIAltb3YJcjAsICMwCQkJCQkJCQlcblwK
QEAgLTg3LDcgKzg3LDggQEAgc3RhdGljIHZvaWQgX19hdHRyaWJ1dGVfXygobmFrZWQpKQogYmxr
X2RtYV9jbGVhbl9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkK
IHsKIAlhc20oCi0JIi53b3JkCTB4ZWM0MDFmMGMJQCBtY3JyCXAxNSwgMCwgcjEsIHIwLCBjMTIs
IDAJQCBibG9ja2luZwlcblwKKwkic3ViIHIxLHIxLCMxIFxuXAorCS53b3JkCTB4ZWM0MDFmMGMJ
QCBtY3JyCXAxNSwgMCwgcjEsIHIwLCBjMTIsIDAJQCBibG9ja2luZwlcblwKIAltb3YJcjAsICMw
CQkJCQkJCQlcblwKIAltY3IJcDE1LCAwLCByMCwgYzcsIGMxMCwgNAkJQCBkcmFpbiB3cml0ZSBi
dWZmZXIJCVxuXAogCW1vdglwYywgbHIiKTsKQEAgLTEwMiw3ICsxMDMsMTAgQEAgc3RhdGljIHZv
aWQgX19hdHRyaWJ1dGVfXygobmFrZWQpKQogYmxrX2RtYV9mbHVzaF9yYW5nZSh1bnNpZ25lZCBs
b25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkKIHsKIAlhc20oCi0JIi53b3JkCTB4ZWM0MDFm
MGUJQCBtY3JyCXAxNSwgMCwgcjEsIHIwLCBjMTQsIDAJQCBibG9ja2luZwlcblwKKwkic3ViCXIx
LCByMSwgIzEJXG5cCisJLndvcmQJMHhlYzQwMWYwZQlAIG1jcnIJcDE1LCAwLCByMSwgcjAsIGMx
NCwgMAlAIGJsb2NraW5nCVxuXAorCW1vdglyMCwgIzAJCQkJCQkJCVxuXAorCW1jcglwMTUsIDAs
IHIwLCBjNywgYzEwLCA0CQlAIGRyYWluIHdyaXRlIGJ1ZmZlcgkJXG5cCiAJbW92CXBjLCBsciIp
OwogfQogCmRpZmYgLXB1ck4gMi42X2tlcm5lbC9hcmNoL2FybS9tbS9wcm9jLXY2LlMgMi42X2tl
cm5lbC1maXgvYXJjaC9hcm0vbW0vcHJvYy12Ni5TCi0tLSAyLjZfa2VybmVsL2FyY2gvYXJtL21t
L3Byb2MtdjYuUwkyMDA2LTA4LTI0IDE2OjI2OjA0LjAwMDAwMDAwMCAtMDUwMAorKysgMi42X2tl
cm5lbC1maXgvYXJjaC9hcm0vbW0vcHJvYy12Ni5TCTIwMDYtMTItMTEgMTU6MzQ6MTQuMDAwMDAw
MDAwIC0wNjAwCkBAIC0yMDksMTEgKzIwOSwxOSBAQCBfX3Y2X3NldHVwOgogCW9ycglyMCwgcjAs
ICMoMHhmIDw8IDIwKQogCW1jcglwMTUsIDAsIHIwLCBjMSwgYzAsIDIJCUAgRW5hYmxlIGZ1bGwg
YWNjZXNzIHRvIFZGUAogI2VuZGlmCisJbGRyCXI1LCA9MHg0MTA3YjM2MAkJCUAgaWQgZm9yIEFS
TTExMzYgcjBwWAorCW1yYwlwMTUsIDAsIHIwLCBjMCwgYzAsIDAJCUAgZ2V0IHByb2Nlc3NvciBp
ZAorCWJpYwlyMCwgcjAsICMweGYJCQlAIG1hc2sgb3V0IHBhcnQgYml0cyBbMzowXQorCXRlcQly
MCwgcjUJCQkJQCBjaGVjayBmb3IgdGhlIGZhdWx0eSBjb3JlCisJbXJjZXEJcDE1LCAwLCByMCwg
YzEsIGMwLCAxCQlAIGxvYWQgYXV4IGNvbnRyb2wgcmVnCisJb3JyZXEJcjAsIHIwLCAjMHg4MDAw
MDAwMAkJQCBzZXQgYml0IDMxCisJbWNyZXEJcDE1LCAwLCByMCwgYzEsIGMwLCAxCQlAIHdyaXRl
IGF1eCBjb250cm9sIHJlZwogCW1yYwlwMTUsIDAsIHIwLCBjMSwgYzAsIDAJCUAgcmVhZCBjb250
cm9sIHJlZ2lzdGVyCiAJbGRyCXI1LCB2Nl9jcjFfY2xlYXIJCUAgZ2V0IG1hc2sgZm9yIGJpdHMg
dG8gY2xlYXIKIAliaWMJcjAsIHIwLCByNQkJCUAgY2xlYXIgYml0cyB0aGVtCiAJbGRyCXI1LCB2
Nl9jcjFfc2V0CQkJQCBnZXQgbWFzayBmb3IgYml0cyB0byBzZXQKIAlvcnIJcjAsIHIwLCByNQkJ
CUAgc2V0IHRoZW0KKwlvcnJlcQlyMCwgcjAsICMweDAwMjAwMDAwCQlAIHNldCB0aGUgRkkgYml0
CiAJbW92CXBjLCBscgkJCQlAIHJldHVybiB0byBoZWFkLlM6X19yZXQKIAogCS8qCmRpZmYgLXB1
ck4gMi42X2tlcm5lbC9pbmNsdWRlL2FzbS1hcm0vdGxiZmx1c2guaCAyLjZfa2VybmVsLWZpeC9p
bmNsdWRlL2FzbS1hcm0vdGxiZmx1c2guaAotLS0gMi42X2tlcm5lbC9pbmNsdWRlL2FzbS1hcm0v
dGxiZmx1c2guaAkyMDA2LTAxLTMxIDAwOjUyOjA3LjAwMDAwMDAwMCAtMDYwMAorKysgMi42X2tl
cm5lbC1maXgvaW5jbHVkZS9hc20tYXJtL3RsYmZsdXNoLmgJMjAwNi0xMi0xMiAwOTo0MjozNi4w
MDAwMDAwMDAgLTA2MDAKQEAgLTM0MCw2ICszNDAsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbG9j
YWxfZmx1c2hfdGxiX2tlcm5lCiAJCWFzbSgibWNyJT8gcDE1LCAwLCAlMCwgYzgsIGM2LCAxIiA6
IDogInIiIChrYWRkcikpOwogCWlmICh0bGJfZmxhZyhUTEJfVjZfSV9QQUdFKSkKIAkJYXNtKCJt
Y3IlPyBwMTUsIDAsICUwLCBjOCwgYzUsIDEiIDogOiAiciIgKGthZGRyKSk7CisKKwlhc20oIm1j
ciBwMTUsIDAsICUwLCBjNywgYzEwLCA0IiA6OiAiciIgKHplcm8pKTsgLyogZml4IDIuNi4xNiAt
IGJhcnJpZXIgdG8gZW5zdXJlIGNvbXBsZXRpb24gKi8KIH0KIAogLyoK

------_=_NextPart_001_01C73649.289CF1A3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C73649.289CF1A3--
