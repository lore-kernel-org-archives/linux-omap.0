From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 12:55:53 -0800
Message-ID: <87y68p3uee.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-9-git-send-email-nm@ti.com>
	<87eiahckba.fsf@deeprootsystems.com>
	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
	<4CE6B2D4.1030201@ti.com>
	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
	<877hg9ayox.fsf@deeprootsystems.com> <4CE6DB9E.9000708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65297 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab0KSUz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 15:55:58 -0500
Received: by iwn7 with SMTP id 7so220473iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 12:55:57 -0800 (PST)
In-Reply-To: <4CE6DB9E.9000708@ti.com> (Nishanth Menon's message of "Fri, 19
	Nov 2010 14:18:38 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 11/19/2010 01:41 PM, the following:
>
>>>> I believe the fix we are attempting here is for a specific scenario
>>>> which IMHO is different from the issue solved in the link above.
>>> It will also solve the above issue indirectly.
>>
>> Yes, it indirectly fixes the issue solved by $SUBJECT patch, but what
>> else does it fix?
> Please see [1] - highlights:
> a) I dont seem to understand how clock domain idle is being denied by
> the patch
> b) the mentioned patch[1] should have removed the pwr_domain control
> around the secure ram operation - which is the only weakness in that
> patch, for power domain control, I like the mentioned patch - but
> pwrdomain control is not what is being introduced here.
>
>>
>> This secure mode call is currently the only one I'm aware of that does a
>> WFI.  If there are others, then $SUBJECT patch is not enough. 
>>
>> If TI cannot tell us definitively if other secure-mode calls may use
>> WFI, then we have to assume there are others, and $SUBJECT patch has to
>> be NAK'd in favor of a more generic fix like the one from Santosh.
>
> Thanks on the unfair beating IMHO,

Sorry if that sounded like a beating. 

Maybe this as a gentler way of saying the same thing: if information
about which SMIs are using WFI cannot be made public, we have no choice
but to protect them all.

Now, based on what you say below, it seems like there is no way to
guarantee that SMIs don't do this, so I guess we have no choice but to
protect them all.

Kevin

> but, I believe I confirmed this
> here[2] - Quote: "After a long review, the impacted section is this
> logic alone." if you do have other specific SMIs in doubt(the ones we
> have verified to my knowledge are the ones around sleep34xx code),
> please list them out and I can get confirmation on behalf of TI if WFI
> is in use or not. 
>
> AFAIK, SMIs can be supported by ROMcode and by
> PPA. is WFI is being used by PPA - there is no guarantee on the custom
> implementations.
> For example:
> CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE -> has a service ID which
> could be implemented by PPA -> TI cannot guarentee that
> implementations will never use WFI, from a kernel context, we'd say -
> dont use wfi - let the kernel control it, though the actual
> implementation is upto the developer of PPA.
>
> Ref:
> [1]http://marc.info/?l=linux-omap&m=129019267128364&w=2
> [2] http://marc.info/?l=linux-omap&m=129018700620594&w=2
