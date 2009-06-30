From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [ARM][OMAP] TWL4030 IRQ
Date: Tue, 30 Jun 2009 12:01:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B546698E@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
 <20090624075756.GA13052@n2100.arm.linux.org.uk>
 <20090629093004.GA2111@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02B546698Edbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbZF3Gbh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jun 2009 02:31:37 -0400
In-Reply-To: <20090629093004.GA2111@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B546698Edbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Russell,
>  drivers/mfd/twl4030-irq.c |   55=20
> ++++++++++++++++++--------------------------
>  1 files changed, 23 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index bae61b2..4bb1ea7 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -180,15 +180,9 @@ static struct completion irq_event;
>  static int twl4030_irq_thread(void *data)
>  {
>  	long irq =3D (long)data;
> -	struct irq_desc *desc =3D irq_to_desc(irq);
>  	static unsigned i2c_errors;
>  	static const unsigned max_i2c_errors =3D 100;
> =20
> -	if (!desc) {
> -		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
> -		return -EINVAL;
> -	}
> -
>  	current->flags |=3D PF_NOFREEZE;
> =20
>  	while (!kthread_should_stop()) {
> @@ -240,38 +234,25 @@ static int twl4030_irq_thread(void *data)
>  		}
>  		local_irq_enable();
> =20
> -		desc->chip->unmask(irq);
> +		enable_irq(irq);
>  	}
> =20
>  	return 0;
>  }
> =20
>  /*
> - * handle_twl4030_pih() is the desc->handle method for the=20
> twl4030 interrupt.
> - * This is a chained interrupt, so there is no desc->action=20
> method for it.
> + * handle_twl4030_pih() is the handler for the main twl4030=20
> interrupt.
>   * Now we need to query the interrupt controller in the=20
> twl4030 to determine
>   * which module is generating the interrupt request. =20
> However, we can't do i2c
>   * transactions in interrupt context, so we must defer that=20
> work to a kernel
>   * thread.  All we do here is acknowledge and mask the=20
> interrupt and wakeup
>   * the kernel thread.
>   */
> -static void handle_twl4030_pih(unsigned int irq, struct=20
> irq_desc *desc)
> -{
> -	/* Acknowledge, clear *AND* mask the interrupt... */
> -	desc->chip->ack(irq);
> -	complete(&irq_event);
> -}
> -
> -static struct task_struct *start_twl4030_irq_thread(long irq)
> +static irqreturn_t handle_twl4030_pih(int irq, void *devid)
>  {
> -	struct task_struct *thread;
> -
> -	init_completion(&irq_event);
> -	thread =3D kthread_run(twl4030_irq_thread, (void *)irq,=20
> "twl4030-irq");
> -	if (!thread)
> -		pr_err("twl4030: could not create irq %ld=20
> thread!\n", irq);
> -
> -	return thread;
> +	disable_irq_nosync(irq);
> +	complete(devid);
> +	return IRQ_HANDLED;
>  }
> =20
> =20
> /*------------------------------------------------------------
> ----------*/
> @@ -734,18 +715,28 @@ int twl_init_irq(int irq_num, unsigned=20
> irq_base, unsigned irq_end)
>  	}
> =20
>  	/* install an irq handler to demultiplex the TWL4030=20
> interrupt */
> -	task =3D start_twl4030_irq_thread(irq_num);
> -	if (!task) {
> -		pr_err("twl4030: irq thread FAIL\n");
> -		status =3D -ESRCH;
> -		goto fail;
> +	init_completion(&irq_event);
> +
> +	status =3D request_irq(irq_num, handle_twl4030_pih, IRQF_DISABLED,
> +				"TWL4030-PIH", &irq_event);
> +	if (status < 0) {
> +		pr_err("twl4030: could not claim irq%d: %d\n",=20
> irq_num, status);
> +		goto fail_rqirq;
>  	}
> =20
> -	set_irq_data(irq_num, task);
> -	set_irq_chained_handler(irq_num, handle_twl4030_pih);
> +	task =3D kthread_run(twl4030_irq_thread, (void *)irq_num,=20
> "twl4030-irq");
> +	if (IS_ERR(task)) {
> +		pr_err("twl4030: could not create irq %d=20
> thread!\n", irq_num);
> +		status =3D PTR_ERR(task);
> +		goto fail_kthread;
> +	}
> =20
>  	return status;
> =20
> +fail_kthread:
> +	free_irq(irq_num, &irq_event);
> +fail_rqirq:
> +	/* clean up twl4030_sih_setup */
>  fail:
>  	for (i =3D irq_base; i < irq_end; i++)
>  		set_irq_chip_and_handler(i, NULL, NULL);

I have tested this patch on OMAP3430SDP with Triton RTC module and works we=
ll.=20
Thanks!!=20

Kevin/Vikram,
Can this patch be included on omap_pm branch to check for any regression?

Regards,
Santosh
 =20
 =

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B546698Edbde02enttico_
Content-Type: application/octet-stream; name="twl_mainline_irq.patch"
Content-Description: twl_mainline_irq.patch
Content-Disposition: attachment; filename="twl_mainline_irq.patch"; size=2758;
	creation-date="Tue, 30 Jun 2009 11:21:34 GMT";
	modification-date="Tue, 30 Jun 2009 11:21:34 GMT"
Content-Transfer-Encoding: base64

LS0tCiBkcml2ZXJzL21mZC90d2w0MDMwLWlycS5jIHwgICA1NCArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDMyIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL21mZC90d2w0
MDMwLWlycS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvbWZkL3R3bDQw
MzAtaXJxLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL21mZC90d2w0MDMwLWlycS5jCkBAIC0xODAs
MTQgKzE4MCw5IEBAIHN0YXRpYyBzdHJ1Y3QgY29tcGxldGlvbiBpcnFfZXZlbnQ7CiBzdGF0aWMg
aW50IHR3bDQwMzBfaXJxX3RocmVhZCh2b2lkICpkYXRhKQogewogCWxvbmcgaXJxID0gKGxvbmcp
ZGF0YTsKLQlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MgPSBpcnFfdG9fZGVzYyhpcnEpOwogCXN0YXRp
YyB1bnNpZ25lZCBpMmNfZXJyb3JzOwogCXN0YXRpYyBjb25zdCB1bnNpZ25lZCBtYXhfaTJjX2Vy
cm9ycyA9IDEwMDsKIAotCWlmICghZGVzYykgewotCQlwcl9lcnIoInR3bDQwMzA6IEludmFsaWQg
SVJROiAlbGRcbiIsIGlycSk7Ci0JCXJldHVybiAtRUlOVkFMOwotCX0KIAogCWN1cnJlbnQtPmZs
YWdzIHw9IFBGX05PRlJFRVpFOwogCkBAIC0yNDAsNyArMjM1LDcgQEAgc3RhdGljIGludCB0d2w0
MDMwX2lycV90aHJlYWQodm9pZCAqZGF0YQogCQl9CiAJCWxvY2FsX2lycV9lbmFibGUoKTsKIAot
CQlkZXNjLT5jaGlwLT51bm1hc2soaXJxKTsKKwkJZW5hYmxlX2lycShpcnEpOwogCX0KIAogCXJl
dHVybiAwOwpAQCAtMjU1LDI1ICsyNTAsMTIgQEAgc3RhdGljIGludCB0d2w0MDMwX2lycV90aHJl
YWQodm9pZCAqZGF0YQogICogdGhyZWFkLiAgQWxsIHdlIGRvIGhlcmUgaXMgYWNrbm93bGVkZ2Ug
YW5kIG1hc2sgdGhlIGludGVycnVwdCBhbmQgd2FrZXVwCiAgKiB0aGUga2VybmVsIHRocmVhZC4K
ICAqLwotc3RhdGljIHZvaWQgaGFuZGxlX3R3bDQwMzBfcGloKHVuc2lnbmVkIGludCBpcnEsIHN0
cnVjdCBpcnFfZGVzYyAqZGVzYykKK3N0YXRpYyBpcnFyZXR1cm5fdCBoYW5kbGVfdHdsNDAzMF9w
aWgoaW50IGlycSwgdm9pZCAqZGV2aWQpCiB7Ci0JLyogQWNrbm93bGVkZ2UsIGNsZWFyICpBTkQq
IG1hc2sgdGhlIGludGVycnVwdC4uLiAqLwotCWRlc2MtPmNoaXAtPmFjayhpcnEpOwotCWNvbXBs
ZXRlKCZpcnFfZXZlbnQpOwotfQotCi1zdGF0aWMgc3RydWN0IHRhc2tfc3RydWN0ICpzdGFydF90
d2w0MDMwX2lycV90aHJlYWQobG9uZyBpcnEpCi17Ci0Jc3RydWN0IHRhc2tfc3RydWN0ICp0aHJl
YWQ7Ci0KLQlpbml0X2NvbXBsZXRpb24oJmlycV9ldmVudCk7Ci0JdGhyZWFkID0ga3RocmVhZF9y
dW4odHdsNDAzMF9pcnFfdGhyZWFkLCAodm9pZCAqKWlycSwgInR3bDQwMzAtaXJxIik7Ci0JaWYg
KCF0aHJlYWQpCi0JCXByX2VycigidHdsNDAzMDogY291bGQgbm90IGNyZWF0ZSBpcnEgJWxkIHRo
cmVhZCFcbiIsIGlycSk7Ci0KLQlyZXR1cm4gdGhyZWFkOworCWRpc2FibGVfaXJxX25vc3luYyhp
cnEpOworCWNvbXBsZXRlKGRldmlkKTsKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9Ci0KIC8qLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSovCiAKIC8qCkBAIC03MzQsMTggKzcxNiwyNiBAQCBpbnQgdHdsX2luaXRfaXJx
KGludCBpcnFfbnVtLCB1bnNpZ25lZCBpCiAJfQogCiAJLyogaW5zdGFsbCBhbiBpcnEgaGFuZGxl
ciB0byBkZW11bHRpcGxleCB0aGUgVFdMNDAzMCBpbnRlcnJ1cHQgKi8KLQl0YXNrID0gc3RhcnRf
dHdsNDAzMF9pcnFfdGhyZWFkKGlycV9udW0pOwotCWlmICghdGFzaykgewotCQlwcl9lcnIoInR3
bDQwMzA6IGlycSB0aHJlYWQgRkFJTFxuIik7Ci0JCXN0YXR1cyA9IC1FU1JDSDsKLQkJZ290byBm
YWlsOwotCX0KKwlpbml0X2NvbXBsZXRpb24oJmlycV9ldmVudCk7CiAKLQlzZXRfaXJxX2RhdGEo
aXJxX251bSwgdGFzayk7Ci0Jc2V0X2lycV9jaGFpbmVkX2hhbmRsZXIoaXJxX251bSwgaGFuZGxl
X3R3bDQwMzBfcGloKTsKKwlzdGF0dXMgPSByZXF1ZXN0X2lycShpcnFfbnVtLCBoYW5kbGVfdHds
NDAzMF9waWgsIElSUUZfRElTQUJMRUQsCisJCQkJIlRXTDQwMzAtUElIIiwgJmlycV9ldmVudCk7
CisJaWYgKHN0YXR1cyA8IDApIHsKKwkJcHJfZXJyKCJ0d2w0MDMwOiBjb3VsZCBub3QgY2xhaW0g
aXJxJWQ6ICVkXG4iLCBpcnFfbnVtLCBzdGF0dXMpOworCQlnb3RvIGZhaWxfcnFpcnE7CisJfQog
CisJdGFzayA9IGt0aHJlYWRfcnVuKHR3bDQwMzBfaXJxX3RocmVhZCwgKHZvaWQgKilpcnFfbnVt
LCAidHdsNDAzMC1pcnEiKTsKKwlpZiAoSVNfRVJSKHRhc2spKSB7CisJCXByX2VycigidHdsNDAz
MDogY291bGQgbm90IGNyZWF0ZSBpcnEgJWQgdGhyZWFkIVxuIiwgaXJxX251bSk7CisJCXN0YXR1
cyA9IFBUUl9FUlIodGFzayk7CisJCWdvdG8gZmFpbF9rdGhyZWFkOworCX0KIAlyZXR1cm4gc3Rh
dHVzOwotCitmYWlsX2t0aHJlYWQ6CisJZnJlZV9pcnEoaXJxX251bSwgJmlycV9ldmVudCk7Citm
YWlsX3JxaXJxOgorCS8qIGNsZWFuIHVwIHR3bDQwMzBfc2loX3NldHVwICovCiBmYWlsOgogCWZv
ciAoaSA9IGlycV9iYXNlOyBpIDwgaXJxX2VuZDsgaSsrKQogCQlzZXRfaXJxX2NoaXBfYW5kX2hh
bmRsZXIoaSwgTlVMTCwgTlVMTCk7Cg==

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B546698Edbde02enttico_--
