From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 4 Oct 2010 20:13:26 +0800
Message-ID: <AANLkTinR2ZKBNXic+4KF+L+W1eQfsEZbqeXfzEjdXc9V@mail.gmail.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47099 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab0JDMN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 08:13:27 -0400
Received: by wwj40 with SMTP id 40so3999691wwj.1
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 05:13:26 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2010/10/4 Premi, Sanjeev <premi@ti.com>:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ming Lei
>> Sent: Sunday, October 03, 2010 2:34 PM
>> To: Kevin Hilman; linux-omap@vger.kernel.org
>> Subject: beagle hangs in uart3 disabling clocks
>>
>> Hi,
>>
>> I just tested pm branch of tony's linux-omap-2.6 tree, and found my
>> beagle will hang in uart3 disabling clocks, follows the log info:
>>
>>
> [snip]..[snip]
>
>>
>> Texas Instruments X-Loader 1.41
>> Starting OS Bootloader...
>>
>>
>> U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)
>>
>> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
>> OMAP3 Beagle Board + LPDDR/NAND
>> DRAM: =A0128 MB
>> NAND:
>
> Lei,
>
> Couldn't help noticing the version information for x-loader and
> u-boot. Both seem to be quite old...
>
> Could you try update both? May be, there is a dependency...

No difference even update x-load and u-boot with those in the link belo=
w:

http://code.google.com/p/beagleboard/wiki/BeagleboardRevC3Validation


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
