From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
 	please read
Date: Thu, 01 Oct 2009 11:31:48 +0300
Message-ID: <4AC468F4.1070406@nokia.com>
References: <20090928190404.GE18957@atomide.com>	 <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>	 <20090929182639.GA16865@atomide.com> <4AC37F0E.8010206@nokia.com>	 <71a0d6ff0909301002k7e56b7falfdc8d5e445487d29@mail.gmail.com>	 <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E2@dbde02.ent.ti.com>	 <20090930173132.GN16865@atomide.com> <4AC45A87.20605@nokia.com> <71a0d6ff0910010058m6f9f4fc0o70ef0d2020e170b3@mail.gmail.com> <4AC46302.20402@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000104020907040900030602"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26366 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbZJAIc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 04:32:28 -0400
In-Reply-To: <4AC46302.20402@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Alexander Shishkin <virtuoso@slind.org>
Cc: ext Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000104020907040900030602
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Roger Quadros wrote:
> ext Alexander Shishkin wrote:
>> 2009/10/1 Roger Quadros <ext-roger.quadros@nokia.com>:
>>> ext Tony Lindgren wrote:
>>>> * Gadiyar, Anand <gadiyar@ti.com> [090930 10:05]:
>>>>>>>>> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
>>>>>>>>> other people report similar issues:
>>>>>>>>> http://www.spinics.net/lists/linux-omap/msg17968.html
>>>>>>>>>
>>>>>>>>> Have you got 2.6.32-rc1 (+fixes) to boot?
>>>>>>>> Hmm, looks like it's musb again. This is what I get on my
>>>>>>>> overo after applying the DEBUG_LL hack from omap-debug branch:
>>>>>>> i've just sent a fix for this musb problem. patch is labelled "twl4030:
>>>>>>> Fix
>>>>>>> boot with twl4030 usb transceiver enabled"
>>>>>> I can't quite locate it in linux-usb archives (or anywhere within
>>>>>> google's reach). Could you sand it here or provide a link?
>>>>>>
>>>>> Here you go. Patchwork rocks!
>>>>>
>>>>> <http://patchwork.kernel.org/patch/50721/>
>>>>>
>>>> Great, thanks. Roger, please send your fix to Samuel for merging.
>>>>
>>>> Meanwhile, I'll apply it into fixes-testing while waiting for it
>>>> to get to mainline via Samuel.
>>>>
>>>> Regards,
>>>>
>>>> Tony
>>> OK Tony, I'll do that.
>> It doesn't crash any more, but I fail to get it to work either:
>> /sys/devices/platform/musb_hdrc/mode always says b_idle no matter what
>> I do and the host never attempts to enumerate it (I have a g_ether
>> statically compiled in for a gadget). Hints greatly appreciated.
>>
>> Regards,
>> --
>> Alex
> 
> Can you retry if it works without my patch and reverting commit
> 66760169492445395c530c812443f58e2cfdb3dc
> 
> cheers,
> -roger
> 

Also please try the attached patch on l-o HEAD.
It worked for me with file_storage driver.

dd if=/dev/zero of=/tmp/medium bs=1024 count=1024
modprobe g_file_storage file=/tmp/medium

-roger

--------------000104020907040900030602
Content-Type: application/x-gzip;
 name="0001-twl4030-Fix-boot-with-twl4030-usb-transceiver-enabl.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-twl4030-Fix-boot-with-twl4030-usb-transceiver-enabl.pat";
 filename*1="ch.gz"

