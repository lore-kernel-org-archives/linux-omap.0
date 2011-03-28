From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: Smartreflex on 'pm-wip/voltdm' Branch
Date: Mon, 28 Mar 2011 19:10:01 +0530
Message-ID: <e3b58bb0f126f8849c7358c8f7e67222@mail.gmail.com>
References: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307f3830207908049f8b1574
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54862 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274Ab1C1NkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 09:40:13 -0400
Received: by mail-vw0-f49.google.com with SMTP id 8so2746235vws.36
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 06:40:11 -0700 (PDT)
In-Reply-To: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

--20cf307f3830207908049f8b1574
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gulati, Shweta
> Sent: Monday, March 28, 2011 4:23 PM
> To: linux-omap@vger.kernel.org; Kevin Hilman
> Subject: Smartreflex on 'pm-wip/voltdm' Branch
>
> Kevin,
>
> I am testing Smartreflex on your Branch 'pm-wip/voltdm'. There seems
> an issue with reading VP registers.
> For OMAP3 and OMAP4 reading debugfs entries shows constant voltage.
> Logs are:
>
> OMAP3:
> # cat /debug/voltage/vdd_mpu_iva/curr_nominal_volt
> 1200000
> # cat /debug/voltage/vdd_core/curr_nominal_volt
> 1200000
> # echo 1 > /debug/voltage/vdd_mpu_iva/smartreflex/autocomp
> [  311.680816] omap_device: smartreflex.0: new worst case activate
> latency 0: 91552
> # echo 1 > /debug/voltage/vdd_core/smartreflex/autocomp
> # cat /debug/voltage/vdd_core/vp/curr_volt
> 900000
> # cat /debug/voltage/vdd_mpu_iva/vp/curr_volt
> 900000
>
>
> OMAP4:
>  # cat /debug/voltage/vdd_core/curr_nominal_volt
> 1200000
> # cat /debug/voltage/vdd_mpu/curr_nominal_volt
> 1375000
> # cat /debug/voltage/vdd_iva/curr_nominal_volt
> 1188000
> #
> # echo 1 > /debug/voltage/vdd_mpu/smartreflex/autocomp
> [   61.514038] omap_device: smartreflex.2: new worst case activate
> latency 0: 30517
> # echo 1 > /debug/voltage/vdd_core/smartreflex/autocomp
> # echo 1 > /debug/voltage/vdd_mpu/smartreflex/autocomp
> #
> # cat /debug/voltage/vdd_iva/curr_nominal_volt
> 1188000
> # cat /debug/voltage/vdd_iva/vp/curr_volt
> 1200000
> #
> # echo 1 > /debug/voltage/vdd_iva/smartreflex/autocomp
> # cat /debug/voltage/vdd_iva/vp/curr_volt
> 812500
> #
> # cat /debug/voltage/vdd_mpu/vp/curr_volt
> 812500
> # cat /debug/voltage/vdd_core/vp/curr_volt
> 812500
> #
>
> This Issue is not reproduced on 'pm-core' branch, seems in the voltage
> Layer Clean up Patches somewhere some thing is goofed up.
I did a quick debug on this and found that the root cause of the issue is
in usage of ffs (because of this, i2c slave address was configured wrongly
in vc).
Basically ffs returns the position of the first (least significant) bit
set in the word and the least significant bit is position 1 where as our
bit operation assumes that least significant position is 0.
I tested the attached patch on OMAP3 and it seems to work fine.

Kevin,
You may want to incorporate this change in your next version if this seems
OK to you.

