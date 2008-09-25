From: Philip Balister <philip@balister.org>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 09:27:02 -0400
Message-ID: <48DB91A6.5080900@balister.org>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>	<20080923115053.e404f43e.jarkko.nikula@nokia.com> <20080925140531.64fd14c9.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080103040300000807000601"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:32329 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223AbYIYN1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 09:27:08 -0400
In-Reply-To: <20080925140531.64fd14c9.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Arun KS <getarunks@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, sakoman@gmail.com

This is a cryptographically signed message in MIME format.

--------------ms080103040300000807000601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jarkko Nikula wrote:
> On Tue, 23 Sep 2008 11:50:53 +0300
> "ext Jarkko Nikula" <jarkko.nikula@nokia.com> wrote:
> 
>> On Tue, 23 Sep 2008 11:56:00 +0530
>> "ext Arun KS" <getarunks@gmail.com> wrote:
>>
>>> Hi all,
>>>
>>> I am writing an ASOC driver for tlvaic23 on osk5912 platform.
>>> When do an aplay, I m getting a  NULL pointer dereference. I added
>>> some debug prints in the soc/core/pcm_native.c, also in codec and
>>> platform drivers. The null pointer is comming in IOCTL
>>> SNDRV_PCM_IOCTL_SYNC_PTR. Log is pasted below.
>>>
>> It's good that you can reproduce this on OSK as well.
>>
>> I think some configuration difference is revealing this bug out. For
>> instance I can trigger this on Beagle with overo_defconfig + manually
>> adding support for Beagle (CONFIG_MACH_OMAP3_BEAGLE=y) and ASoC
>> Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>
>> But I cannot reproduce this with Beagle defconfig + manually adding
>> support for Overo (CONFIG_MACH_OVERO=y) and ASoC Beagle
>> (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>
> I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
> bug both with N810 and Beagle but not when using CONFIG_SLAB.
> 
> Can you try will the problem disappear on your OSK and Overo if you
> select slab allocator instead? You find selection under "General
> setup" menu.

I've also verified this works on a Beagle with Angstrom.

Thanks for tracking this down!

Philip

> 
> 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--------------ms080103040300000807000601
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
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDkyNTEzMjcwMlowIwYJKoZIhvcNAQkEMRYEFIGz
U2sSVOCH/y1CMOI50OBx7VSgMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTAN
BgkqhkiG9w0BAQEFAASCAQCQX8U78mah6l1Ps4nmGYfakuqFTdQ+ckBo6fkeYqN2z+WCb94j
XP6e1MAcPQ1jNJhVOSs+4TXFvSJXPldjFtidtfI/JDPyB+vJfasTs9rpuUP/FcB0T83YW1DB
gIQ+HccYUzTGPN8IRuGvYhSHka1M90RRRGfit54TPpAkSm3pjxpZNhOqi8p7XiS2mIx3HOAz
V24eOnk2e7mNXrCFc794AQjZuVYbZ7I4xlsWjHRURJbgDbdIuA6K1yYNopCGhyw9X8xrJhtQ
cnJTI7ADWR5MdsoOp/tRvhaZE1ji+7gM9VY3ClQdFx4WW1VskaIaHceTi5b4ZYv9kBkocnZ1
xbNhAAAAAAAA
--------------ms080103040300000807000601--
