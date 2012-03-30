From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 13:11:35 +0530
Message-ID: <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com> <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com> <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00235452f5d89c022504bc70f937
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:37011 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751741Ab2C3Hl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 03:41:59 -0400
Received: by qcsd15 with SMTP id d15so211333qcs.11
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 00:41:57 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

--00235452f5d89c022504bc70f937
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 12:04 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote=
:
> On Wed, Mar 28, 2012 at 20:19:07, Shilimkar, Santosh wrote:
>> On Wed, Mar 28, 2012 at 8:07 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wro=
te:
>> > On Wed, Mar 28, 2012 at 19:50:02, Shilimkar, Santosh wrote:
>> >> On Wed, Mar 28, 2012 at 7:46 PM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
>> >> > On Wed, Mar 21, 2012 at 19:30:01, Shilimkar, Santosh wrote:
>> >> >> On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav@ti.co=
m> wrote:
>> >> >> > On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
>> >> >> >> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
>> >> >> >> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@=
ti.com> wrote:
>> >>
[...]

>> I thought so and now if you look at last part of my comment.
>>
>> Rating of 32K based synctimer and 32K based GPTIMER
>> should be same because of the precision. That's the main
>> point why I was saying that GPTIMER is not a better
>> clock-source( with 32k clock src) =A0than sync timer when
>> both are enabled together.
>>
>
> Santosh,
>
> In case of OMAP, we are using timer 2 for clocksource
>
> OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
> OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
>
> And timer2 as clocksource is never used, since we have CONFIG_OMAP_32K_TI=
MER
> defined in our defconfig.
>
> Also, after looking at the code, I came across another problem, setup_sch=
ed_clock(). But this can be easily fixed, if we source both the timers with=
 same clock (here 32k_fck).
>
>
> Let me propose this,
>
> How about, if I keep timer2 source always set to 32k_fclk for omap2,3,4?
> And also, as mentioned by Santosh, I will register both the clocks as
> clocksource with the same rating.
> By default, kernel is going to use 32k_counter as a clocksource, and thro=
ugh
> Command prompt user can override it without any issues.
>
> Just to make sure that, whatever I am trying to propse here works and don=
't get into unknown issue; I changed my code for this, and it is working fo=
r me without any issues.

Let's not make this more complicated. I guess below simple patch should sor=
t
out the issue. I briefly tested it on OMAP4 and it works. let me know
if it helps AMxxx machines.

Regards
Santosh

>From 0a9283e26174d76ff2753ac88521b61a26b24e8f Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 30 Mar 2012 12:43:29 +0530
Subject: [PATCH] ARM: OMAP: Make OMAP clocksource source selection runtime.

Current OMAP code support couple of clocksource options based on compilatio=
n
flag. The 32KHz based sync timer and a gptimer based clock source which can
run on 32KHz or system clock (e.g 38.4 MHz). So there can be 3 options.

1. 32KHz synctimer
2. Sysclock based(e.g 38.4 MHz) gptimer
3. 32KHz based gptimer.

The optional gptimer based clocksource was added so that it can give the
high precision than synctimer so expected usage was 2 and not 3. Unfortunat=
lly
option 2, clocksource doesn't meet the requirement of free-running clock
as per clocksource need. It stops in low power states when  sysclock is cut=
.
That makes gptimer based clocksource option useless for OMAP2/3/4 devices
with sysclock as a clock input. Option 3 will still work but it is no bette=
r'
than 32K synctimer based clocksource.

So ideally we can kill the gptimer based clocksource option but there are s=
ome
OMAP based derivative SoCs like AMXXXX which doesn't have synictimer hardwa=
re IP
and need to fallback on 32KHz based gptimer clocksource.

Considering above, make synctimer and gptimer clocksource runtime
selectable so that both OMAP and AMXXXX continue to use the same code.

Not-yet-signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c512bac..3878e59 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -234,21 +234,6 @@ static void __init omap2_gp_clockevent_init(int gptime=
r_id,
 }

 /* Clocksource code */
-
-#ifdef CONFIG_OMAP_32K_TIMER
-/*
- * When 32k-timer is enabled, don't use GPTimer for clocksource
- * instead, just leave default clocksource which uses the 32k
- * sync counter.  See clocksource setup in plat-omap/counter_32k.c
- */
-
-static void __init omap2_gp_clocksource_init(int unused, const char *dummy=
)
-{
-	omap_init_clocksource_32k();
-}
-
-#else
-
 static struct omap_dm_timer clksrc;

 /*
@@ -276,7 +261,7 @@ static u32 notrace dmtimer_read_sched_clock(void)
 }

 /* Setup free-running counter for clocksource */
