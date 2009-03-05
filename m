From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] DSPBRIDGE: patches.
Date: Thu, 5 Mar 2009 15:42:08 +0200
Message-ID: <94a0d4530903050542r39af0220l1b7a4117089e37df@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB4@dlee06.ent.ti.com>
	 <269694c00903050226q5c9328b6t94545fc8897f0c8f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E22FE718B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:53825 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042AbZCENmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 08:42:11 -0500
Received: by fxm24 with SMTP id 24so3353468fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2009 05:42:08 -0800 (PST)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E22FE718B@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Ameya Palande <2ameya@gmail.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 5, 2009 at 3:18 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Ameya,
>
>> Hi Fernando,
>>
>> Are you using tidspbridge-pm branch from
>> http://gitorious.org/projects/lk/repos/mainline ?
>>
>> Cheers,
>> Ameya.
>
> -- The Bridge patches will be based on omapzoom tree.

We are in linux-omap, not omapzoom, and this is the tidspbridge branch
in linux-omap:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=tidspbridge

I'm sure you don't want to increase the discrepancy between linux-omap
and omapzoom, so the patches sent to l-o should apply on top of the
l-o tidspbridge in order to be merged.

-- 
Felipe Contreras
