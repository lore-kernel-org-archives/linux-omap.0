From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Tue, 09 Mar 2010 11:04:47 -0800
Message-ID: <878wa1pb8w.fsf@deeprootsystems.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
	<87eijuvhph.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321DCB0AC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33831 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0CITEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 14:04:49 -0500
Received: by pvb32 with SMTP id 32so1899939pvb.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 11:04:49 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB0AC@dbde02.ent.ti.com> (Thara Gopinath's message of "Tue\, 9 Mar 2010 14\:29\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Monday, March 08, 2010 11:06 PM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Sripathy, Vishwanath; Sawant, Anand;
>>>Cousson, Benoit
>>>Subject: Re: [PATCH 0/3] OMAP3: PM: OMAP3630 support for smartreflex driver
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch series adds support for the updated 45nm smrtrelfex IP
>>>> supported in OMAP3630 and OMAP4 in the smartreflex driver and
>>>> adds support to enable smartreflex autocompensation for OMAP3630
>>>> using test nvalues.
>>>>
>>>> This patch series is based on the following patch series/patches
>>>> for proper functionality.
>>>> 	http://marc.info/?l=linux-omap&m=126700378625593&w=2
>>>> 	http://patchwork.kernel.org/patch/77739/
>>>>
>>>> This patch series has been tested on OMAP3630 SDP board with
>>>> CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.
>>>>
>>>> This patch series has been based on Kevin's PM tree
>>>> origin/pm-wip-opp branch
>>>
>>>It appears to also depend on the previous SR rework series.  It
>>>doesn't apply directly to pm-wip-opp.
>
> Hi Kevin,
>
> The patch/series dependency mentions the previous SR rework patch series in the above line.
>

No, it only mentions the PM branch + pm-wip-opp branch.  I saw mention
of the previous SR rework series in description.

>>>
>>>> and on adea81232e8fc82334bca3707efa23dc854f29fc commit id.
>>>
>>>This commit is a rather old version of pm-wip-opp, please refresh
>>>against current.
>
> I will do this. I will send out a V2 for both this series and the earlier smartreflex rework series.
>

Thanks,

Kevin

