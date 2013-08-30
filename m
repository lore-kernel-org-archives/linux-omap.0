From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
Date: Fri, 30 Aug 2013 11:28:01 +0530
Message-ID: <CAKohpo=q=tE5o75WzCt=T0d2fFBdgLRj8SYoqoBZc3h0XioWLA@mail.gmail.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-3-git-send-email-khilman@ti.com>
	<CAOh2x=k11EivJoy5-PMXnE5JGDc=DcJKhae7qoh6tNc4L63VnA@mail.gmail.com>
	<521F4E88.1000709@ti.com>
	<CAKohpokqz0cQNS12hZS-YOCd8KSOtCy9_TbGdqFzCYz8NyeamQ@mail.gmail.com>
	<521F4FBB.3080002@ti.com>
	<CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2e2bebf33ab04e523e732
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38124 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3H3F6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 01:58:02 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so1772701oah.23
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 22:58:01 -0700 (PDT)
In-Reply-To: <CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Dave Jones <davej@redhat.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

--001a11c2e2bebf33ab04e523e732
Content-Type: text/plain; charset=ISO-8859-1

On 30 August 2013 11:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29 August 2013 19:12, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > On Thursday 29 August 2013 09:39 AM, Viresh Kumar wrote:
> >> On 29 August 2013 19:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >>> On Thursday 29 August 2013 06:02 AM, Viresh Kumar wrote:
> >>
> >>>> cpumask_setall(policy->cpus);
> >>>>
> >>> Thats should work I guess. Infact I changed this i downstream kernel
> >>> a while back but forgot to send a patch. Just see if for some reason
> >>> above can break UP machine since this driver is used on UP machines
> >>> as well. Other than that, it should be fine
> >>
> >> Atleast I can't see why it will break on UP machines as that should set
> >> masks to individual CPUs then...
> >>
> >> Okay I will fix that in my longest patchset ever... 230+ patches already :)
> >>
> > WoW !!
> > Looks like you re-wrote most of the CPUFREQ drivers ;-)
>
> I am trying hard to get rid of redundancy of code wherever possible .. :)
>
> I am pasting my patch here for now (don't want to post
> this separately) as most of the concerned people are following this chain..
>
> I will include it in my patchset and will post it on lists with them (After
> your Ack, which you will give now :) )
>
> --------x-----------------x--------------

OMG, Gmail fucked up completely... What to do now :)

Earlier (few days back):
- We could have selected the plain text mode while sending emails, where
emails are corrupted a bit and so patches couldn't be applied.
- BUT they are atleast readable as it wasn't fucked up so badly..

But today I noticed that gmail has completely removed tabs from mails
(Atleast while pasting code). And so all tabs used for alignments in mail are
gone.. And so aren't even readable anymore..

Deselecting plain text mode, sends it in HTML and that's fucked up too..
Mails gets bounced from our lists (and even then gmail has eaten up
the tabs from code)...

For now see the attached patch, I will send it using git later..

Btw, this is the link to master patch that you may need during reviews..
https://lkml.org/lkml/2013/8/21/485

> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 21 Aug 2013 19:05:05 +0530
> Subject: [PATCH] cpufreq: omap: use cpufreq_generic_init() routine
>
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
>
> This also rearranges the code a bit to make it more sensible. Also removes some
> unnecessary checks.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/omap-cpufreq.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 09150fc..a94c4ef 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -112,50 +112,31 @@ static inline void freq_table_free(void)
>
>  static int omap_cpu_init(struct cpufreq_policy *policy)
>  {
> - int result = 0;
> + int result;
>
>   policy->clk = clk_get(NULL, "cpufreq_ck");
>   if (IS_ERR(policy->clk))
>   return PTR_ERR(policy->clk);
>
> - if (policy->cpu >= NR_CPUS) {
> - result = -EINVAL;
> - goto fail_ck;
> - }
> -
> - if (!freq_table)
> + if (!freq_table) {
>   result = opp_init_cpufreq_table(mpu_dev, &freq_table);
> -
> - if (result) {
> - dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
> + if (result) {
> + dev_err(mpu_dev,
> + "%s: cpu%d: failed creating freq table[%d]\n",
>   __func__, policy->cpu, result);
> - goto fail_ck;
> + goto fail;
> + }
>   }
>
>   atomic_inc_return(&freq_table_users);
>
> - result = cpufreq_table_validate_and_show(policy, freq_table);
> - if (result)
> - goto fail_table;
> -
> - /*
> - * On OMAP SMP configuartion, both processors share the voltage
> - * and clock. So both CPUs needs to be scaled together and hence
> - * needs software co-ordination. Use cpufreq affected_cpus
> - * interface to handle this scenario. Additional is_smp() check
> - * is to keep SMP_ON_UP build working.
> - */
> - if (is_smp())
> - cpumask_setall(policy->cpus);
> -
>   /* FIXME: what's the actual transition time? */
> - policy->cpuinfo.transition_latency = 300 * 1000;
> -
> - return 0;
> + result = cpufreq_generic_init(policy, freq_table, 300 * 1000);
> + if (!result)
> + return 0;
>
> -fail_table:
>   freq_table_free();
> -fail_ck:
> +fail:
>   clk_put(policy->clk);
>   return result;
>  }
>

--001a11c2e2bebf33ab04e523e732
Content-Type: application/octet-stream;
	name="0001-cpufreq-omap-use-cpufreq_generic_init-routine.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-omap-use-cpufreq_generic_init-routine.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkyznzhe0

RnJvbSBhZWNhMTE4MTU0YTYzNjEzMTUyNmQ2N2Y3NmI5YWMxZTI3NDEwYTZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YWVjYTExODE1NGE2MzYxMzE1MjZkNjdmNzZiOWFj
MWUyNzQxMGE2YS4xMzc3ODQxODQyLmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogV2VkLCAyMSBBdWcg
MjAxMyAxOTowNTowNSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGNwdWZyZXE6IG9tYXA6IHVzZSBj
cHVmcmVxX2dlbmVyaWNfaW5pdCgpIHJvdXRpbmUKClVzZSBnZW5lcmljIGNwdWZyZXFfZ2VuZXJp
Y19pbml0KCkgcm91dGluZSBpbnN0ZWFkIG9mIHJlcGxpY2F0aW5nIHRoZSBzYW1lIGNvZGUKaGVy
ZS4KClRoaXMgYWxzbyByZWFycmFuZ2VzIHRoZSBjb2RlIGEgYml0IHRvIG1ha2UgaXQgbW9yZSBz
ZW5zaWJsZS4gQWxzbyByZW1vdmVzIHNvbWUKdW5uZWNlc3NhcnkgY2hlY2tzLgoKU2lnbmVkLW9m
Zi1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2NwdWZyZXEvb21hcC1jcHVmcmVxLmMgfCA0MSArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9vbWFwLWNwdWZyZXEuYyBiL2Ry
aXZlcnMvY3B1ZnJlcS9vbWFwLWNwdWZyZXEuYwppbmRleCAwOTE1MGZjLi5hOTRjNGVmIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvb21hcC1jcHVmcmVxLmMKKysrIGIvZHJpdmVycy9jcHVm
cmVxL29tYXAtY3B1ZnJlcS5jCkBAIC0xMTIsNTAgKzExMiwzMSBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZnJlcV90YWJsZV9mcmVlKHZvaWQpCiAKIHN0YXRpYyBpbnQgb21hcF9jcHVfaW5pdChzdHJ1
Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKIHsKLQlpbnQgcmVzdWx0ID0gMDsKKwlpbnQgcmVz
dWx0OwogCiAJcG9saWN5LT5jbGsgPSBjbGtfZ2V0KE5VTEwsICJjcHVmcmVxX2NrIik7CiAJaWYg
KElTX0VSUihwb2xpY3ktPmNsaykpCiAJCXJldHVybiBQVFJfRVJSKHBvbGljeS0+Y2xrKTsKIAot
CWlmIChwb2xpY3ktPmNwdSA+PSBOUl9DUFVTKSB7Ci0JCXJlc3VsdCA9IC1FSU5WQUw7Ci0JCWdv
dG8gZmFpbF9jazsKLQl9Ci0KLQlpZiAoIWZyZXFfdGFibGUpCisJaWYgKCFmcmVxX3RhYmxlKSB7
CiAJCXJlc3VsdCA9IG9wcF9pbml0X2NwdWZyZXFfdGFibGUobXB1X2RldiwgJmZyZXFfdGFibGUp
OwotCi0JaWYgKHJlc3VsdCkgewotCQlkZXZfZXJyKG1wdV9kZXYsICIlczogY3B1JWQ6IGZhaWxl
ZCBjcmVhdGluZyBmcmVxIHRhYmxlWyVkXVxuIiwKKwkJaWYgKHJlc3VsdCkgeworCQkJZGV2X2Vy
cihtcHVfZGV2LAorCQkJCSIlczogY3B1JWQ6IGZhaWxlZCBjcmVhdGluZyBmcmVxIHRhYmxlWyVk
XVxuIiwKIAkJCQlfX2Z1bmNfXywgcG9saWN5LT5jcHUsIHJlc3VsdCk7Ci0JCWdvdG8gZmFpbF9j
azsKKwkJCWdvdG8gZmFpbDsKKwkJfQogCX0KIAogCWF0b21pY19pbmNfcmV0dXJuKCZmcmVxX3Rh
YmxlX3VzZXJzKTsKIAotCXJlc3VsdCA9IGNwdWZyZXFfdGFibGVfdmFsaWRhdGVfYW5kX3Nob3co
cG9saWN5LCBmcmVxX3RhYmxlKTsKLQlpZiAocmVzdWx0KQotCQlnb3RvIGZhaWxfdGFibGU7Ci0K
LQkvKgotCSAqIE9uIE9NQVAgU01QIGNvbmZpZ3VhcnRpb24sIGJvdGggcHJvY2Vzc29ycyBzaGFy
ZSB0aGUgdm9sdGFnZQotCSAqIGFuZCBjbG9jay4gU28gYm90aCBDUFVzIG5lZWRzIHRvIGJlIHNj
YWxlZCB0b2dldGhlciBhbmQgaGVuY2UKLQkgKiBuZWVkcyBzb2Z0d2FyZSBjby1vcmRpbmF0aW9u
LiBVc2UgY3B1ZnJlcSBhZmZlY3RlZF9jcHVzCi0JICogaW50ZXJmYWNlIHRvIGhhbmRsZSB0aGlz
IHNjZW5hcmlvLiBBZGRpdGlvbmFsIGlzX3NtcCgpIGNoZWNrCi0JICogaXMgdG8ga2VlcCBTTVBf
T05fVVAgYnVpbGQgd29ya2luZy4KLQkgKi8KLQlpZiAoaXNfc21wKCkpCi0JCWNwdW1hc2tfc2V0
YWxsKHBvbGljeS0+Y3B1cyk7Ci0KIAkvKiBGSVhNRTogd2hhdCdzIHRoZSBhY3R1YWwgdHJhbnNp
dGlvbiB0aW1lPyAqLwotCXBvbGljeS0+Y3B1aW5mby50cmFuc2l0aW9uX2xhdGVuY3kgPSAzMDAg
KiAxMDAwOwotCi0JcmV0dXJuIDA7CisJcmVzdWx0ID0gY3B1ZnJlcV9nZW5lcmljX2luaXQocG9s
aWN5LCBmcmVxX3RhYmxlLCAzMDAgKiAxMDAwKTsKKwlpZiAoIXJlc3VsdCkKKwkJcmV0dXJuIDA7
CiAKLWZhaWxfdGFibGU6CiAJZnJlcV90YWJsZV9mcmVlKCk7Ci1mYWlsX2NrOgorZmFpbDoKIAlj
bGtfcHV0KHBvbGljeS0+Y2xrKTsKIAlyZXR1cm4gcmVzdWx0OwogfQotLSAKMS43LjEyLnJjMi4x
OC5nNjFiNDcyZQoK
--001a11c2e2bebf33ab04e523e732--
