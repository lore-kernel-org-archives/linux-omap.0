From: Sriram V <vshrirama@gmail.com>
Subject: Re: cpuidle and NO_HZ
Date: Thu, 22 Jan 2009 22:36:57 +0530
Message-ID: <8bf247760901220906n1ab095a0h695e9c1f5e8db916@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301C6DD0347@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd24262c5a2e90461154cba
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:7727 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbZAVRG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 12:06:58 -0500
Received: by an-out-0708.google.com with SMTP id c2so498326anc.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 09:06:57 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C6DD0347@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--000e0cd24262c5a2e90461154cba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sanjeev,

On Thu, Jan 22, 2009 at 8:14 PM, Premi, Sanjeev <premi@ti.com> wrote:
> Hi all,
>
> While trying to use NFS hosted filesystem, I have made a strange observation. Have verified it on multiple OMAP3EVM boards.
>
> With CONFIG_NO_HZ and CONFIG_CPU_IDLE, after the print "Freeing init memory: 152K" in the log below; the boot sequence almost stops for approx a minute before proceeding further.
>
>   Sending DHCP requests .<6>eth0: link up, 100Mbps, full-duplex, lpa 0x01E1
>   ., OK
>   IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.9
>   IP-Config: Complete:
>     device=eth0, addr=192.168.1.9, mask=255.255.255.0, gw=192.168.1.9,
>     host=192.168.1.9, domain=india.ti.com, nis-domain=(none),
>     bootserver=0.0.0.0, rootserver=192.168.1.2, rootpath=
>   Looking up port of RPC 100003/2 on 192.168.1.2
>   Looking up port of RPC 100005/1 on 192.168.1.2
>   VFS: Mounted root (nfs filesystem).
>   Freeing init memory: 152K
>   init started: BusyBox v1.11.1 (2008-08-06 21:12:30 IST)
>   starting pid 442, tty '': '/etc/init.d/rcS'
>

This seems to be a wakeup issue. SMC gpio irq needs to be enabled as a
wakeup source.
I notice that sometimes even after enabling it as a wakeup source
network interface has trouble. either it is too slow or it just hangs
during nfs mount or takes a long time to mount. this issue could be
somewhere else

I also notice that the whenever network interface hangs during nfs mount.
the nfs server would have exited.



Regards,
sriram







> Later, the system response is slow.
>
> Toggling either of these CONFIG options seems to resolve the issue.
>
> My initial suspicion was on the SMC911x driver, but during this 'wait' period ping requests to the EVM are successful.
>
> Just wanted to check if anyone has seen this behavior.
> (I am on Kevin's latest PM branch 998bd5675a1e...).
>
> Best regards,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--000e0cd24262c5a2e90461154cba
Content-Type: text/x-patch; charset=US-ASCII;
	name="PM-OMAP3EVM-enable-smc-irq-gpio-as-a-wakeup-source.patch"
Content-Disposition: attachment;
	filename="PM-OMAP3EVM-enable-smc-irq-gpio-as-a-wakeup-source.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq9o23460

RnJvbSAwMjYxZmE3YjdjMDA2ZTY0OTMxOWFjMDI5MDdhYmUzNWM2YWE3YTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmlyYW0gViA8dnNyaXJhbUBtaXN0cmFsc29sdXRpb25zLmNv
bT4KRGF0ZTogVGh1LCAyMiBKYW4gMjAwOSAyMjoyNzoyOSArMDUzMApTdWJqZWN0OiBbUEFUQ0hd
IFBNOiBPTUFQM0VWTTogZW5hYmxlIHNtYyBpcnEgZ3BpbyBhcyBhIHdha2V1cCBzb3VyY2UKClNp
Z25lZC1vZmYtYnk6IFNyaXJhbSBWIDx2c3JpcmFtQG1pc3RyYWxzb2x1dGlvbnMuY29tPgotLS0K
IGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYyB8ICAgIDUgKysrKysKIDEgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvYm9hcmQtb21hcDNldm0uYwppbmRleCA2ZmJiZTk1Li4zZWI4YjYwIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9ib2FyZC1vbWFwM2V2bS5jCkBAIC0xOSw2ICsxOSw3IEBACiAjaW5jbHVkZSA8bGludXgv
ZXJyLmg+CiAjaW5jbHVkZSA8bGludXgvY2xrLmg+CiAjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4K
KyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KIAogI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGku
aD4KICNpbmNsdWRlIDxsaW51eC9zcGkvYWRzNzg0Ni5oPgpAQCAtODMsNiArODQsMTAgQEAgc3Rh
dGljIGlubGluZSB2b2lkIF9faW5pdCBvbWFwM2V2bV9pbml0X3NtYzkxMXgodm9pZCkKIAl9CiAK
IAlncGlvX2RpcmVjdGlvbl9pbnB1dChPTUFQM0VWTV9FVEhSX0dQSU9fSVJRKTsKKworI2lmZGVm
IENPTkZJR19QTQorCWVuYWJsZV9pcnFfd2FrZShncGlvX3RvX2lycShPTUFQM0VWTV9FVEhSX0dQ
SU9fSVJRKSk7CisjZW5kaWYKIH0KIAogc3RhdGljIHN0cnVjdCBvbWFwX3VhcnRfY29uZmlnIG9t
YXAzX2V2bV91YXJ0X2NvbmZpZyBfX2luaXRkYXRhID0gewotLSAKMS42LjEKCg==
--000e0cd24262c5a2e90461154cba--