Vishwa
>
>
> Thanks,
> Regards,
> Shweta
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--20cf307f3830207908049f8b1574
Content-Type: application/octet-stream; name="vc_fix.patch"
Content-Disposition: attachment; filename="vc_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6e7ca0e85a2649ec_0.1

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvcHJtMnh4eF8zeHh4LmMgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL3BybTJ4eHhfM3h4eC5jCmluZGV4IDRkN2ZlMWEuLmVhMjdjOWMKLS0tIGEv
YXJjaC9hcm0vbWFjaC1vbWFwMi9wcm0yeHh4XzN4eHguYworKysgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL3BybTJ4eHhfM3h4eC5jCkBAIC0xODksNyArMTg5LDcgQEAgaW50IG9tYXAzX3BybV92Y19z
ZXRfaTJjX3NsYXZlX2FkZHIodTggdmNfaWQsIHU4IHNsYXZlX2FkZHIpCiAJCXJldHVybiAtRUlO
VkFMOwogCiAJb21hcDJfcHJtX3Jtd19tb2RfcmVnX2JpdHModmMtPnNtcHNfc2FfbWFzaywgCi0J
CQkJICAgc2xhdmVfYWRkciA8PCBmZnModmMtPnNtcHNfc2FfbWFzayksCisJCQkJICAgc2xhdmVf
YWRkciA8PCAoZmZzKHZjLT5zbXBzX3NhX21hc2spLTEpLAogCQkJCSAgIE9NQVAzNDMwX0dSX01P
RCwKIAkJCQkgICBPTUFQM19QUk1fVkNfU01QU19TQV9PRkZTRVQpOwogCkBAIC0yMTMsMTMgKzIx
MywxMyBAQCBzdGF0aWMgaW50IG9tYXAzX3BybV92Y19zZXRfcG1pY19yZWdfYWRkcnModTggdmNf
aWQsIHU4IHZvbHRfYWRkciwgdTggY21kX2FkZHIpCiAJc3RydWN0IG9tYXAzX3BybV92YyAqdmMg
PSAmdmNfY2hhbm5lbHNbdmNfaWRdOwogCiAJb21hcDJfcHJtX3Jtd19tb2RfcmVnX2JpdHModmMt
PnNtcHNfdm9sX3JhX21hc2ssIAotCQkJCSAgIHZvbHRfYWRkciA8PCBmZnModmMtPnNtcHNfdm9s
X3JhX21hc2spLAorCQkJCSAgIHZvbHRfYWRkciA8PCAoZmZzKHZjLT5zbXBzX3ZvbF9yYV9tYXNr
KS0xKSwKIAkJCQkgICBPTUFQMzQzMF9HUl9NT0QsCiAJCQkJICAgT01BUDNfUFJNX1ZDX1NNUFNf
Vk9MX1JBX09GRlNFVCk7CiAKIAlpZiAoY21kX2FkZHIpCiAJCW9tYXAyX3BybV9ybXdfbW9kX3Jl
Z19iaXRzKHZjLT5zbXBzX2NtZF9yYV9tYXNrLCAKLQkJCQkJY21kX2FkZHIgPDwgZmZzKHZjLT5z
bXBzX2NtZF9yYV9tYXNrKSwKKwkJCQkJY21kX2FkZHIgPDwgKGZmcyh2Yy0+c21wc19jbWRfcmFf
bWFzayktMSksCiAJCQkJCU9NQVAzNDMwX0dSX01PRCwKIAkJCQkJT01BUDNfUFJNX1ZDX1NNUFNf
Q01EX1JBX09GRlNFVCk7CiAJCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTQ0
eHguYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcHJtNDR4eC5jCm9sZCBtb2RlIDEwMDY0NApuZXcg
bW9kZSAxMDA3NTUKaW5kZXggMjc1OGI3NS4uNzZiZjZkMwotLS0gYS9hcmNoL2FybS9tYWNoLW9t
YXAyL3BybTQ0eHguYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTQ0eHguYwpAQCAtMjM0
LDcgKzIzNCw3IEBAIGludCBvbWFwNF9wcm1fdmNfc2V0X2kyY19zbGF2ZV9hZGRyKHU4IHZjX2lk
LCB1OCBzbGF2ZV9hZGRyKQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCW9tYXA0X3BybWluc3Rfcm13
X2luc3RfcmVnX2JpdHModmMtPnNtcHNfc2FfbWFzaywgCi0JCQkJCXNsYXZlX2FkZHIgPDwgZmZz
KHZjLT5zbXBzX3NhX21hc2spLAorCQkJCQlzbGF2ZV9hZGRyIDw8IChmZnModmMtPnNtcHNfc2Ff
bWFzayktMSksCiAJCQkJCU9NQVA0NDMwX1BSTV9QQVJUSVRJT04sCiAJCQkJCU9NQVA0NDMwX1BS
TV9ERVZJQ0VfSU5TVCwKIAkJCQkJT01BUDRfUFJNX1ZDX1NNUFNfU0FfT0ZGU0VUKTsKQEAgLTI2
MCwxNCArMjYwLDE0IEBAIHN0YXRpYyBpbnQgb21hcDRfcHJtX3ZjX3NldF9wbWljX3JlZ19hZGRy
cyh1OCB2Y19pZCwKIAlzdHJ1Y3Qgb21hcDRfcHJtX3ZjICp2YyA9ICZ2Y19jaGFubmVsc1t2Y19p
ZF07CiAKIAlvbWFwNF9wcm1pbnN0X3Jtd19pbnN0X3JlZ19iaXRzKHZjLT5zbXBzX3ZvbF9yYV9t
YXNrLCAKLQkJCQkJdm9sdF9hZGRyIDw8IGZmcyh2Yy0+c21wc192b2xfcmFfbWFzayksCisJCQkJ
CXZvbHRfYWRkciA8PCAoZmZzKHZjLT5zbXBzX3ZvbF9yYV9tYXNrKS0xKSwKIAkJCQkJT01BUDQ0
MzBfUFJNX1BBUlRJVElPTiwKIAkJCQkJT01BUDQ0MzBfUFJNX0RFVklDRV9JTlNULAogCQkJCQlP
TUFQNF9QUk1fVkNfVkFMX1NNUFNfUkFfVk9MX09GRlNFVCk7CiAKIAlpZiAoY21kX2FkZHIpCiAJ
CW9tYXA0X3BybWluc3Rfcm13X2luc3RfcmVnX2JpdHModmMtPnNtcHNfY21kX3JhX21hc2ssIAot
CQkJCQljbWRfYWRkciA8PCBmZnModmMtPnNtcHNfY21kX3JhX21hc2spLAorCQkJCQljbWRfYWRk
ciA8PCAoZmZzKHZjLT5zbXBzX2NtZF9yYV9tYXNrKS0xKSwKIAkJCQkJT01BUDQ0MzBfUFJNX1BB
UlRJVElPTiwKIAkJCQkJT01BUDQ0MzBfUFJNX0RFVklDRV9JTlNULAogCQkJCQlPTUFQNF9QUk1f
VkNfVkFMX1NNUFNfUkFfQ01EX09GRlNFVCk7Cg==
--20cf307f3830207908049f8b1574--
