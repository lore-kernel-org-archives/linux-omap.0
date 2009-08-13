From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
Date: Thu, 13 Aug 2009 06:03:51 -0700
Message-ID: <873a7voog8.fsf@deeprootsystems.com>
References: <87fxcqq44h.fsf@deeprootsystems.com>
	<00f101ca1b5a$6e519f50$LocalHost@wipultra793>
	<87my65yt8k.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0306050777@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:19999 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZHMNDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 09:03:53 -0400
Received: by wf-out-1314.google.com with SMTP id 26so244876wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 06:03:54 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050777@dbde02.ent.ti.com> (Teerth Reddy's message of "Thu\, 13 Aug 2009 11\:30\:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> I did some testing with the current PM branch and don't see this issue on SDP. 

Thanks for testing.

> I could not find the patch which fixes this issue. Can you please
> point us to the patch which fixes this issue?

To be honest, I actually don't know which patch fixed the issue.  I saw the
problem during some early testing of the latest PM branch, and in the process
of restructuring the tree it went away.

More than likely, I had left out part of the series when reorganizing
that caused this temporary problem.

I think I'll remove it from the 'known problems' list as it appears to
have been operator error on my part.

Kevin


>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, August 12, 2009 8:28 PM
> To: V, Hemanth
> Cc: linux-omap@vger.kernel.org
> Subject: Re: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
>
> "Hemanth V" <hemanthv@ti.com> writes:
>
>> ----- Original Message ----- 
>> From: "Kevin Hilman" <khilman@deeprootsystems.com>
>>> Known problems:
>>
>>> - network drivers and off-mode
>>>  - various hangs when using off-while-idle and NFS-mounted rootfs
>>>  - network drivers likely need some context save/restore support
>>
>> Kevin, was this known to work earlier. Could this be related to
>> GPMC context save/restore.
>
> I wrote this based on some early testing of the latest PM branch,
> where I may of still had some bugs.  But I also have not seen
> this in a while, so it may have been just a problem when I was
> reworking/reordering the context save/restore code.
>
> I decided to leave it in the 'known problems' list in case anyone else
> has seen it and because I didn't go back and re-test all the boards
> for this issue.
>
> I don't see any issues on SDP or EVM anymore, have you tested the
> current PM branch for this?
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
