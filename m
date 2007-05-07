From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: TSC2046 touchscreen support for 2430
Date: Mon, 7 May 2007 15:53:38 +0530
Message-ID: <5d5443650705070323r7ffa5e3bi9bc4e7b42574a8bc@mail.gmail.com>
References: <20070504214028.649198901@mvista.com>
	<20070504214039.632228613@mvista.com>
	<3a5b1be00705050128m7de63c62hc5f1c34eb1f91613@mail.gmail.com>
	<5d5443650705070202w50514779o9066e482f67d2019@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_78044_1514672.1178533418588"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650705070202w50514779o9066e482f67d2019@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_78044_1514672.1178533418588
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/7/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> Tony,
>
> On 5/5/07, Komal Shah <komal.shah802003@gmail.com> wrote:
> > Kevin,
> >
> > On 5/5/07, Kevin Hilman <khilman@mvista.com> wrote:
> > > This is a rework of the tsc2046 driver from TI's tree, based
> > > on the tsc2301 driver and using the new SPI framework.
> > >
> > > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> >
> > Very small changes required in order to confirm CodingStyle.
> >
>
> I have attached two patches implementing changes as suggested by
> Komal. They are compile tested only.
>

Attached 3rd patch fixes suspend/resume functions, as TSC2046 is TS
only device not like TSC2301, so we don't need to make non-static
functions like TSC2301_TS which gets called from it's core driver on
suspend/resume.

This patch is also compile-tested only. Kevin please test it.

-- 
--Trilok Soni

------=_Part_78044_1514672.1178533418588
Content-Type: text/x-patch;
	name=0003-SPI-TSC2046-Fix-supend-resume-functions.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1esc5r8
Content-Disposition: attachment;
	filename="0003-SPI-TSC2046-Fix-supend-resume-functions.patch"

RnJvbSA3N2Q0YWUxOTNiZGQyNzViZmZhY2Q2ZTQ0Njc2ODc2NGM3OTAyZGQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmlsb2sgU29uaSA8c29uaS50cmlsb2tAZ21haWwuY29tPgpE
YXRlOiBNb24sIDcgTWF5IDIwMDcgMjE6MjE6MTUgKzA1MzAKU3ViamVjdDogW1BBVENIXSBTUEk6
IFRTQzIwNDYgRml4IHN1cGVuZC9yZXN1bWUgZnVuY3Rpb25zCgotIEFkZCBzdXNwZW5kLCByZXN1
bWUgZnVuY3Rpb24gdG8gdHNjMjA0NiBkZXZpY2UgZHJpdmVyLgotIENoYW5nZSB0c2MyMDQ2X3N1
c3BlbmQvcmVzdW1lIGZ1bmN0aW9uIGFjY29yYWRpbmdseSwKICBhcyB0c2MyMDQ2IGlzIFRTIG9u
bHkgZGV2aWNlIG5vdCBsaWtlIFRTQzIzMDEuCgpTaWduZWQtb2ZmLWJ5OiBUcmlsb2sgU29uaSA8
c29uaS50cmlsb2tAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vdHNj
MjA0Nl90cy5jIHwgICAxMiArKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNo
c2NyZWVuL3RzYzIwNDZfdHMuYyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vdHNjMjA0Nl90
cy5jCmluZGV4IGE1MDk5ODYuLjQ2ODlmYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvdG91
Y2hzY3JlZW4vdHNjMjA0Nl90cy5jCisrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vdHNj
MjA0Nl90cy5jCkBAIC0yNTUsOCArMjU1LDkgQEAgc3RhdGljIHZvaWQgdHNjMjA0Nl90c19lbmFi
bGUoc3RydWN0IHRzYzIwNDYgKnRzYykKIH0KIAogI2lmZGVmIENPTkZJR19QTQotaW50IHRzYzIw
NDZfdHNfc3VzcGVuZChzdHJ1Y3QgdHNjMjA0NiAqdHNjKQorc3RhdGljIGludCB0c2MyMDQ2X3N1
c3BlbmQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgcG1fbWVzc2FnZV90IG1lc2cpCiB7CisJc3Ry
dWN0IHRzYzIwNDYgKnRzYyA9IGRldl9nZXRfZHJ2ZGF0YSgmc3BpLT5kZXYpOwogCXN0cnVjdCB0
c2MyMDQ2X3RzICp0cyA9IHRzYy0+dHM7CiAKIAlzcGluX2xvY2tfaXJxKCZ0cy0+bG9jayk7CkBA
IC0yNjYsMTMgKzI2NywxNiBAQCBpbnQgdHNjMjA0Nl90c19zdXNwZW5kKHN0cnVjdCB0c2MyMDQ2
ICp0c2MpCiAJcmV0dXJuIDA7CiB9CiAKLXZvaWQgdHNjMjA0Nl90c19yZXN1bWUoc3RydWN0IHRz
YzIwNDYgKnRzYykKK3N0YXRpYyBpbnQgdHNjMjA0Nl9yZXN1bWUoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSkKIHsKKwlzdHJ1Y3QgdHNjMjA0NiAqdHNjID0gZGV2X2dldF9kcnZkYXRhKCZzcGktPmRl
dik7CiAJc3RydWN0IHRzYzIwNDZfdHMgKnRzID0gdHNjLT50czsKIAogCXNwaW5fbG9ja19pcnEo
JnRzLT5sb2NrKTsKIAl0c2MyMDQ2X3RzX2VuYWJsZSh0c2MpOwogCXNwaW5fdW5sb2NrX2lycSgm
dHMtPmxvY2spOworCisJcmV0dXJuIDA7CiB9CiAjZW5kaWYKIApAQCAtNTM2LDYgKzU0MCwxMCBA
QCBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgdHNjMjA0Nl9kcml2ZXIgPSB7CiAJfSwKIAkucHJv
YmUgPSB0c2MyMDQ2X3Byb2JlLAogCS5yZW1vdmUgPSBfX2RldmV4aXRfcCh0c2MyMDQ2X3JlbW92
ZSksCisjaWZkZWYgQ09ORklHX1BNCisJLnN1c3BlbmQgPSB0c2MyMDQ2X3N1c3BlbmQsCisJLnJl
c3VtZSA9IHRzYzIwNDZfcmVzdW1lLAorI2VuZGlmCiB9OwogCiBzdGF0aWMgaW50IF9faW5pdCB0
c2MyMDQ2X2luaXQodm9pZCkKLS0gCjEuNS4wCgo=
------=_Part_78044_1514672.1178533418588
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_78044_1514672.1178533418588--
