From: Philip Balister <philip@balister.org>
Subject: Re: MMC3 Overo
Date: Thu, 06 Aug 2009 11:09:07 -0400
Message-ID: <4A7AF213.6040301@balister.org>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>	<bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>	<bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>	<873a866xdo.fsf@deeprootsystems.com>	<bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>	<5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>	<4A79C83E.9040603@deeprootsystems.com>	<5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>	<4A79D104.60607@deeprootsystems.com>	<bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>	<bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com> <871vnp8170.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020109000401060001040507"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:5862 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbZHFPJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 11:09:11 -0400
In-Reply-To: <871vnp8170.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020109000401060001040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote:
> John Sarman <johnsarman@gmail.com> writes:
> 
>> On Wed, Aug 5, 2009 at 2:35 PM, Kevin Hilman<khilman@deeprootsystems.com> wrote:
>>> Steve Sakoman wrote:
>>>> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
>>>> Hilman<khilman@deeprootsystems.com> wrote:
>>>>> Steve Sakoman wrote:
>>>>>> And up to now in each case I shrug and say "no time to do that now,
>>>>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>>>>> I agree there are lots of shortcomings in the current mux code and we've
>>>>> been hitting them regularily lately.
>>>>>
>>>>> That being said, for mux settings that done one-time only at boot, what
>>>>> are
>>>>> the problems you're running into?
>>>> It's been a few months since I last encountered this, so the exact
>>>> details are a bit fuzzy.
>>>>
>>>> I seem to recall that there were some basic issues with enabling
>>>> kernel pinmuxing in that some of the setup that was done for all
>>>> machines was just wrong for my particular machine.  IIRC, it was due
>>>> to assumptions about which pad was used for a particular function (for
>>>> those functions which can be steered to multiple GPIO pads).
>>>>
>>>> So I faced having to undo that change in my board file as well as any
>>>> issues that may have arisen from glitches on the GPIO pins during the
>>>> process.  And since there were several of these I gave up and turned
>>>> off kernel pinmuxing.
>>>>
>>>> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
>>>> just that subset that truly does fit all boards, and leave the rest to
>>>> the board files.  I'd also be content to have it all done in the board
>>>> file for each machine.
>>> Indeed, any assumptions about common muxing that are not indeed common are
>>> bugs and should be fixed.
>>>
>>> The "right" solution is to have everything in the kernel, and split across
>>> SoC "common" init and board specific init.  Of course u-boot
>>> will still have to do some early muxing, but it should be redone in
>>> the kernel so it's trivial to change bootloaders.
>>>
>>> So the real missing piece is someone to step up and rework the mux code.
>>> The bigger problem is that the vast majority of folks don't care about the
>>> common case and only care about getting thing working for a specific
>>> platform.
>>>
>>> Kevin
>>>
>> I  like the idea of having the board file configure the mux.  First of
>> all lets address the shortcomings of mux.h.  The Pin values are
>> labeled as so:
>> <snip from mux.h>
>> * NOTE: Please use the following naming style for new pin entries.
>>  *       For example, W8_1610_MMC2_DAT0, where:
>>  *       - W8        = ball
>>  *       - 1610      = 1510 or 1610, none if common for both 1510 and 1610
>>  *       - MMC2_DAT0 = function
>>
>> But lets take the 3530 as an example.
>>  The 3530 has three separate packages.  CBB, CBC, and CUS.  Now lets
>> look at MMC3_clk (the root of my original problem that started this
>> thread)
>>                        CBB              CBC            CUS
>> mmc3_clk         AB1 / AF10    R9 / AB2     AC1
>>
>> So to properly add these to mux.h we need to add 5 entries for mmc3_clk
>>       AB1_35XXCBB_MMC3_CLK
>>       AF10_35XXCBB_MMC3_CLK
>>       R9_35XXCBC_MMC3_CLK
>>       AB2_35XXCBC_MMC3_CLK
>>       AC1_35XXCUS_MMC3_CLK
>> We would then have to update mux.c making sure the position matches
>> and add the proper settings.
>>
>> So this is obviously a maintenance nightmare.
> 
> So why don't we drop the ball (pun intended.) ;)
> 
> This is what I proposed to Phillip Ballister for his SPI changes for Beagle.
> 
> Though I haven't looked at the details for each package, I have a hard
> time imagining that the reg offsets and functionality for each package
> is different.  In fact, I'm pretty sure they're even the same between
> 34xx and 35xx.  
> 
> IOW, why not just name it OMAP3_MMC3_CLK and have a single entry.
> 
> Then each board file that cares simply has to call omap_cfg_reg() on
> that name and not care about the package.

They first problem I see is the MMC3_CLK is available on multiple balls, 
so the mux files need to list them all.

Unless you are proposing custom mux files for each board? Is this is 
good idea (just had this thought). In other words, instead of trying to 
come up with one set of mux files, make them board specific.

Philip

--------------ms020109000401060001040507
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
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
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCA2Qw
ggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhAsJXp/6FHKA3dVazaiqf38MAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDgwNjE1MDkwN1owIwYJKoZIhvcNAQkEMRYEFDtp
JZgOT/eHs7wZc1fcqYv+YaDOMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQLCV6f+hRygN3VWs2oqn9/DCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQLCV6f+hRygN3VWs2oqn9/DAN
BgkqhkiG9w0BAQEFAASCAQC7Dat/zEmhDV4IljAw1DHhBvVy3sYzNGEszfzwIX4hQeUKFsTa
cPdsUfGlrYUH9glWeG8oQUjky0f9orBv6O5l6B8d5k3oHiIKymGWqZE0qx3qsuPfaUVYX6QM
b4427xmchYQKNFLGn6Wg66pTlYYYZPCmRyFSGJrD+6qhmZp0gZIyRXKPDUyAgXpAzfrbfSoK
yeowGHgYakb+J/7YZIFApDgpmnSH6am8QJZkkiAczLY6eUEkT6bg1CW9mdB7LXWamvS6LVMa
jAzxTeYhGZUOgac/efBZv2swXZntKiCa3iXXJTAROaE8yIRnNM47XsmCgOdZaw590hsH2o3K
9flDAAAAAAAA
--------------ms020109000401060001040507--
