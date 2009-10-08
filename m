From: Philip Balister <philip@balister.org>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins	for
 omap7xx)
Date: Wed, 07 Oct 2009 19:32:32 -0700
Message-ID: <4ACD4F40.5020707@balister.org>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com> <4ACB7EC0.3010401@ti.com> <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com> <87hbucp6ng.fsf@deeprootsystems.com> <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com> <878wfop4rc.fsf@deeprootsystems.com> <20091007174750.GG7899@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms040505090000070004050707"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:33238 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753428AbZJHCdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 22:33:14 -0400
In-Reply-To: <20091007174750.GG7899@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040505090000070004050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/07/2009 10:47 AM, Tony Lindgren wrote:
> * Kevin Hilman<khilman@deeprootsystems.com>  [091006 15:18]:
>> "Menon, Nishanth"<nm@ti.com>  writes:
>>
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>>>
>>>>>>>         W17_7XX_USB_VBUSI,
>>>>>>> +
>>>>>>> +       /* MMC */
>>>>>>> +       MMC_7XX_CMD,
>>>>>>> +       MMC_7XX_CLK,
>>>>>>> +       MMC_7XX_DAT0,
>>>>>>
>>>>>> probably a dumb question ->  but should'nt these go off to bootloa=
der
>>>>>> perhaps?
>>>>>>
>>>>>
>>>>> Perhaps, although we use either EOL (for HTC Wizard) or Haret to bo=
ot,
>>>>> and they don't set up the right mux configuration for our board.
>>>>>
>>>>> This way though, we don't have to worry about the boot loader -- we=

>>>>> can set it up right regardless of who boots us.
>>>>
>>>> I agree with Cory.
>>>>
>>>> I prefer that mux settings go into the kernel, even if they are setu=
p
>>>> in the bootloader already.  It's better to have redundancy than wond=
er
>>>> what to do if changing boot loaders.
>>>>
>>> Probably opening up a can of worms.. Are the rules different for OMAP=
3?
>>> Should'nt we have all mux done at kernel so that kernel is loader
>>> independent?
>>
>> Yes, we should.  My preference is to always have muxing in the kernel.=

>
> Agreed. We still should support bootloader only muxing too.
>
> BTW, I've been thinking about the following sets of patches for the nex=
t
> merge window:
>
> 1. Do the include directories for mach-omap1 and mach-omap2 as suggeste=
d
>     by Russell earlier

Does anyone have a reference to Russell's suggestion?

Philip


