From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 1/6] power: bq24190_charger: Call enable_irq() only at the
 end of probe()
Date: Thu, 12 Jan 2017 12:02:00 -0800
Message-ID: <CAKvHMgRq3r-6dFTXdJcrUD94BvMzq6w8RRQFgodwoBX3uAZUKw@mail.gmail.com>
References: <20170112004154.31568-1-tony@atomide.com> <20170112004154.31568-2-tony@atomide.com>
 <20170112174435.fotlw2mrif4oubdt@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11470b38badda80545eb309c
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112174435.fotlw2mrif4oubdt@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

--001a11470b38badda80545eb309c
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 12, 2017 at 9:44 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Liam & Tony,
>
> On Wed, Jan 11, 2017 at 04:41:49PM -0800, Tony Lindgren wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> The device specific data is not fully initialized after
>> request_threaded_irq().
>>
>> This causes problems when the IRQ handler tries to reference them.
>> Fix the issue by enabling IRQ only at the end of the probe.
>>
>> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
>> Battery Charger")
>> Cc: Mark A. Greer <mgreer@animalcreek.com>
>> Cc: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> [tony@atomide.com: cleaned up patch description a bit]
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1392,6 +1392,7 @@ static int bq24190_probe(struct i2c_client *client,
>>               return -EINVAL;
>>       }
>>
>> +     irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
>>       ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
>>                       bq24190_irq_handler_thread,
>>                       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> @@ -1436,6 +1437,8 @@ static int bq24190_probe(struct i2c_client *client,
>>               goto out4;
>>       }
>>
>> +     enable_irq(bdi->irq);
>> +
>>       return 0;
>>
>>  out4:
>
> Can't you just move the irq request towards the end of the probe?
> That way it will also be released before the power-supply structure
> is released.

I did that in a first draft I showed Tony. He suggested this way.
Tony, rationale?

It looks like this:

--001a11470b38badda80545eb309c
Content-Type: text/plain; charset=US-ASCII; name="temp-paste.txt"
Content-Disposition: attachment; filename="temp-paste.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixusv81f1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvYnEyNDE5MF9jaGFyZ2VyLmMgYi9kcml2ZXJzL3Bv
d2VyL2JxMjQxOTBfY2hhcmdlci5jDQppbmRleCBiNTFlYWMxLi41NGM4OTUyIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9wb3dlci9icTI0MTkwX2NoYXJnZXIuYw0KKysrIGIvZHJpdmVycy9wb3dlci9i
cTI0MTkwX2NoYXJnZXIuYw0KQEAgLTEzNjYsMjIgKzEzNjYsMTMgQEAgc3RhdGljIGludCBicTI0
MTkwX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogCQlyZXR1cm4gLUVJTlZBTDsN
CiAJfQ0KIA0KLQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgYmRpLT5pcnEs
IE5VTEwsDQotCQkJYnEyNDE5MF9pcnFfaGFuZGxlcl90aHJlYWQsDQotCQkJSVJRRl9UUklHR0VS
X1JJU0lORyB8IElSUUZfT05FU0hPVCwNCi0JCQkiYnEyNDE5MC1jaGFyZ2VyIiwgYmRpKTsNCi0J
aWYgKHJldCA8IDApIHsNCi0JCWRldl9lcnIoZGV2LCAiQ2FuJ3Qgc2V0IHVwIGlycSBoYW5kbGVy
XG4iKTsNCi0JCWdvdG8gb3V0MTsNCi0JfQ0KLQ0KIAlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0K
IAlwbV9ydW50aW1lX3Jlc3VtZShkZXYpOw0KIA0KIAlyZXQgPSBicTI0MTkwX2h3X2luaXQoYmRp
KTsNCiAJaWYgKHJldCA8IDApIHsNCiAJCWRldl9lcnIoZGV2LCAiSGFyZHdhcmUgaW5pdCBmYWls
ZWRcbiIpOw0KLQkJZ290byBvdXQyOw0KKwkJZ290byBvdXQxOw0KIAl9DQogDQogCWNoYXJnZXJf
Y2ZnLmRydl9kYXRhID0gYmRpOw0KQEAgLTEzOTIsNyArMTM4Myw3IEBAIHN0YXRpYyBpbnQgYnEy
NDE5MF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KIAlpZiAoSVNfRVJSKGJkaS0+
Y2hhcmdlcikpIHsNCiAJCWRldl9lcnIoZGV2LCAiQ2FuJ3QgcmVnaXN0ZXIgY2hhcmdlclxuIik7
DQogCQlyZXQgPSBQVFJfRVJSKGJkaS0+Y2hhcmdlcik7DQotCQlnb3RvIG91dDI7DQorCQlnb3Rv
IG91dDE7DQogCX0NCiANCiAJYmF0dGVyeV9jZmcuZHJ2X2RhdGEgPSBiZGk7DQpAQCAtMTQwMSwy
NCArMTM5MiwzNCBAQCBzdGF0aWMgaW50IGJxMjQxOTBfcHJvYmUoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCwNCiAJaWYgKElTX0VSUihiZGktPmJhdHRlcnkpKSB7DQogCQlkZXZfZXJyKGRldiwg
IkNhbid0IHJlZ2lzdGVyIGJhdHRlcnlcbiIpOw0KIAkJcmV0ID0gUFRSX0VSUihiZGktPmJhdHRl
cnkpOw0KLQkJZ290byBvdXQzOw0KKwkJZ290byBvdXQyOw0KIAl9DQogDQogCXJldCA9IGJxMjQx
OTBfc3lzZnNfY3JlYXRlX2dyb3VwKGJkaSk7DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoZGV2
LCAiQ2FuJ3QgY3JlYXRlIHN5c2ZzIGVudHJpZXNcbiIpOw0KKwkJZ290byBvdXQzOw0KKwl9DQor
DQorCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoZGV2LCBiZGktPmlycSwgTlVMTCwN
CisJCQlicTI0MTkwX2lycV9oYW5kbGVyX3RocmVhZCwNCisJCQlJUlFGX1RSSUdHRVJfUklTSU5H
IHwgSVJRRl9PTkVTSE9ULA0KKwkJCSJicTI0MTkwLWNoYXJnZXIiLCBiZGkpOw0KKwlpZiAocmV0
IDwgMCkgew0KKwkJZGV2X2VycihkZXYsICJDYW4ndCBzZXQgdXAgaXJxIGhhbmRsZXJcbiIpOw0K
IAkJZ290byBvdXQ0Ow0KIAl9DQogDQogCXJldHVybiAwOw0KIA0KIG91dDQ6DQotCXBvd2VyX3N1
cHBseV91bnJlZ2lzdGVyKGJkaS0+YmF0dGVyeSk7DQorCWJxMjQxOTBfc3lzZnNfcmVtb3ZlX2dy
b3VwKGJkaSk7DQogb3V0MzoNCi0JcG93ZXJfc3VwcGx5X3VucmVnaXN0ZXIoYmRpLT5jaGFyZ2Vy
KTsNCisJcG93ZXJfc3VwcGx5X3VucmVnaXN0ZXIoYmRpLT5iYXR0ZXJ5KTsNCiBvdXQyOg0KLQlw
bV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCisJcG93ZXJfc3VwcGx5X3VucmVnaXN0ZXIoYmRpLT5j
aGFyZ2VyKTsNCiBvdXQxOg0KKwlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCiAJaWYgKGJkaS0+
Z3Bpb19pbnQpDQogCQlncGlvX2ZyZWUoYmRpLT5ncGlvX2ludCk7DQo=
--001a11470b38badda80545eb309c--
