From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/9] dspbridge cleanup patches
Date: Wed, 25 Nov 2009 14:56:18 -0600
Message-ID: <4B0D99F2.5020006@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>	 <1259045675.18407.53.camel@localhost> <94a0d4530911250932h76dd73d1mbbde9c568aa3488f@mail.gmail.com> <27F9C60D11D683428E133F85D2BB4A530426F267DB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935046AbZKYU4O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 15:56:14 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530426F267DB@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ramirez Luna, Omar had written, on 11/25/2009 02:49 PM, the following:
>> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>> Subject: Re: [PATCH 0/9] dspbridge cleanup patches
>>
>> On Tue, Nov 24, 2009 at 8:54 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>> On Mon, 2009-11-23 at 18:50 -0600, Omar Ramirez Luna wrote:
>>>>   DSPBRIDGE: trivial file history cleanup
>> It seems this patch (1/9) didn't reach linux-omap. But looks like it
>> was about time for it :)
>>
> 
> Yes, it seems patch 1 and 3 were too big, I have them on dspbridge-next (while waiting for comments)
> 
> 1. http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=b6b7bc5b620596790b2ea26225908b3cf62c36be

How about the discussion in 
http://marc.info/?l=linux-omap&m=123728293826758&w=2 ?
same arguments seem valid now..

> 
> 3. http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=b4d73d15bd2b1c7dd1cc89ca9e81a98946ddf241
printk(KERN_ERR ?? why not use the pr_err/warning/info family?

> 
> - omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon
