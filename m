From: Philip Balister <philip@balister.org>
Subject: Kernel oops when shutting down program using usb device
Date: Wed, 16 Jul 2008 17:26:13 -0400
Message-ID: <487E6775.7070804@balister.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010507070503040708040304"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:19317 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753492AbYGPV0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 17:26:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010507070503040708040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The program streams data from the USRP (Universal Software Radio 
Peripheral) and calculates a transfer rate. It looks like the test 
completes and the program ooops as it is exiting.

Let me know if I can collect anything else. I am not much of a usb guy :(

Philip

root@beagleboard:~/gnuradio-3.1.2/usrp/host/apps# 
./test_usrp_standard_rx -D 200rx_overrun
eth0: set allmulti
eth0: set allmulti
eth0: set allmulti
eth0: set allmulti
xfered 1.34e+08 bytes in 116 seconds.  1.159e+06 bytes/sec.  cpu time = 
1.633
noverruns = 1
------------[ cut here ]------------
WARNING: at lib/kref.c:43 kref_get+0x28/0x44()
Modules linked in: ipv6 pegasus
[<c0037b88>] (dump_stack+0x0/0x14) from [<c0053c44>] 
(warn_on_slowpath+0x4c/0x68)
[<c0053bf8>] (warn_on_slowpath+0x0/0x68) from [<c0176064>] 
(kref_get+0x28/0x44)
  r6:c7cbd1c0 r5:c700a880 r4:c700a880
[<c017603c>] (kref_get+0x0/0x44) from [<c01eac18>] (usb_get_urb+0x18/0x20)
  r5:c700a880 r4:c700a880
[<c01eac00>] (usb_get_urb+0x0/0x20) from [<c01e9fa0>] 
(usb_hcd_flush_endpoint+0xa0/0xcc)
  r5:c700a880 r4:c7cbd1b8
[<c01e9f00>] (usb_hcd_flush_endpoint+0x0/0xcc) from [<c01eb1a0>] 
(usb_disable_endpoint+0x5c/0x6c)
  r7:c7c9e000 r6:c7cbd548 r5:c7c9e000 r4:c7cbd1c0
[<c01eb144>] (usb_disable_endpoint+0x0/0x6c) from [<c01eb2dc>] 
(usb_disable_interface+0x34/0x4c)
  r5:00000028 r4:00000001
[<c01eb2a8>] (usb_disable_interface+0x0/0x4c) from [<c01edec0>] 
(usb_unbind_interface+0x44/0xa0)
  r7:00000000 r6:c041a884 r5:c7fc6200 r4:c7fc6220
[<c01ede7c>] (usb_unbind_interface+0x0/0xa0) from [<c01b99e4>] 
(__device_release_driver+0x78/0x98)
  r9:c718c000 r8:c7c9e108 r7:00000001 r6:c7fc6200 r5:c041a884
r4:c7fc6220
[<c01b996c>] (__device_release_driver+0x0/0x98) from [<c01b9ab8>] 
(device_release_driver+0x24/0x30)
  r5:c7fc62c8 r4:c7fc6220
[<c01b9a94>] (device_release_driver+0x0/0x30) from [<c01eda20>] 
(usb_driver_release_interface+0x54/0x90)
  r5:c7c9e060 r4:c7f91180
[<c01ed9cc>] (usb_driver_release_interface+0x0/0x90) from [<c01f0e74>] 
(releaseintf+0x58/0x64)
  r7:00000001 r6:c7fc6200 r5:00000002 r4:c7f91180
[<c01f0e1c>] (releaseintf+0x0/0x64) from [<c01f1024>] 
(usbdev_release+0x80/0xec)
  r7:00000001 r6:c7c9e000 r5:00000002 r4:c7f91180
[<c01f0fa4>] (usbdev_release+0x0/0xec) from [<c00a1efc>] (__fput+0xb8/0x170)
  r9:c718c000 r8:c78ec080 r7:00000006 r6:c700ab80 r5:c707d3d0
r4:00000008
[<c00a1e44>] (__fput+0x0/0x170) from [<c00a2270>] (fput+0x30/0x34)
[<c00a2240>] (fput+0x0/0x34) from [<c009ee78>] (filp_close+0x74/0x80)
[<c009ee04>] (filp_close+0x0/0x80) from [<c00a0390>] (sys_close+0x84/0xb8)
  r7:00000006 r6:00000000 r5:c700ab80 r4:c7fefb40
[<c00a030c>] (sys_close+0x0/0xb8) from [<c0033b00>] 
(ret_fast_syscall+0x0/0x2c)
  r5:40050250 r4:00012668
---[ end trace fa9f194ff0bebebb ]---

--------------ms010507070503040708040304
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
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDcxNjIxMjYxM1owIwYJKoZIhvcNAQkEMRYEFE7b
vmQuQXZjSt/ZKrNLAzFw+s2AMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdbhUkhRBXS7XU2d8ukXYhTAN
BgkqhkiG9w0BAQEFAASCAQBjDwo2kVOt/X66ljY4dc8xiLspl44QmiGGpJAgMxyemu2OGSmj
m+UDCx2Ulo3RvUiLfNCE5OWd7260+Yt19HSCBdmbTzd7t1b7R4J0wTset93Doeo8SPYNbyk0
AcE6V9/wL3r9JDZdpigHmm59a0RcZFue8mFfMt60LzB+Lx2VppQqraD3k2sGh5834ZW213ct
jFk9UIaBL3BXg/WlILJWXHpuN/MdIyFUUp5vnl4DK+FYyYhiYkT7OY5SpFuGOJO0O54fY2d3
tIRlLiBTNMU4tjZCAvCBpi786YARtDLNocCBG892FrhrTfym+mNIgxw/UmeuDORbvg82Uk+C
Ami1AAAAAAAA
--------------ms010507070503040708040304--