-static void __init omap2_gp_clocksource_init(int gptimer_id,
+static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
 {
 	int res;
@@ -295,7 +280,13 @@ static void __init omap2_gp_clocksource_init(int
gptimer_id,
 		pr_err("Could not register clocksource %s\n",
 			clocksource_gpt.name);
 }
-#endif
+
+static void __init omap2_gp_clocksource_init(int gptimer_id,
+                                                const char *fck_source)
+{
+	if (omap_init_clocksource_32k())
+		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
+}

 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
 				clksrc_nr, clksrc_src)			\
--=20
1.7.5.4

--00235452f5d89c022504bc70f937
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Make-OMAP-clocksource-source-selection-runt.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Make-OMAP-clocksource-source-selection-runt.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0exbbtb0

RnJvbSAwYTkyODNlMjYxNzRkNzZmZjI3NTNhYzg4NTIxYjYxYTI2YjI0ZThmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBGcmksIDMwIE1hciAyMDEyIDEyOjQzOjI5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBPTUFQOiBNYWtlIE9NQVAgY2xvY2tzb3VyY2Ugc291cmNlIHNlbGVjdGlvbiBy
dW50aW1lLgoKQ3VycmVudCBPTUFQIGNvZGUgc3VwcG9ydCBjb3VwbGUgb2YgY2xvY2tzb3VyY2Ug
b3B0aW9ucyBiYXNlZCBvbiBjb21waWxhdGlvbgpmbGFnLiBUaGUgMzJLSHogYmFzZWQgc3luYyB0
aW1lciBhbmQgYSBncHRpbWVyIGJhc2VkIGNsb2NrIHNvdXJjZSB3aGljaCBjYW4KcnVuIG9uIDMy
S0h6IG9yIHN5c3RlbSBjbG9jayAoZS5nIDM4LjQgTUh6KS4gU28gdGhlcmUgY2FuIGJlIDMgb3B0
aW9ucy4KCjEuIDMyS0h6IHN5bmN0aW1lcgoyLiBTeXNjbG9jayBiYXNlZChlLmcgMzguNCBNSHop
IGdwdGltZXIKMy4gMzJLSHogYmFzZWQgZ3B0aW1lci4KClRoZSBvcHRpb25hbCBncHRpbWVyIGJh
c2VkIGNsb2Nrc291cmNlIHdhcyBhZGRlZCBzbyB0aGF0IGl0IGNhbiBnaXZlIHRoZQpoaWdoIHBy
ZWNpc2lvbiB0aGFuIHN5bmN0aW1lciBzbyBleHBlY3RlZCB1c2FnZSB3YXMgMiBhbmQgbm90IDMu
IFVuZm9ydHVuYXRsbHkKb3B0aW9uIDIsIGNsb2Nrc291cmNlIGRvZXNuJ3QgbWVldCB0aGUgcmVx
dWlyZW1lbnQgb2YgZnJlZS1ydW5uaW5nIGNsb2NrCmFzIHBlciBjbG9ja3NvdXJjZSBuZWVkLiBJ
dCBzdG9wcyBpbiBsb3cgcG93ZXIgc3RhdGVzIHdoZW4gIHN5c2Nsb2NrIGlzIGN1dC4KVGhhdCBt
YWtlcyBncHRpbWVyIGJhc2VkIGNsb2Nrc291cmNlIG9wdGlvbiB1c2VsZXNzIGZvciBPTUFQMi8z
LzQgZGV2aWNlcwp3aXRoIHN5c2Nsb2NrIGFzIGEgY2xvY2sgaW5wdXQuIE9wdGlvbiAzIHdpbGwg
c3RpbGwgd29yayBidXQgaXQgaXMgbm8gYmV0dGVyJwp0aGFuIDMySyBzeW5jdGltZXIgYmFzZWQg
Y2xvY2tzb3VyY2UuCgpTbyBpZGVhbGx5IHdlIGNhbiBraWxsIHRoZSBncHRpbWVyIGJhc2VkIGNs
b2Nrc291cmNlIG9wdGlvbiBidXQgdGhlcmUgYXJlIHNvbWUKT01BUCBiYXNlZCBkZXJpdmF0aXZl
IFNvQ3MgbGlrZSBBTVhYWFggd2hpY2ggZG9lc24ndCBoYXZlIHN5bmljdGltZXIgaGFyZHdhcmUg
SVAKYW5kIG5lZWQgdG8gZmFsbGJhY2sgb24gMzJLSHogYmFzZWQgZ3B0aW1lciBjbG9ja3NvdXJj
ZS4KCkNvbnNpZGVyaW5nIGFib3ZlLCBtYWtlIHN5bmN0aW1lciBhbmQgZ3B0aW1lciBjbG9ja3Nv
dXJjZSBydW50aW1lCnNlbGVjdGFibGUgc28gdGhhdCBib3RoIE9NQVAgYW5kIEFNWFhYWCBjb250
aW51ZSB0byB1c2UgdGhlIHNhbWUgY29kZS4KCk5vdC15ZXQtc2lnbmVkLW9mZi1ieTogU2FudG9z
aCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlta2FyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNo
LW9tYXAyL3RpbWVyLmMgfCAgIDI1ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMK
aW5kZXggYzUxMmJhYy4uMzg3OGU1OSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90
aW1lci5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXIuYwpAQCAtMjM0LDIxICsyMzQs
NiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDJfZ3BfY2xvY2tldmVudF9pbml0KGludCBncHRp
bWVyX2lkLAogfQogCiAvKiBDbG9ja3NvdXJjZSBjb2RlICovCi0KLSNpZmRlZiBDT05GSUdfT01B
UF8zMktfVElNRVIKLS8qCi0gKiBXaGVuIDMyay10aW1lciBpcyBlbmFibGVkLCBkb24ndCB1c2Ug
R1BUaW1lciBmb3IgY2xvY2tzb3VyY2UKLSAqIGluc3RlYWQsIGp1c3QgbGVhdmUgZGVmYXVsdCBj
bG9ja3NvdXJjZSB3aGljaCB1c2VzIHRoZSAzMmsKLSAqIHN5bmMgY291bnRlci4gIFNlZSBjbG9j
a3NvdXJjZSBzZXR1cCBpbiBwbGF0LW9tYXAvY291bnRlcl8zMmsuYwotICovCi0KLXN0YXRpYyB2
b2lkIF9faW5pdCBvbWFwMl9ncF9jbG9ja3NvdXJjZV9pbml0KGludCB1bnVzZWQsIGNvbnN0IGNo
YXIgKmR1bW15KQotewotCW9tYXBfaW5pdF9jbG9ja3NvdXJjZV8zMmsoKTsKLX0KLQotI2Vsc2UK
LQogc3RhdGljIHN0cnVjdCBvbWFwX2RtX3RpbWVyIGNsa3NyYzsKIAogLyoKQEAgLTI3Niw3ICsy
NjEsNyBAQCBzdGF0aWMgdTMyIG5vdHJhY2UgZG10aW1lcl9yZWFkX3NjaGVkX2Nsb2NrKHZvaWQp
CiB9CiAKIC8qIFNldHVwIGZyZWUtcnVubmluZyBjb3VudGVyIGZvciBjbG9ja3NvdXJjZSAqLwot
c3RhdGljIHZvaWQgX19pbml0IG9tYXAyX2dwX2Nsb2Nrc291cmNlX2luaXQoaW50IGdwdGltZXJf
aWQsCitzdGF0aWMgdm9pZCBfX2luaXQgb21hcDJfZ3B0aW1lcl9jbG9ja3NvdXJjZV9pbml0KGlu
dCBncHRpbWVyX2lkLAogCQkJCQkJY29uc3QgY2hhciAqZmNrX3NvdXJjZSkKIHsKIAlpbnQgcmVz
OwpAQCAtMjk1LDcgKzI4MCwxMyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDJfZ3BfY2xvY2tz
b3VyY2VfaW5pdChpbnQgZ3B0aW1lcl9pZCwKIAkJcHJfZXJyKCJDb3VsZCBub3QgcmVnaXN0ZXIg
Y2xvY2tzb3VyY2UgJXNcbiIsCiAJCQljbG9ja3NvdXJjZV9ncHQubmFtZSk7CiB9Ci0jZW5kaWYK
Kworc3RhdGljIHZvaWQgX19pbml0IG9tYXAyX2dwX2Nsb2Nrc291cmNlX2luaXQoaW50IGdwdGlt
ZXJfaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBjaGFyICpmY2tfc291cmNlKQoreworCWlmIChvbWFwX2luaXRfY2xvY2tzb3VyY2VfMzJr
KCkpCisJCW9tYXAyX2dwdGltZXJfY2xvY2tzb3VyY2VfaW5pdChncHRpbWVyX2lkLCBmY2tfc291
cmNlKTsKK30KIAogI2RlZmluZSBPTUFQX1NZU19USU1FUl9JTklUKG5hbWUsIGNsa2V2X25yLCBj
bGtldl9zcmMsCQkJXAogCQkJCWNsa3NyY19uciwgY2xrc3JjX3NyYykJCQlcCi0tIAoxLjcuNS40
Cgo=
--00235452f5d89c022504bc70f937--
