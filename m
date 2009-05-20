From: Philip Balister <philip@balister.org>
Subject: Re: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 13:13:16 -0400
Message-ID: <4A143A2C.8050307@balister.org>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com> <878wkrpuzp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090407010505020807030208"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:8012 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756761AbZETRUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 13:20:04 -0400
In-Reply-To: <878wkrpuzp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090407010505020807030208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote:
> "Gadiyar, Anand" <gadiyar@ti.com> writes:
> 
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org 
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hemanth V
>>> Sent: Wednesday, May 20, 2009 11:27 AM
>>> To: linux-omap@vger.kernel.org
>>> Subject: [PATCH 2/2] McSPI Slave and DMA,FIFO support
>>>
>>> This patch adds MUX changes for SPI2 and also adds an
>>> option for test driver
>>>
>>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/board-3430sdp.c   |   26 ++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/mux.c             |   11 +++++++++++
>>>  arch/arm/plat-omap/include/mach/mux.h |    7 +++++++
>>>  3 files changed, 44 insertions(+)
>>>
>>> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
>>> ===================================================================
>>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:02:34.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:05:22.000000000 +0530
>>> @@ -228,6 +228,13 @@
>>>  	.single_channel	= 1,	/* 0: slave, 1: master */
>>>  };
>>>
>>> +#ifdef CONFIG_SPI_DEBUG
>>> +static struct omap2_mcspi_device_config dummy_mcspi_config = {
>>> +	.turbo_mode	= 0,
>>> +	.single_channel	= 1,  /* 0: slave, 1: master */
>>> +};
>>> +#endif
>>> +
>>>  static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
>>>  	[0] = {
>>>  		/*
>>> @@ -242,6 +249,18 @@
>>>  		.irq			= 0,
>>>  		.platform_data		= &tsc2046_config,
>>>  	},
>>> +#ifdef CONFIG_SPI_DEBUG
>>> +	[1] = {
>>> +		/* SPI test driver attached to SPI2 controller by
>>> +		 * default
>>> +		 */
>>> +		.modalias		= "spitst",
>>> +		.bus_num		= 2,
>>> +		.chip_select		= 0,
>>> +		.max_speed_hz		= 1500000,
>>> +		.controller_data	= &dummy_mcspi_config,
>>> +	},
>>> +#endif
>>>  };
>>>
>>>  static struct platform_device sdp3430_lcd_device = {
>>> @@ -666,6 +685,13 @@
>>>
>>>  static void __init omap_3430sdp_init(void)
>>>  {
>>> +
>>> +	/* SPI2 Pin MUX */
>>> +	omap_cfg_reg(AA3_3430_McSPI2_CLK);
>>> +	omap_cfg_reg(Y2_3430_McSPI2_SIMO);
>>> +	omap_cfg_reg(Y3_3430_McSPI2_SOMI);
>>> +	omap_cfg_reg(Y4_3430_McSPI2_CS0);
>>> +
>> This will still change the padconf for this port unconditionally.
>>
>> How do we handle the case where the same platform (SDP in this case)
>> could have different configurations McSPI2 vs USBHOST2, etc? Is there
>> a clean way, or do we have no option but to use a CONFIG option?
> 
> What about building both as modules and doing the muxing on module
> load with a warning if it's taking the pins away from antother
> feature.
> 
> Longer term, we need a more dynamic way to request pins when there are
> conflicts like this.

I'm tempted to leave the pinmux setup to u-boot even. That is the 
approach I'm using setting up SPI for the beagleboard.

Philip

--------------ms090407010505020807030208
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
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDUyMDE3MTMxNlowIwYJKoZIhvcNAQkEMRYEFPEg
M074z4XF9f0L+1D7EkdJAUSzMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkr
BgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQLCV6f+hRygN3VWs2oqn9/DCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQLCV6f+hRygN3VWs2oqn9/DAN
BgkqhkiG9w0BAQEFAASCAQAhwY0JvLOvMPvfgoqxfCNB5hyn2cbKdXJXlP4QpakKunqrZJE9
Hkl7s/HfRTfbuJH+5j6oGPRF3ptnNv5ZDBJ8u3ALgZ947ySk14Bo9jEzWOSi5i6/kd49s8Yj
Ddq4x+VZUqugGBPZfhSOMYViz6D67mt5u+aEbSN/GjDSPCOmtOqx3UnL+gJGrMWWdiAfp1m1
pg9iDTXFPTuTmMZqVWf/lomkncadvoxPQDKhoozzgh1+g2VqPwh/LhgBzZBcN8xB4H+BsHws
Y2vTsq3WdKU9aMAi/gtT3IBAAHuAqSVzFSVuLaG4oS+0B8IORnwGv7Q9XAiOVwkRrHyVYAIv
Lu/xAAAAAAAA
--------------ms090407010505020807030208--
