From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 14:54:29 -0600
Message-ID: <4CE6E405.9020309@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-9-git-send-email-nm@ti.com>	<87eiahckba.fsf@deeprootsystems.com>	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>	<4CE6B2D4.1030201@ti.com>	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>	<4CE6C714.50209@ti.com> <877hg96oa5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52542 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755696Ab0KSUyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 15:54:33 -0500
Received: by mail-vw0-f54.google.com with SMTP id 16so98712vws.13
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 12:54:32 -0800 (PST)
In-Reply-To: <877hg96oa5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 11/19/2010 02:39 PM, the following:
[...]
> In addtion, the patch from Santosh needs to better describe what other
> problems it is solving, since it is clearly not fixing this particular
> secure mode entry.  Therefore, there must be others that are also doing
> WFI.   That being said, instead of such a generic fix as is done by
> Santosh's patch, maybe we need a common secure-mode entry point which
> does the necessary ROM code prep.
Ideally speaking - save_secure_ram can hit latencies which are pretty 
bad.. eventually this logic should be moved outside the current 
boundaries in some manner - unfortunately, I cant at the moment think of 
a sane mechanism to do that given various proprietary and 
not-mainlined-but-public security drivers for OMAP3 out there :(. IMHO, 
the responsibility of secure storage should be with secure drivers, but, 
at the moment touching that topic is opening up a pandora's box :(

> 
>> This specific patch controls the clock domain from auto idling around
>> the secure ram save. Apologies on the confusion - but if the [1] patch
>> is fixing it, you can help me understand how it does it.
> 
> Now that I understand the clockdomain part, I'm seeing the problem
> differently.  (side note: A better written changelog could have avoided
> this confusion by being clear that it was *clockdomain* idle that was
> being added here and that it was in addition to the existing powerdomain
> settings.)
> 
> Technically, $SUBJECT patch could have replaced the set_next_pwrst with
> the clkdm_deny_idle.  IOW, setting the pwrdm next state to is redundant
> if you clkdm_deny_idle.
> 
> I think this is the key to the confusion:
> 
> 1) clkdm_deny_idle() implies the powerdomain stays on
> 2) setting powerdomain to on, does NOT imply clkdm_deny_idle()
> 
> Another way of saying it is that setting a powerdomain to on does not
> prevent it from going inactive.  It only prevents retention or off-mode.
Agreed and I apologize for the confusion caused by the commit message - 
will it be sufficient for the purpose of this series to change the 
commit log to better describe the patch? - I will leave the power domain 
control to Santosh's /Tero's series instead.

Is this acceptable option?

[...]

-- 
Regards,
Nishanth Menon
