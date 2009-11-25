From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/9] dspbridge cleanup patches
Date: Wed, 25 Nov 2009 15:56:55 -0600
Message-ID: <4B0DA827.4090900@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>	 <1259045675.18407.53.camel@localhost> <94a0d4530911250932h76dd73d1mbbde9c568aa3488f@mail.gmail.com> <27F9C60D11D683428E133F85D2BB4A530426F267DB@dlee03.ent.ti.com> <4B0D99F2.5020006@ti.com> <27F9C60D11D683428E133F85D2BB4A530426F26833@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59792 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935124AbZKYV4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 16:56:53 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530426F26833@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ramirez Luna, Omar had written, on 11/25/2009 03:52 PM, the following:
>> From: Menon, Nishanth
>> Subject: Re: [PATCH 0/9] dspbridge cleanup patches
>>
>>> 1. http://dev.omapzoom.org/?p=tidspbridge/kernel-
>> dspbridge.git;a=commit;h=b6b7bc5b620596790b2ea26225908b3cf62c36be
>>
>> How about the discussion in
>> http://marc.info/?l=linux-omap&m=123728293826758&w=2 ?
>> same arguments seem valid now..
>>
> 
> Opps, sorry about that, seems like I stole/redid your patch Felipe, I'll diff it (to see nothing is missing), fix author and add my signed off.
> 
> Nishant,
> 
> I actually removed the history because one of your comments:
> [snip]
>>> + * GPIO Module disable when not in use - Charulatha V 
>>> + <charu@ti.com>
>> Please stop adding history here.. git commit is supposed to contain 
>> it. No stats are generated from looking at file history anymore and 
>> there is definitely the risk of getting as big as
>> http://dev.omapzoom.org/?p=tidspbridge/kernel-
>> dspbridge.git;a=blob;f=drivers/dsp/bridge/rmgr/mgr.c;h=943cf932a35b75f
>> 709f
>> 554deb3c51c47088d8b78;hb=refs/heads/dspbridge#l26
> [snip]

lets not mix things up. GPIO does not come with the legacy burden of 10 
years that DSPBridge has.
http://marc.info/?l=linux-omap&m=123729745613662&w=2 summarizes my views 
on DSPBridge.

> 
> Personally, If any folk mentioned on the removed history disagrees, it is welcome to send a
 > mail to this mailing list detailing his contributions and I guess 
someone (me, most likely)
 >will check on it. For now a line thanking "vp", "rr", "sp" etc. for 
their initial work will be added to the patch.
I doubt if many folks even are there on the linux-omap mailing list.. 
might be good for us to check OR at least note:
Anonymous contributors (vp,vr etc..).. I think this was previously 
discussed in the chain.


> 
>>> 3. http://dev.omapzoom.org/?p=tidspbridge/kernel-
>> dspbridge.git;a=commit;h=b4d73d15bd2b1c7dd1cc89ca9e81a98946ddf241
>> printk(KERN_ERR ?? why not use the pr_err/warning/info family?
>>
> 
> My git:
>  drivers/dsp/bridge/rmgr/dbdcd.c         |  165 +++-----
>  drivers/dsp/bridge/rmgr/disp.c          |  254 ++++-------
>  drivers/dsp/bridge/rmgr/drv.c           |  399 +++++++----------
>  drivers/dsp/bridge/rmgr/drv_interface.c |   92 ++---
>  drivers/dsp/bridge/rmgr/dspdrv.c        |   34 +-
>  drivers/dsp/bridge/rmgr/proc.c          |  754 ++++++++++++++-----------------
>  drivers/dsp/bridge/rmgr/rmm.c           |   46 +--
>  drivers/dsp/bridge/rmgr/strm.c          |  144 +++----
>  8 files changed, 791 insertions(+), 1097 deletions(-)
> 
> (now): Removing GT_Trace wrappers and replacing for pr_debug
Throughout please.. no more printks.. thanks..


-- 
Regards,
Nishanth Menon
