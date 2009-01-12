From: Tony Lindgren <tony@atomide.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Mon, 12 Jan 2009 18:15:20 +0200
Message-ID: <20090112161514.GP9373@atomide.com>
References: <20090112145051.GL9373@atomide.com> <B5CEECBB-9939-46B9-BEDB-D8D9879DB63E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54189 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbZALQPY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 11:15:24 -0500
Content-Disposition: inline
In-Reply-To: <B5CEECBB-9939-46B9-BEDB-D8D9879DB63E@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [090112 17:40]:
>
> Op 12 jan 2009, om 15:50 heeft Tony Lindgren het volgende geschreven:
>
>> Hi all,
>>
>> I've just tagged v2.6.28-omap1, and looks like we might want to also
>> do v2.6.28-omap2 as there are few annoying bugs remaining:
>>
>> - According to Jarkko Nikula, ASoC does not currently work because of
>>  some recent clock changes.
>
> Confirmed on omap3evm.

Thanks, can you try to git-bisect the breaking commit?

>> - MMC seems to be broken for omap1, Ladislav Michl  might have a patch
>>  coming up for that.
>>
>> - I2C is broken for 2430 according to Kainan Cha.

And also musb might require some patches, pending comments from Felipe.

>> Also looks like source.mvista.com is down, so please use the  
>> kernel.org
>> tree.
>>
>> Regards,
>>
>> Tony


