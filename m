From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during Smartreflex disable.
Date: Wed, 05 May 2010 14:39:43 -0700
Message-ID: <874oim3u5c.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
	<1271408597-3066-16-git-send-email-thara@ti.com>
	<1271408597-3066-17-git-send-email-thara@ti.com>
	<1271408597-3066-18-git-send-email-thara@ti.com>
	<1271408597-3066-19-git-send-email-thara@ti.com>
	<87vdbchfmn.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322BA9749@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46289 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab0EEVj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:39:57 -0400
Received: by pva18 with SMTP id 18so733769pva.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 14:39:51 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322BA9749@dbde02.ent.ti.com> (Thara Gopinath's message of "Wed\, 5 May 2010 16\:33\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Wednesday, April 28, 2010 12:45 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>>Subject: Re: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during Smartreflex disable.
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> Currently whenever smartreflex is disabled the voltage for the
>>>> particular VDD is reset to the non-smartreflex compensated level.
>>>> This step is unnecessary during dvfs because anyways in the next couple
>>>> of steps before re-enabling smartreflex , the voltage level is changed.
>>>>
>>>> This patch adds the flexibility in the smartreflex framework for the user
>>>> to specify whether or not a voltage reset is required after disabling
>>>> of smartrefelx. The smartreflex driver just passes on this info
>>>> to the smartreflex class driver, which ultimately takes the
>>>> decision to reset the voltage or not.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>I don't think this option should be a decision made for each call to
>>>omap_smartreflex_[en|dis]able().  Rather it should be an init time
>>>option.
>
> Why do you say this? Anytime we do a disable of smartreflex auto
>compensation from user space we need a reset of the voltage is
>required.  During dvfs during smartreflex disable a reset of the
>voltage is not required.  And in both these scenarios it is the same
>class API that gets called. So the only way for the API to know
>whether to reset the voltage or not is through this parameter. Also
>IMHO keeping it parameter based allows more flexibility in the
>framework for voltage reset.

OK,  I see now.

I was looking at this patch in isolation and didn't notice the usage
of it in the next DVFS patch where the ->disable is done without
reset.

Also, since this new flag is a bool, change it from int to bool.

Or better yet add a new function.  One thing I'm not a fan of for
readability sake is the use of bool flags.  It makes me have to go
look at the function to see what the flag is used for.  I'd rather
just see a new function added.  Something like
omap_smartreflex_disable_noreset() would make the code a bit more
readable.

Thanks,

Kevin



