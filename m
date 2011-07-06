From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: Re: AM3505/3517 support
Date: Wed, 06 Jul 2011 09:59:22 -0400
Message-ID: <4E146A3A.5070100@8d.com>
References: <4E121485.6060700@8d.com> <B85A65D85D7EB246BE421B3FB0FBB593024D91A50F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:50484 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab1GFN7Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jul 2011 09:59:24 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D91A50F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 05/07/11 05:59 AM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rapha=EBl Ass=
=E9nat
>> Sent: Tuesday, July 05, 2011 12:59 AM
>> To: linux-omap@vger.kernel.org
>> Subject: AM3505/3517 support
>>
>> Hello,
>>
>> We have a custom designed based on the AM3505 and we wish to=20
>> run a modern kernel
>> on it. Unfortunately, it seems a lot of efforts have been=20
>> made to support other=20
>> OMAP chips and that some work is still required to support=20
>> the AM3505/3517=20
>> completely. (does not boot as-is)
>>
>> Is there anyone working on this right now? Not knowing, I=20
>> have already started
>> working on it.
>>
>> The am3505 is apparently so similar to the 3430 that it was=20
>> treated as such=20
>> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There=20
>> are however a
>> few differences that need to be addressed. I have therefore=20
>> created a new
>> CHIP_IS and patched clocks, hwmod and power management related files
>> consequently. My system now boots until it complains that it=20
>> is unable=20
>> to mount its root filesystem.
>>
>> I will send my patches in a moment for comments and=20
>> hopefully, after a=20
>> few iterations, they will be acceptable. I know a lot of cleanup is=20
>> happening right now and as a result my patches may not apply=20
>> or conflict.=20
>> Please let me know and I will be happy to rebase them as needed.
>>
>> Looking forward to your comments and help.=20
>>
>> One of the next things I'll look at is how to properly=20
>> support the ZCN package.
>> Right now, the CBB package is used (board-am3517evm.c for=20
>> instance) but there
>> are differences that prevent some GPIOs from being configured=20
>> properly. It would
>> be nice to know if someone is working on this before I start...
>=20
> Raphael,
>=20
> The AM35x support has been trailing on the linux-omap. Usually,
> due to delays in dependency resolution:
>=20
> If you are not specifically looking for the latest kernel,
> revision you can get the sources from:
> http://arago-project.org/git/projects/?p=3Dlinux-omap3.git
>=20
> Use the tag: v2.6.37_OMAPPSP_04.02.00.07
>=20
> This tree is supported by TI. The patches contained here, are
> being reworked for upstream submission...
When possible, I prefer working on the latest version. But at least
I'll have a look to make sure I'm not duplicating anyone's work.

By the way, is there a specific mailing list for discussing
this git tree?

Best regards,
Rapha=EBl Ass=E9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