H4sICNlmxEoAAzAwMDEtdHdsNDAzMC1GaXgtYm9vdC13aXRoLXR3bDQwMzAtdXNiLXRyYW5z
Y2VpdmVyLWVuYWJsLnBhdGNoAL1Xa2+bSBT9DL/ibj9EdmwI2NghzqZq2iRtJeexttNqtVqh
AQZnNhhcZnDibfPf985AHL/bZKtatoA7cObcmXvPMWdZOgK3EUak2Q7IQSvab1Db3idWM3Sa
B8QPWpZz4Put1r7j23CeJtCnY7D3wbI66gsNy7L1M4TpQC8d0gz+yEmYpRx+p/fCyGTI/FKE
3iTpLSNmkI5e6ydE0A58pmEdmpYCRaADsN1Oo91p7kPNalqW3s/9f2ggOvDX1fHg3QeYNP4G
cRc7ONiBM3YPfpoKuGPi5jEMOfdBZCThAWUTpEMT4sc01PXBDVWDGR3mMRFpBjwfj2NGOVQw
bk9adVBHF3bkSXNiV2GUcwE+BTIhLJZAuk+jNMNAGLJkCAJBy5k9CR7csBhTojFfiHtxmHos
YaJSRbZxrJP4jkw5RIiKGDmHgORcAqqE4jS4NfKxKUkzDmMighuI2D1SVeO4DZfnx1fAp1zQ
EYfi0Tkuy6tg6u8uL84+vvcGn7uK03X/7dFU1/tsmNDQSKPI8KfP20DDMHQIM4nO90ZRuFdO
bQS4PGYA3wDAPYDa2o+x7qODjUnGmGRwQ5KhLA2nDSzhNBMsTXilVsVIE0Ia0yJgVHU9ZFEE
hjFkAsjeFj7+lkGdJSG9B+o0nCBqmyZ1mw16sA+2ZbUdR6a6FVvHjLbjv3kDhuNadaxreWgD
BrggggWYn9BlNXmqdDKaVLjI8kDMymeMxYolN/JCIgjsjuUBKzXhau+wVnDrI0pEnlFe1eGr
DlqJENIJC6i2q5APdWM5LgtzvlWO4OK62z3UASFYBBVk4N0Q7vkBw7rd2QE1t/Ear+XVb5XH
abFhBld9r3/9tn86qFYVB03Nipiz3CrNOrx6zAoxXtXVurSajbrdhlqradfbtlyZn7ga2sNK
Npj1QjZ4LRnX9JqmlXtSzjlTCi/AastHNPOUZEwLnWhhcl/lU5pZho+0V8UIpobxh8NnY7ob
Md0XYqKMbcDEkSdMPO7toqRmqHe4/kpMZrgceIoRImR4ilqVSE3MOS64P11Q2909CTi/3DOQ
iioMSQMnElLX8EsABUzuKS3wh1Rg+6djhtAFlraSpNTRYvtlAUtZDGcZaqZcAmSEbcXNCYlZ
6I3SkHJvRPgtHBU3ab3T99fd48Flzzu/PDn1Li5758fdcuwbLI32B8cXJ2//rG+cIB1vhH/3
4fji/anCWQNfjuIEg+t+gV/uxWL7POUes+SWhpVHGUco7xNquf2pVdLTNFCfndna1NW5sje7
qqpH7c/Hvnfa61XUNNVq8XBGsW8SuBr05sZeSMj9LiH3VxJqfrK/Qwjb4f8ResDDWt2z5nQP
J8KmA4n1pD914OxfmkaV3TlNKu/C6qflKfYNy75YiI0JeVe9035dBuwiIPtlHhdHPJ/g/5Aa
uPhr1GF1wFHcYW2+sDldKamSzR2FhGL3iRR7NknofJtyGVVtvqQPhqatGk9pUZu1Qwp2MX3Z
6UVNm+hlC48XcXdtHHd4Jf6w1iPu5D+uMB0WmqVcCm3bQftuN5zCvn+mSW1eaMXN2LYoS2sp
+RovMjJjg5EZSpSei+luxHRfiPloZKuYhZGVmPL44wZjPMNfjB+wF6PQl/X+Ymy3lw34c+6y
gj5vLyvoS+4ytz4LvbNUQIezG9ztNzx10+oN8pZnG9i8IhfZLBiXsValjM3N8xIW7kYW7i9j
Ia1qPYuZRT2fBQoJvmDJzhiRqa/eX6F7csmLriD4RpuOmBBY6vhyGaQc3/xomAd4PSYZtowy
ly0y9IyXgacnFzK/6nafPGoyjuOG5G2Abptt0zIdXf8PKSfpC60QAAA=
--------------000104020907040900030602--
