From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] OMAP3: PM: Ensure MUSB is accessible before we attempt to reset it
Date: Thu, 13 Aug 2009 15:52:13 -0700
Message-ID: <87d46zcoo2.fsf@deeprootsystems.com>
References: <1250196401-24433-1-git-send-email-jon-hunter@ti.com>
	<87prazcq5g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:54459 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZHMWwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 18:52:14 -0400
Received: by pzk34 with SMTP id 34so766005pzk.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 15:52:15 -0700 (PDT)
In-Reply-To: <87prazcq5g.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 13 Aug 2009 15\:20\:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Jon Hunter <jon-hunter@ti.com> writes:
>
>> This is version 2 of this patch. I have incorporated the changes 
>> recommended by Kevin Hilman.
>>
[...]

>
> Thanks, pushing to PM branch and pm-2.6.29.
>

Just FYI in case you cant find this patch in the PM branch.  While
rebasing the PM branch, I grouped this patch along with hwmod and the
MMC reset removal so you wont set it on the tip of the PM branch.

Kevin
