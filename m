From: Philip Balister <philip@balister.org>
Subject: Re: McSPI3 on the BeagleBoard
Date: Wed, 18 Feb 2009 19:39:03 -0500
Message-ID: <499CAA27.5020500@balister.org>
References: <499B4B64.30109@balister.org> <200902171918.45146.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080401080003090907090305"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:1437 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753524AbZBSAjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 19:39:07 -0500
In-Reply-To: <200902171918.45146.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms080401080003090907090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> On Tuesday 17 February 2009, Philip Balister wrote:
>> A number of people have tried using the McSPI3 interface with the spidev 
>> driver. Running the spidev_test program shows data coming out of the 
>> interface, but when we connect the SIMO to SOMI pins, the spidev_test 
>> program shows only 0's. Someone tried wiring SOMI to +volts and still 
>> only saw 0 read.
> 
> I took a quick glance, and the pinmuxing looks sort of OK if
> you ignore the names ... use the right balls, not XXX:
> 
> +       AE2_3430_MCSPI3_CLK,
> +       AG5_3430_MCSPI3_SIMO,
> +       AH5_3430_MCSPI3_SOMI,
> +       AF4_3430_MCSPI3_CS0,
> +       AG4_3430_MCSPI3_CS1,
> 
> I suggest you start with a more focussed patch, only setting
> up McSPI3.  For one thing, the MMC2 pinmuxing will interfere
> with this set of MCSPI3 configurations.
> 
> Also, start with a less aggressive bit rate than 48 MHz; that
> may be OK on a well designed board, but breadboards tend to
> show flakiness at much over 10 MHz.

OK, more results:

1) I do not intend for this to go into the kernel, well unless there is 
an outcry from beagle users :)


Steve Sakoman suggested I do the pinmux setup in u-boot and furnished me 
with a small u-boot patch. Using this patch and removing the pinmux 
stuff from the kernel patch lead to working spidev_test.

The 48 MHz is the max rate, spidev_test defaults to 500 kHz. (but it 
appears to work at 48 MHz also.

Thanks for taking a look at this!

Philip

PS: I love photos: http://www.flickr.com/photos/32615155@N00/3291304854/

--------------ms080401080003090907090305
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
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDIxOTAwMzkwM1owIwYJKoZIhvcNAQkEMRYEFNTd
JFeKdbvuL5arB+jKhhkg1jx0MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTAN
BgkqhkiG9w0BAQEFAASCAQC1devtUnv3Tozn+OuEnNwnRscGvoJkn7EAGP63GTFDZhgJXPSl
aFmqyc9rgZaQdRODSEE5nWL//dTT7D6v9opEKhvEvZQHfbpe13HKbc12Rq/EKdUx5ZYP6i1+
YeJaJ2qEZXUA0QphmopDeFCzSWEhXN+CuwgpcHks1hn4LuAGeGh1pQ96FpF0XrIpBU0uQOey
q5cfZ5TYXVUky1yyJOJUbSomrNVp6HRADMk0HhZhPRN4QdGnvQznc4/rF/SEpcRxUSyCN8Io
QrITzXPwdEwxpGIEuvvG4jNQqr65CsdDUTSzKE1sftuzXkBD43I2c0JBIwczL1fdpqp41NvW
Hss6AAAAAAAA
--------------ms080401080003090907090305--
