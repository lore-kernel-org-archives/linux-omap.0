From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 3/3] HACK: OMAP: Serial: use PRCM wakeup events to enable clocks
Date: Tue, 14 Jun 2011 18:04:31 +0530
Message-ID: <BANLkTikTnMEDmXgbi1kxAJ0F0-NUAEDtzg@mail.gmail.com>
References: <1307625904-18629-1-git-send-email-t-kristo@ti.com> <1307625904-18629-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517440fd0228afe04a5ab438c
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1FNMex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:34:53 -0400
Received: by fxm17 with SMTP id 17so3620530fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 05:34:51 -0700 (PDT)
In-Reply-To: <1307625904-18629-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

--001517440fd0228afe04a5ab438c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 9, 2011 at 6:55 PM, Tero Kristo <t-kristo@ti.com> wrote:
> This patch is just to test that the idea works generally, proper implemen=
tation
> should be done for the OMAP UART driver.
>

Doesn't seem to wake-up from off mode.
(uart pad wakeup after enable_offmode and uart timeouts)

I used attached patch which has some more additions to this patch.
(basically to get rid of prepare idle and resume idle calls from sram
idle path and cut clocks independently).

IIUC we have to comment out all resume calls even from omap-serial.c
irq_chaining should call uart_irq handler registered in serial.c
and block sleep.

And on 3430SDP even for module level wakeup after cutting clocks
I see it gets looped in prcm_irq handler trying to clear wakeup status bits
trying to handle same from serial_omap_irq calling resume_idle
doesn't seem to help though if I use the same call from prcm_clear_mod_irqs
helps in wakeup.

Also patch series doesn't seem to apply cleanly on 3.0 kernel conflicts wit=
h
4430pm things.

--
Thanks,
Govindraj.R


> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 | =A0 =A04 ----
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 | =A0 =A03 +++
> =A0drivers/tty/serial/omap-serial.c | =A0 =A07 +++++++
> =A03 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index f70a9ad..ac6aa77 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -103,10 +103,6 @@ void omap4_enter_sleep(unsigned int cpu, unsigned in=
t power_state)
>
> =A0 =A0 =A0 =A0if (core_next_state < PWRDM_POWER_ON) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_resume_after_idle();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(3);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return;
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 6959d65..4cf8c4a 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -39,6 +39,7 @@
> =A0#include <plat/dma.h>
> =A0#include <plat/omap_hwmod.h>
> =A0#include <plat/omap_device.h>
> +#include <plat/prcm.h>
>
> =A0#include "prm2xxx_3xxx.h"
> =A0#include "pm.h"
> @@ -574,6 +575,8 @@ static void omap_uart_idle_init(struct omap_uart_stat=
e *uart)
> =A0 =A0 =A0 =A0ret =3D request_threaded_irq(uart->irq, NULL, omap_uart_in=
terrupt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_=
SHARED, "serial idle", (void *)uart);
> =A0 =A0 =A0 =A0WARN_ON(ret);
> + =A0 =A0 =A0 ret =3D omap_prcm_register_pad_irq(uart->padconf, uart->irq=
);
> + =A0 =A0 =A0 WARN_ON(ret);
> =A0}
>
> =A0void omap_uart_enable_irqs(int enable)
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index 0275c28..cfe2e7c 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -261,6 +261,8 @@ static void serial_omap_start_tx(struct uart_port *po=
rt)
> =A0 =A0 =A0 =A0unsigned int start;
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> + =A0 =A0 =A0 omap_uart_resume_idle(up->pdev->id);
> +
> =A0 =A0 =A0 =A0if (!up->use_dma) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_enable_ier_thri(up);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -354,6 +356,8 @@ static inline irqreturn_t serial_omap_irq(int irq, vo=
id *dev_id)
> =A0 =A0 =A0 =A0unsigned int iir, lsr;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 omap_uart_resume_idle(up->pdev->id);
> +
> =A0 =A0 =A0 =A0iir =3D serial_in(up, UART_IIR);
> =A0 =A0 =A0 =A0if (iir & UART_IIR_NO_INT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_NONE;
> @@ -947,6 +951,8 @@ serial_omap_console_write(struct console *co, const c=
har *s,
> =A0 =A0 =A0 =A0unsigned int ier;
> =A0 =A0 =A0 =A0int locked =3D 1;
>
> + =A0 =A0 =A0 omap_uart_resume_idle(up->pdev->id);
> +
> =A0 =A0 =A0 =A0local_irq_save(flags);
> =A0 =A0 =A0 =A0if (up->port.sysrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0locked =3D 0;
> @@ -1303,6 +1309,7 @@ static int serial_omap_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto do_release_region;
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, up);
> + =A0 =A0 =A0 pr_info("OMAP UART %d is up\n", pdev->id);
> =A0 =A0 =A0 =A0return 0;
> =A0err:
> =A0 =A0 =A0 =A0dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> --
> 1.7.4.1
>
>
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. =
Kotipaikka: Helsinki
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

--001517440fd0228afe04a5ab438c
Content-Type: application/octet-stream; name="test_irqchn_uart.patch"
Content-Disposition: attachment; filename="test_irqchn_uart.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gowu2rg10

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvcG0zNHh4LmMgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL3BtMzR4eC5jCmluZGV4IGM3ZWFhMzIuLjU3NGUxYTQgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvcG0zNHh4LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbTM0eHgu
YwpAQCAtMjE2LDYgKzIxNiwxNyBAQCBzdGF0aWMgaW50IHByY21fY2xlYXJfbW9kX2lycXMoczE2
IG1vZHVsZSwgdTggcmVncykKIAogCXdrc3QgPSBvbWFwMl9wcm1fcmVhZF9tb2RfcmVnKG1vZHVs
ZSwgd2tzdF9vZmYpOwogCXdrc3QgJj0gb21hcDJfcHJtX3JlYWRfbW9kX3JlZyhtb2R1bGUsIGdy
cHNlbF9vZmYpOworCisjaWYgMAorCWlmIChtb2R1bGUgPT0gT01BUDM0MzBfUEVSX01PRCkgewor
CQlpZiAod2tzdCAmIE9NQVAzNDMwX1NUX1VBUlQzX01BU0spIHsKKwkJCXByaW50aygiUFJDTSBJ
UlE6IFVBUlQzIHdha2V1cFxuIik7CisJCQlvbWFwX3VhcnRfcmVzdW1lX2lkbGUoMCk7CisJCQlj
Kys7CisJCX0KKwl9IGVsc2UKKworI2VuZGlmCiAJaWYgKHdrc3QpIHsKIAkJaWNsayA9IG9tYXAy
X2NtX3JlYWRfbW9kX3JlZyhtb2R1bGUsIGljbGtfb2ZmKTsKIAkJZmNsayA9IG9tYXAyX2NtX3Jl
YWRfbW9kX3JlZyhtb2R1bGUsIGZjbGtfb2ZmKTsKQEAgLTMzNywxOCArMzQ4LDkgQEAgdm9pZCBv
bWFwX3NyYW1faWRsZSh2b2lkKQogCQlvbWFwM19lbmFibGVfaW9fY2hhaW4oKTsKIAl9CiAKLQkv
KiBCbG9jayBjb25zb2xlIG91dHB1dCBpbiBjYXNlIGl0IGlzIG9uIG9uZSBvZiB0aGUgT01BUCBV
QVJUcyAqLwotCWlmICghaXNfc3VzcGVuZGluZygpKQotCQlpZiAocGVyX25leHRfc3RhdGUgPCBQ
V1JETV9QT1dFUl9PTiB8fAotCQkgICAgY29yZV9uZXh0X3N0YXRlIDwgUFdSRE1fUE9XRVJfT04p
Ci0JCQlpZiAoIWNvbnNvbGVfdHJ5bG9jaygpKQotCQkJCWdvdG8gY29uc29sZV9zdGlsbF9hY3Rp
dmU7Ci0KIAkvKiBQRVIgKi8KIAlpZiAocGVyX25leHRfc3RhdGUgPCBQV1JETV9QT1dFUl9PTikg
ewogCQlwZXJfZ29pbmdfb2ZmID0gKHBlcl9uZXh0X3N0YXRlID09IFBXUkRNX1BPV0VSX09GRikg
PyAxIDogMDsKLQkJb21hcF91YXJ0X3ByZXBhcmVfaWRsZSgyKTsKLQkJb21hcF91YXJ0X3ByZXBh
cmVfaWRsZSgzKTsKIAkJb21hcDJfZ3Bpb19wcmVwYXJlX2Zvcl9pZGxlKHBlcl9nb2luZ19vZmYp
OwogCQlpZiAocGVyX25leHRfc3RhdGUgPT0gUFdSRE1fUE9XRVJfT0ZGKQogCQkJCW9tYXAzX3Bl
cl9zYXZlX2NvbnRleHQoKTsKQEAgLTM1Niw4ICszNTgsNiBAQCB2b2lkIG9tYXBfc3JhbV9pZGxl
KHZvaWQpCiAKIAkvKiBDT1JFICovCiAJaWYgKGNvcmVfbmV4dF9zdGF0ZSA8IFBXUkRNX1BPV0VS
X09OKSB7Ci0JCW9tYXBfdWFydF9wcmVwYXJlX2lkbGUoMCk7Ci0JCW9tYXBfdWFydF9wcmVwYXJl
X2lkbGUoMSk7CiAJCWlmIChjb3JlX25leHRfc3RhdGUgPT0gUFdSRE1fUE9XRVJfT0ZGKSB7CiAJ
CQlvbWFwM19jb3JlX3NhdmVfY29udGV4dCgpOwogCQkJb21hcDNfY21fc2F2ZV9jb250ZXh0KCk7
CkBAIC00MDQsOCArNDA0LDYgQEAgdm9pZCBvbWFwX3NyYW1faWRsZSh2b2lkKQogCQkJb21hcDNf
c3JhbV9yZXN0b3JlX2NvbnRleHQoKTsKIAkJCW9tYXAyX3Ntc19yZXN0b3JlX2NvbnRleHQoKTsK
IAkJfQotCQlvbWFwX3VhcnRfcmVzdW1lX2lkbGUoMCk7Ci0JCW9tYXBfdWFydF9yZXN1bWVfaWRs
ZSgxKTsKIAkJaWYgKGNvcmVfbmV4dF9zdGF0ZSA9PSBQV1JETV9QT1dFUl9PRkYpCiAJCQlvbWFw
Ml9wcm1fY2xlYXJfbW9kX3JlZ19iaXRzKE9NQVAzNDMwX0FVVE9fT0ZGX01BU0ssCiAJCQkJCSAg
ICAgICBPTUFQMzQzMF9HUl9NT0QsCkBAIC00MTksMTQgKzQxNyw4IEBAIHZvaWQgb21hcF9zcmFt
X2lkbGUodm9pZCkKIAkJb21hcDJfZ3Bpb19yZXN1bWVfYWZ0ZXJfaWRsZSgpOwogCQlpZiAocGVy
X3ByZXZfc3RhdGUgPT0gUFdSRE1fUE9XRVJfT0ZGKQogCQkJb21hcDNfcGVyX3Jlc3RvcmVfY29u
dGV4dCgpOwotCQlvbWFwX3VhcnRfcmVzdW1lX2lkbGUoMik7Ci0JCW9tYXBfdWFydF9yZXN1bWVf
aWRsZSgzKTsKIAl9CiAKLQlpZiAoIWlzX3N1c3BlbmRpbmcoKSkKLQkJY29uc29sZV91bmxvY2so
KTsKLQotY29uc29sZV9zdGlsbF9hY3RpdmU6CiAJLyogRGlzYWJsZSBJTy1QQUQgYW5kIElPLUNI
QUlOIHdha2V1cCAqLwogCWlmIChvbWFwM19oYXNfaW9fd2FrZXVwKCkgJiYKIAkgICAgKHBlcl9u
ZXh0X3N0YXRlIDwgUFdSRE1fUE9XRVJfT04gfHwKQEAgLTQ0NSw4ICs0MzcsNiBAQCBpbnQgb21h
cDNfY2FuX3NsZWVwKHZvaWQpCiB7CiAJaWYgKCFzbGVlcF93aGlsZV9pZGxlKQogCQlyZXR1cm4g
MDsKLQlpZiAoIW9tYXBfdWFydF9jYW5fc2xlZXAoKSkKLQkJcmV0dXJuIDA7CiAJcmV0dXJuIDE7
CiB9CiAKQEAgLTQ5NSw3ICs0ODUsNiBAQCBzdGF0aWMgaW50IG9tYXAzX3BtX3N1c3BlbmQodm9p
ZCkKIAkJCWdvdG8gcmVzdG9yZTsKIAl9CiAKLQlvbWFwX3VhcnRfcHJlcGFyZV9zdXNwZW5kKCk7
CiAJb21hcDNfaW50Y19zdXNwZW5kKCk7CiAKIAlvbWFwX3NyYW1faWRsZSgpOwpAQCAtNTQyLDE0
ICs1MzEsMTIgQEAgc3RhdGljIGludCBvbWFwM19wbV9iZWdpbihzdXNwZW5kX3N0YXRlX3Qgc3Rh
dGUpCiB7CiAJZGlzYWJsZV9obHQoKTsKIAlzdXNwZW5kX3N0YXRlID0gc3RhdGU7Ci0Jb21hcF91
YXJ0X2VuYWJsZV9pcnFzKDApOwogCXJldHVybiAwOwogfQogCiBzdGF0aWMgdm9pZCBvbWFwM19w
bV9lbmQodm9pZCkKIHsKIAlzdXNwZW5kX3N0YXRlID0gUE1fU1VTUEVORF9PTjsKLQlvbWFwX3Vh
cnRfZW5hYmxlX2lycXMoMSk7CiAJZW5hYmxlX2hsdCgpOwogCXJldHVybjsKIH0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Nl
cmlhbC5jCmluZGV4IDFhYzM2MWIuLmFmN2MyNzggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
b21hcDIvc2VyaWFsLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9zZXJpYWwuYwpAQCAtMzks
NiArMzksNyBAQAogI2luY2x1ZGUgPHBsYXQvZG1hLmg+CiAjaW5jbHVkZSA8cGxhdC9vbWFwX2h3
bW9kLmg+CiAjaW5jbHVkZSA8cGxhdC9vbWFwX2RldmljZS5oPgorI2luY2x1ZGUgPHBsYXQvcHJj
bS5oPgogCiAjaW5jbHVkZSAicHJtMnh4eF8zeHh4LmgiCiAjaW5jbHVkZSAicG0uaCIKQEAgLTEw
Miw2ICsxMDMsOSBAQCBzdHJ1Y3Qgb21hcF91YXJ0X3N0YXRlIHsKIAl1MTYgd2VyOwogCXUxNiBt
Y3I7CiAjZW5kaWYKKwlib29sIGNvbnNvbGU7CisJYm9vbCBjb25zb2xlX2xvY2tlZDsKKwlib29s
IGlzX3N1c3BlbmRpbmc7CiB9OwogCiBzdGF0aWMgTElTVF9IRUFEKHVhcnRfbGlzdCk7CkBAIC0z
NjUsMTAgKzM2OSwyNiBAQCBzdGF0aWMgdm9pZCBvbWFwX3VhcnRfYmxvY2tfc2xlZXAoc3RydWN0
IG9tYXBfdWFydF9zdGF0ZSAqdWFydCkKIAkJbW9kX3RpbWVyKCZ1YXJ0LT50aW1lciwgamlmZmll
cyArIHVhcnQtPnRpbWVvdXQpOwogCWVsc2UKIAkJZGVsX3RpbWVyKCZ1YXJ0LT50aW1lcik7CisK
KwlpZiAodWFydC0+Y29uc29sZSAmJiB1YXJ0LT5jb25zb2xlX2xvY2tlZCkgeworCQljb25zb2xl
X3VubG9jaygpOworCQl1YXJ0LT5jb25zb2xlX2xvY2tlZCA9IGZhbHNlOworCX0KIH0KIAogc3Rh
dGljIHZvaWQgb21hcF91YXJ0X2FsbG93X3NsZWVwKHN0cnVjdCBvbWFwX3VhcnRfc3RhdGUgKnVh
cnQpCiB7CisJLyogSWYgY29uc29sZSBpcyBidXN5LCB3YWl0IGFub3RoZXIgc2Vjb25kICovCisJ
aWYgKHVhcnQtPmNvbnNvbGUgJiYgIXVhcnQtPmlzX3N1c3BlbmRpbmcpIHsKKwkJaWYgKGNvbnNv
bGVfdHJ5bG9jaygpKSB7CisJCQl1YXJ0LT5jb25zb2xlX2xvY2tlZCA9IHRydWU7CisJCX0gZWxz
ZSB7CisJCQlwcmludGsoIiVzOiBjb25zb2xlIGxvY2tlZCwgZGVsYXlpbmdcbiIsIF9fZnVuY19f
KTsKKwkJCW1vZF90aW1lcigmdWFydC0+dGltZXIsIGppZmZpZXMgKyBIWik7CisJCQlyZXR1cm47
CisJCX0KKwl9CisKIAlpZiAoZGV2aWNlX21heV93YWtldXAoJnVhcnQtPnBkZXYtPmRldikpCiAJ
CW9tYXBfdWFydF9lbmFibGVfd2FrZXVwKHVhcnQpOwogCWVsc2UKQEAgLTM4MCw2ICs0MDAsNyBA
QCBzdGF0aWMgdm9pZCBvbWFwX3VhcnRfYWxsb3dfc2xlZXAoc3RydWN0IG9tYXBfdWFydF9zdGF0
ZSAqdWFydCkKIAlvbWFwX3VhcnRfc21hcnRfaWRsZV9lbmFibGUodWFydCwgMSk7CiAJdWFydC0+
Y2FuX3NsZWVwID0gMTsKIAlkZWxfdGltZXIoJnVhcnQtPnRpbWVyKTsKKwlvbWFwX3VhcnRfZGlz
YWJsZV9jbG9ja3ModWFydCk7CiB9CiAKIHN0YXRpYyB2b2lkIG9tYXBfdWFydF9pZGxlX3RpbWVy
KHVuc2lnbmVkIGxvbmcgZGF0YSkKQEAgLTM5MSwzNSArNDEyLDIwIEBAIHN0YXRpYyB2b2lkIG9t
YXBfdWFydF9pZGxlX3RpbWVyKHVuc2lnbmVkIGxvbmcgZGF0YSkKIAogdm9pZCBvbWFwX3VhcnRf
cHJlcGFyZV9pZGxlKGludCBudW0pCiB7Ci0Jc3RydWN0IG9tYXBfdWFydF9zdGF0ZSAqdWFydDsK
LQotCWxpc3RfZm9yX2VhY2hfZW50cnkodWFydCwgJnVhcnRfbGlzdCwgbm9kZSkgewotCQlpZiAo
bnVtID09IHVhcnQtPm51bSAmJiB1YXJ0LT5jYW5fc2xlZXApIHsKLQkJCW9tYXBfdWFydF9kaXNh
YmxlX2Nsb2Nrcyh1YXJ0KTsKLQkJCXJldHVybjsKLQkJfQotCX0KIH0KIAogdm9pZCBvbWFwX3Vh
cnRfcmVzdW1lX2lkbGUoaW50IG51bSkKIHsKIAlzdHJ1Y3Qgb21hcF91YXJ0X3N0YXRlICp1YXJ0
OworCXUzMiB3a3N0OwogCiAJbGlzdF9mb3JfZWFjaF9lbnRyeSh1YXJ0LCAmdWFydF9saXN0LCBu
b2RlKSB7CiAJCWlmIChudW0gPT0gdWFydC0+bnVtICYmIHVhcnQtPmNhbl9zbGVlcCkgewotCQkJ
b21hcF91YXJ0X2VuYWJsZV9jbG9ja3ModWFydCk7Ci0KLQkJCS8qIENoZWNrIGZvciBJTyBwYWQg
d2FrZXVwICovCi0JCQlpZiAoY3B1X2lzX29tYXAzNHh4KCkgJiYgdWFydC0+cGFkY29uZikgewot
CQkJCXUxNiBwID0gb21hcF9jdHJsX3JlYWR3KHVhcnQtPnBhZGNvbmYpOwotCi0JCQkJaWYgKHAg
JiBPTUFQM19QQURDT05GX1dBS0VVUEVWRU5UMCkKLQkJCQkJb21hcF91YXJ0X2Jsb2NrX3NsZWVw
KHVhcnQpOwotCQkJfQotCi0JCQkvKiBDaGVjayBmb3Igbm9ybWFsIFVBUlQgd2FrZXVwICovCi0J
CQlpZiAoX19yYXdfcmVhZGwodWFydC0+d2tfc3QpICYgdWFydC0+d2tfbWFzaykKLQkJCQlvbWFw
X3VhcnRfYmxvY2tfc2xlZXAodWFydCk7CisJCQlvbWFwX3VhcnRfYmxvY2tfc2xlZXAodWFydCk7
CisJCQkvKiBDaGVjayBmb3Igbm9ybWFsIFVBUlQgd2FrZXVwIChhbmQgY2xlYXIgaXQpICovCisJ
CQl3a3N0ID0gX19yYXdfcmVhZGwodWFydC0+d2tfc3QpICYgdWFydC0+d2tfbWFzazsKKwkJCWlm
ICh3a3N0KQorCQkJCV9fcmF3X3dyaXRlbCh3a3N0LCB1YXJ0LT53a19zdCk7CiAJCQlyZXR1cm47
CiAJCX0KIAl9CkBAIC00MzAsNyArNDM2LDkgQEAgdm9pZCBvbWFwX3VhcnRfcHJlcGFyZV9zdXNw
ZW5kKHZvaWQpCiAJc3RydWN0IG9tYXBfdWFydF9zdGF0ZSAqdWFydDsKIAogCWxpc3RfZm9yX2Vh
Y2hfZW50cnkodWFydCwgJnVhcnRfbGlzdCwgbm9kZSkgeworCQl1YXJ0LT5pc19zdXNwZW5kaW5n
ID0gdHJ1ZTsKIAkJb21hcF91YXJ0X2FsbG93X3NsZWVwKHVhcnQpOworCQl1YXJ0LT5pc19zdXNw
ZW5kaW5nID0gZmFsc2U7CiAJfQogfQogCkBAIC01NTAsNiArNTU4LDggQEAgc3RhdGljIHZvaWQg
b21hcF91YXJ0X2lkbGVfaW5pdChzdHJ1Y3Qgb21hcF91YXJ0X3N0YXRlICp1YXJ0KQogCXJldCA9
IHJlcXVlc3RfdGhyZWFkZWRfaXJxKHVhcnQtPmlycSwgTlVMTCwgb21hcF91YXJ0X2ludGVycnVw
dCwKIAkJCQkgICBJUlFGX1NIQVJFRCwgInNlcmlhbCBpZGxlIiwgKHZvaWQgKil1YXJ0KTsKIAlX
QVJOX09OKHJldCk7CisJcmV0ID0gb21hcF9wcmNtX3JlZ2lzdGVyX3BhZF9pcnEodWFydC0+cGFk
Y29uZiwgdWFydC0+aXJxKTsKKwlXQVJOX09OKHJldCk7CiB9CiAKIHZvaWQgb21hcF91YXJ0X2Vu
YWJsZV9pcnFzKGludCBlbmFibGUpCkBAIC02NzksNiArNjg5LDEwIEBAIHN0YXRpYyBpbnQgX19p
bml0IG9tYXBfc2VyaWFsX2Vhcmx5X2luaXQodm9pZCkKIAkJbGlzdF9hZGRfdGFpbCgmdWFydC0+
bm9kZSwgJnVhcnRfbGlzdCk7CiAJCW51bV91YXJ0cysrOwogCisJCS8qIEhBQ0sgSEFDSzogaGFy
ZC1jb2RlIGNvbnNvbGUgYXQgVUFSVDEgKi8KKwkJaWYgKHVhcnQtPm51bSA9PSAwKQorCQkJdWFy
dC0+Y29uc29sZSA9IHRydWU7CisKIAkJLyoKIAkJICogTk9URTogb21hcF9od21vZF9zZXR1cCoo
KSBoYXMgbm90IHlldCBiZWVuIGNhbGxlZCwKIAkJICogICAgICAgc28gbm8gaHdtb2QgZnVuY3Rp
b25zIHdpbGwgd29yayB5ZXQuCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1z
ZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCmluZGV4IDQ3Y2FkZjQu
LjEzMTJjMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCkBAIC0yNjEsNiArMjYxLDggQEAg
c3RhdGljIHZvaWQgc2VyaWFsX29tYXBfc3RhcnRfdHgoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkK
IAl1bnNpZ25lZCBpbnQgc3RhcnQ7CiAJaW50IHJldCA9IDA7CiAKKwlvbWFwX3VhcnRfcmVzdW1l
X2lkbGUodXAtPnBkZXYtPmlkKTsKKwogCWlmICghdXAtPnVzZV9kbWEpIHsKIAkJc2VyaWFsX29t
YXBfZW5hYmxlX2llcl90aHJpKHVwKTsKIAkJcmV0dXJuOwpAQCAtMzU0LDYgKzM1Niw4IEBAIHN0
YXRpYyBpbmxpbmUgaXJxcmV0dXJuX3Qgc2VyaWFsX29tYXBfaXJxKGludCBpcnEsIHZvaWQgKmRl
dl9pZCkKIAl1bnNpZ25lZCBpbnQgaWlyLCBsc3I7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAor
CW9tYXBfdWFydF9yZXN1bWVfaWRsZSh1cC0+cGRldi0+aWQpOworCiAJaWlyID0gc2VyaWFsX2lu
KHVwLCBVQVJUX0lJUik7CiAJaWYgKGlpciAmIFVBUlRfSUlSX05PX0lOVCkKIAkJcmV0dXJuIElS
UV9OT05FOwpAQCAtOTQ3LDYgKzk1MSw4IEBAIHNlcmlhbF9vbWFwX2NvbnNvbGVfd3JpdGUoc3Ry
dWN0IGNvbnNvbGUgKmNvLCBjb25zdCBjaGFyICpzLAogCXVuc2lnbmVkIGludCBpZXI7CiAJaW50
IGxvY2tlZCA9IDE7CiAKKwlvbWFwX3VhcnRfcmVzdW1lX2lkbGUodXAtPnBkZXYtPmlkKTsKKwog
CWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKIAlpZiAodXAtPnBvcnQuc3lzcnEpCiAJCWxvY2tlZCA9
IDA7CkBAIC0xMzAzLDYgKzEzMDksNyBAQCBzdGF0aWMgaW50IHNlcmlhbF9vbWFwX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCWdvdG8gZG9fcmVsZWFzZV9yZWdpb247CiAK
IAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCB1cCk7CisJcHJfaW5mbygiT01BUCBVQVJUICVk
IGlzIHVwXG4iLCBwZGV2LT5pZCk7CiAJcmV0dXJuIDA7CiBlcnI6CiAJZGV2X2VycigmcGRldi0+
ZGV2LCAiW1VBUlQlZF06IGZhaWx1cmUgWyVzXTogJWRcbiIsCg==
--001517440fd0228afe04a5ab438c--
