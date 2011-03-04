From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Integration branch base switchover to Tony's omap-for-linus branch
Date: Fri, 4 Mar 2011 22:13:38 +0530
Message-ID: <58ec7480fe87b4d64c33cb2c4454a805@mail.gmail.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com>
 <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com>
 <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd6c92420e25e049daad918
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38111 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759580Ab1CDQnm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 11:43:42 -0500
Received: by mail-qy0-f176.google.com with SMTP id 30so2312908qyk.14
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 08:43:40 -0800 (PST)
In-reply-to: <4D70F25C.4040206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

--000e0cd6c92420e25e049daad918
Content-Type: text/plain; charset=ISO-8859-1

Rajendra,

> -----Original Message-----
> From: Rajendra Nayak [mailto:rnayak@ti.com]
> Sent: Friday, March 04, 2011 7:38 PM
> To: Paul Walmsley
> Cc: Santosh Shilimkar; linux-omap@vger.kernel.org
> Subject: Re: Integration branch base switchover to Tony's omap-for-
> linus branch
>
> Hi Paul,
>
> On Thursday 03 March 2011 06:00 PM, Rajendra Nayak wrote:
> > Hi Paul,
> >
> > On Wednesday 02 March 2011 03:03 AM, Paul Walmsley wrote:
> >> Hi Santosh
> >>
> >> On Tue, 1 Mar 2011, Santosh Shilimkar wrote:
> >>
> >>>> -----Original Message-----
> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> >>>> Sent: Saturday, February 26, 2011 5:56 AM
> >>>> To: linux-omap@vger.kernel.org
> >>>> Subject: Integration branch base switchover to Tony's omap-for-
> linus
> >>>> branch
> >>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> this is a quick note for anyone using the integration-2.6.39
> branch
> >>>> on
> >>>> git://git.pwsan.com/linux-2.6: I've switched the base over from
> >>>> mainline to Tony's omap-for-linus branch.
> >>>>
> >>>
> >>> I observed an issue when integrated omap-for-linus + your branch
> >>> + OMAP4 PM patches. After debugging this with Rajendra, it seems
> >>> that issue is seen only when static dependency between MPU
> >>> and L4PER clock-domain is cleared _and_ L4_PER clock-domain
> >>> is programmed to HW_SUP.
> >>>
> >>> Since the issue is observed with only I2C IP block from L4_PER
> >>> and none of the other modules are affected, the suspect is I2C
> >>> IP block. The hardware team is investigating this issue.
> >>>
> >>> So for now, to avoid this abort, there are two options
> >>> - Remove HW_SUP from L4_PER CD
> >>> - Keep MPU<->L4_PER static dependency.
> >>>
> >>> We tried both the options and they seems to work.
> >>> Which one you prefer till we have hardware root-cause
> >>> of this issue?
> >>
> >> Between the two alternatives you suggested, I'd prefer #1; but
> could you
> >> try forcing the I2C blocks to use software idle control instead
> and
> >> see if
> >> that fixes it without the need to change the clockdomains file?
> Sample
> >> patch follows. If that fixes it, it might be useful to know
> whether it is
> >> the HWMOD_SWSUP_SIDLE flag or HWMOD_NO_OCP_AUTOIDLE flag or both
> that is
> >> required.
> >
> > Yes, it does seem to fix the issue also, and its the
> HWMOD_SWSUP_SIDLE
> > that apparently makes a difference. HWMOD_NO_OCP_AUTOIDLE alone
> does
> > not fix it.
>
> Some more debugging by the Hardware team and analyzing
> the register dumps showed that the I2C_WE register of the i2c
> modules needs to be programmed correctly for i2c wakeups to
> function as expected.
> This turned out to be the root cause for the i2c issues observed
> by clearing the staticdeps and a patch has been posted
> to address this...
> http://marc.info/?l=linux-omap&m=129924557219813&w=2
>
> >
> > Also some more testing showed up a lockup in suspend on OMAP4
> which I
> > could narrow down to a similar case with GPT1. Either keeping the
> > staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use
> software
> > idle control seems to help.
>
> This however is still not rootcaused and is not the same as the
> issue
> seen with i2c as the WE for GPT1 is already programmed for enabling
> wakeup.
>
> The one way to fix this for now is to put GPT1 block in software
> controlled idle as was done by your test patch for i2c.
>
I tried all the floating patches for static dependency. It did
worked when CPU RET was tried but with MPU OFF I see the hang.

