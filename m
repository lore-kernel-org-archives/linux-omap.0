From: Philip Balister <philip@balister.org>
Subject: Re: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Tue, 20 May 2008 20:39:24 -0400
Message-ID: <48336F3C.5040004@balister.org>
References: <alpine.DEB.1.00.0805201220090.9463@utopia.booyaka.com> <9c9fda240805201618y43d65160h246ea69a43785515@mail.gmail.com> <alpine.DEB.1.00.0805201802040.9463@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070207060200090605040707"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:3490 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764796AbYEUAja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:39:30 -0400
In-Reply-To: <alpine.DEB.1.00.0805201802040.9463@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-omap@vger.kernel.org, lethal@linux-sh.org

This is a cryptographically signed message in MIME format.

--------------ms070207060200090605040707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Walmsley wrote:
> Hello Kyungmin,
> 
> On Wed, 21 May 2008, Kyungmin Park wrote:
> 
>> On Wed, May 21, 2008 at 3:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>>  static void omap_mask_irq(unsigned int irq)
>>>  {
>>> -       int offset = (irq >> 5) << 5;
>>> +       int offset = irq & (~(IRQ_BITS_PER_REG - 1));
>>>
>>> -       if (irq >= 64)
>>> -               irq %= 64;
>>> -       else if (irq >= 32)
>>> -               irq %= 32;
>>> +       irq %= IRQ_BITS_PER_REG;
>> Is it the right conversion?
>> If the irq is greater then 32 and less then or equal to  64 it's
>> result is different.
>> E.g, If irq is 63 then original irq is 63, but new code is 31
> 
> Hmm, in that condition, the result looks the same to me: irq % 32, either 
> way?
> 
> More practically, if you look at what it does with that irq variable 
> afterwards, it seems to be a bug if irq is ever greater than 31:
> 
>         intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + 
>                             offset);
> 
> I think the only case where the new code would work differently than the 
> previous code is if irq > 95.  But that would be a bug, since the shift 
> value would then be > 32, for a 32-bit register.
> 
>> And if this code is right, how about to use mask instead of modulo op?
>> irq &= (IRQ_BITS_PER_REG - 1);
> 
> Hehe, very good point, that would probably save even more cycles!  If you 
> agree with the above, perhaps I can convert the code to use that also, 
> and add your Signed-off-by also?

On some code where I used % to detect a counter passing multiples of a 
certain number, oprofile revealed that the % operator burned a lot of 
CPU cycles. I suspect this had to do with the counter increasing to very 
large numbers, but ever since, I've tried to avoid the % operator in 
critical paths.

Philip

--------------ms070207060200090605040707
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJRTCC
Av0wggJmoAMCAQICEHW4VJIUQV0u11NnfLpF2IUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDQxNDE5MTkzMVoX
DTA5MDQxNDE5MTkzMVowYjERMA8GA1UEBBMIQmFsaXN0ZXIxDzANBgNVBCoTBlBoaWxpcDEY
MBYGA1UEAxMPUGhpbGlwIEJhbGlzdGVyMSIwIAYJKoZIhvcNAQkBFhNwaGlsaXBAYmFsaXN0
ZXIub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxyNViPlSmMq2Kl4m7iDB
I3gB7Pwhg+4vnXCKEF3qIoLwNDVl27CP8RY0umjENzykOR6ZhzYx4fH8arNV5+nlXsH8KNnb
Dpd5ICTZvbUJdt1gPETmLczGy4hh8woCu7qodyy7YZcGMiUY5LxoL7vIQHysir4rbMRV/JId
mhKfFrHb+glDe8XbfTJ3xKO+BsMgLDaSiRMelH6uFLAVv9oRoIJxHQhwKLvlrOSQj+ek2fL6
83BzOUsM4BN/fiwvtJ/y3doVEoKUp8ippOXrwLAXFPprPAAdIydqufTxHotooFqbQzqSJv4c
TNDTxf2fg9YfH2RAs8vTdc/wgIVlL8fJnQIDAQABozAwLjAeBgNVHREEFzAVgRNwaGlsaXBA
YmFsaXN0ZXIub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEASFC7i4DqutUT
ifbyNtEe+e9bqgqWUScDFl0BTV5fFVBX/mFpM3RBZJfq+iM5q0L7qont3sGaXG0cdVvRk2dk
uV2i0HwkmTLJ4HTLMyJ57BjMJWY9ydDiY+Ai1pINmjIgq/qI0aireByqNee68q+PaWE7bfW1
XvfqZD56QunCijswggL9MIICZqADAgECAhB1uFSSFEFdLtdTZ3y6RdiFMA0GCSqGSIb3DQEB
BQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0w
ODA0MTQxOTE5MzFaFw0wOTA0MTQxOTE5MzFaMGIxETAPBgNVBAQTCEJhbGlzdGVyMQ8wDQYD
VQQqEwZQaGlsaXAxGDAWBgNVBAMTD1BoaWxpcCBCYWxpc3RlcjEiMCAGCSqGSIb3DQEJARYT
cGhpbGlwQGJhbGlzdGVyLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMcj
VYj5UpjKtipeJu4gwSN4Aez8IYPuL51wihBd6iKC8DQ1Zduwj/EWNLpoxDc8pDkemYc2MeHx
/GqzVefp5V7B/CjZ2w6XeSAk2b21CXbdYDxE5i3MxsuIYfMKAru6qHcsu2GXBjIlGOS8aC+7
yEB8rIq+K2zEVfySHZoSnxax2/oJQ3vF230yd8SjvgbDICw2kokTHpR+rhSwFb/aEaCCcR0I
cCi75azkkI/npNny+vNwczlLDOATf34sL7Sf8t3aFRKClKfIqaTl68CwFxT6azwAHSMnarn0
8R6LaKBam0M6kib+HEzQ08X9n4PWHx9kQLPL03XP8ICFZS/HyZ0CAwEAAaMwMC4wHgYDVR0R
BBcwFYETcGhpbGlwQGJhbGlzdGVyLm9yZzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUA
A4GBAEhQu4uA6rrVE4n28jbRHvnvW6oKllEnAxZdAU1eXxVQV/5haTN0QWSX6vojOatC+6qJ
7d7BmlxtHHVb0ZNnZLldotB8JJkyyeB0yzMieewYzCVmPcnQ4mPgItaSDZoyIKv6iNGoq3gc
qjXnuvKvj2lhO231tV736mQ+ekLpwoo7MIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUF
ADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNh
dGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4X
DTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoT
HFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxV
c1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J
8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9I
BH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0f
BDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1h
aWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRl
TGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3d
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCA2Qw
ggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhB1uFSSFEFdLtdTZ3y6RdiFMAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDUyMTAwMzkyNFowIwYJKoZIhvcNAQkEMRYEFK4Z
xWm+Q1WO45LoJc7LjnaRpKJpMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTAN
BgkqhkiG9w0BAQEFAASCAQB3ijhMIJzMbqXzFO517li3x5jzfRy+dCoyoHhtjPtkywrlet8/
rJ5VCJTQ0ejYYjK30z+d98HhXnk3de2YA0+3o7SAkWQwR+sp7hO1BTf3yWvhA3fmK3rinqi/
wVgUpPjpGgZM0IzRb2Ap706nxU9ROwsVwOuw4zDwz0CLFORz96Ya9EH1V3gzWS+Ssswjpeb4
rNpbzWm3vkkOhIWyP5n6O1OuMmSkN4q9mq2aORtG5FSEJdv9Uwguqex4kcTWnh/e2a7OInoY
ub4UeIv+RQcgq0RS6KQi2K4SosRJWt8b/b0m9IO/APXo183jyC/BK4dYuNYt4XlwHpdpMyLB
Q6T0AAAAAAAA
--------------ms070207060200090605040707--