>
> 2. Move all mux code to only live under arch/arm/*omap*/ and make sure
>     drivers don't call omap_cfg_reg() any longer
>
> 3. Remove the enumeration for the mux and require all the boards to
>     register the pins they'll use
>
> After these it should be trivial to improve the mux code further. The
> steps 2&  3 above will be most likely breaking things for some boards,
> so help will be needed with testing.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--------------ms040505090000070004050707
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJRTCC
Av0wggJmoAMCAQICECwlen/oUcoDd1VrNqKp/fwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDQxNTAwNDQ1OFoX
DTEwMDQxNTAwNDQ1OFowYjERMA8GA1UEBBMIQmFsaXN0ZXIxDzANBgNVBCoTBlBoaWxpcDEY
MBYGA1UEAxMPUGhpbGlwIEJhbGlzdGVyMSIwIAYJKoZIhvcNAQkBFhNwaGlsaXBAYmFsaXN0
ZXIub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx5Xoie8CV9dJeiaiKRdy
lvicHE9Aha6f9/CLlVs+Ezob7fIuRa4P9ugzZZ2VCtPMQU3Qsjw35mVmYaKXB1U+fZeffbya
d6OJEIK1jhqBIz5jtJMc/YWXn/bRmqClMfTCgilUMOcsfiHAbmLVhYiNbEhOuy6vWdxSSolH
qVa/IHE72qqjhoYWHd+5XVfx1c4jW+CePNMQEHxjCzuD+wq6Mzle72dXw+bnyIpG99hB26uN
mV//h5iz1VmJU63FZWynSjG79NcY9+mTWXeX213VV6kJ2wce2rETbYvKQ7err6NnZnG/tiwG
I1M7fQqQAti+CkDciLJ129LO+APVYZQgEwIDAQABozAwLjAeBgNVHREEFzAVgRNwaGlsaXBA
YmFsaXN0ZXIub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAIUyDAPIEniN6
SUdbDiBqi2dtITdnkoUItm/tX9TRn66P0VtWug7k7xjo6piWRE7BZwhihotNY0ZnjlK+h0Vo
rxfY63B5tarRB6qJ7f26ukmpltwWWLDB2hWFoKUCn6PE2NTdj+1xNinhZNQHy4GyygXjlVfV
Sn/ZnaGJ31z4PK0wggL9MIICZqADAgECAhAsJXp/6FHKA3dVazaiqf38MA0GCSqGSIb3DQEB
BQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0w
OTA0MTUwMDQ0NThaFw0xMDA0MTUwMDQ0NThaMGIxETAPBgNVBAQTCEJhbGlzdGVyMQ8wDQYD
VQQqEwZQaGlsaXAxGDAWBgNVBAMTD1BoaWxpcCBCYWxpc3RlcjEiMCAGCSqGSIb3DQEJARYT
cGhpbGlwQGJhbGlzdGVyLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMeV
6InvAlfXSXomoikXcpb4nBxPQIWun/fwi5VbPhM6G+3yLkWuD/boM2WdlQrTzEFN0LI8N+Zl
ZmGilwdVPn2Xn328mnejiRCCtY4agSM+Y7STHP2Fl5/20ZqgpTH0woIpVDDnLH4hwG5i1YWI
jWxITrsur1ncUkqJR6lWvyBxO9qqo4aGFh3fuV1X8dXOI1vgnjzTEBB8Yws7g/sKujM5Xu9n
V8Pm58iKRvfYQdurjZlf/4eYs9VZiVOtxWVsp0oxu/TXGPfpk1l3l9td1VepCdsHHtqxE22L
ykO3q6+jZ2Zxv7YsBiNTO30KkALYvgpA3IiyddvSzvgD1WGUIBMCAwEAAaMwMC4wHgYDVR0R
BBcwFYETcGhpbGlwQGJhbGlzdGVyLm9yZzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUA
A4GBACFMgwDyBJ4jeklHWw4gaotnbSE3Z5KFCLZv7V/U0Z+uj9FbVroO5O8Y6OqYlkROwWcI
YoaLTWNGZ45SvodFaK8X2OtwebWq0Qeqie39urpJqZbcFliwwdoVhaClAp+jxNjU3Y/tcTYp
4WTUB8uBssoF45VX1Up/2Z2hid9c+DytMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUF
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
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCA3Ew
ggNtAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhAsJXp/6FHKA3dVazaiqf38MAkGBSsOAwIaBQCgggHQMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MTAwODAyMzIzMlowIwYJKoZIhvcNAQkEMRYEFHX0
TS23JVfekcb3w2BJtfUjRX9nMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0ECECwlen/oUcoDd1VrNqKp/fwwgYcGCyqGSIb3DQEJEAILMXig
djBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRk
LjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECECwlen/o
UcoDd1VrNqKp/fwwDQYJKoZIhvcNAQEBBQAEggEAURf9pnndn9OSvSaozUmrxqnPP2wleYoH
a4eoHkJXy511bT96Jl1237MKydeTaN1Vk1paCoIPqiNGO8T7nn4oeZVlE+l91ibNbD+weoh1
sPrxG2HCWRFR5kKRfzGKv/EdYTIUoa7FHr1NNPopLi/fyIjSqTcO//GvwDC94Bb/ZHJ/MgZu
dAaomKGAu/HsE5MDV+VDQzDvKjuJL00QZgfLEpmRTfk/ExKNHDtRprnBiMfjQ1hKbRxZG5Ry
B50951mrcAscntijk4CrBNA5AuEJpYDRruz6J2EfXLSY78tRJuKPqN0r/lfc02TQrMtKpq/w
WwXb27p2I+PybTEY5bk2bgAAAAAAAA==
--------------ms040505090000070004050707--