Below is the global hack I have which works as expected for
all cases.

---
>From cd14eb718a7e909e32a5d1916517ae76312f0557 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 3 Mar 2011 15:10:07 +0530
Subject: [PATCH] omap4: static-deps: Temporary hack to disable mpu
wakupdeps

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index a607ec1..3c89bcc 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -281,6 +281,7 @@ static struct clkdm_dep l4_secure_wkup_sleep_deps[] =
{
 };

 static struct clkdm_dep mpuss_wkup_sleep_deps[] = {
+#if 0
 	{
 		.clkdm_name	 = "abe_clkdm",
 		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
@@ -337,6 +338,7 @@ static struct clkdm_dep mpuss_wkup_sleep_deps[] = {
 		.clkdm_name	 = "tesla_clkdm",
 		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
 	},
+#endif
 	{ NULL },
 };

-- 
1.6.0.4

--000e0cd6c92420e25e049daad918
Content-Type: application/octet-stream;
	name="0001-omap4-static-deps-Temporary-hack-to-disable-mpu-wa.patch"
Content-Disposition: attachment;
	filename="0001-omap4-static-deps-Temporary-hack-to-disable-mpu-wa.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee2c450960e2e7f7_0.1

RnJvbSBjZDE0ZWI3MThhN2U5MDllMzJhNWQxOTE2NTE3YWU3NjMxMmYwNTU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDMgTWFyIDIwMTEgMTU6MTA6MDcgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBvbWFwNDogc3RhdGljLWRlcHM6IFRlbXBvcmFyeSBoYWNrIHRvIGRpc2FibGUgbXB1IHdh
a3VwZGVwcwoKU2lnbmVkLW9mZi1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlt
a2FyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2Nsb2NrZG9tYWluczQ0eHhfZGF0
YS5jIHwgICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9ja2RvbWFpbnM0NHh4
X2RhdGEuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvY2xvY2tkb21haW5zNDR4eF9kYXRhLmMKaW5k
ZXggYTYwN2VjMS4uM2M4OWJjYyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9j
a2RvbWFpbnM0NHh4X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Nsb2NrZG9tYWlu
czQ0eHhfZGF0YS5jCkBAIC0yODEsNiArMjgxLDcgQEAgc3RhdGljIHN0cnVjdCBjbGtkbV9kZXAg
bDRfc2VjdXJlX3drdXBfc2xlZXBfZGVwc1tdID0gewogfTsKIAogc3RhdGljIHN0cnVjdCBjbGtk
bV9kZXAgbXB1c3Nfd2t1cF9zbGVlcF9kZXBzW10gPSB7CisjaWYgMAogCXsKIAkJLmNsa2RtX25h
bWUJID0gImFiZV9jbGtkbSIsCiAJCS5vbWFwX2NoaXAJID0gT01BUF9DSElQX0lOSVQoQ0hJUF9J
U19PTUFQNDQzMCkKQEAgLTMzNyw2ICszMzgsNyBAQCBzdGF0aWMgc3RydWN0IGNsa2RtX2RlcCBt
cHVzc193a3VwX3NsZWVwX2RlcHNbXSA9IHsKIAkJLmNsa2RtX25hbWUJID0gInRlc2xhX2Nsa2Rt
IiwKIAkJLm9tYXBfY2hpcAkgPSBPTUFQX0NISVBfSU5JVChDSElQX0lTX09NQVA0NDMwKQogCX0s
CisjZW5kaWYKIAl7IE5VTEwgfSwKIH07CiAKLS0gCjEuNi4wLjQKCg==
--000e0cd6c92420e25e049daad918--
