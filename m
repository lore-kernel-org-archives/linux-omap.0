From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
Date: Wed, 12 Aug 2009 07:58:03 -0700
Message-ID: <87my65yt8k.fsf@deeprootsystems.com>
References: <87fxcqq44h.fsf@deeprootsystems.com>
	<00f101ca1b5a$6e519f50$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:56339 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZHLO6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:58:04 -0400
Received: by pzk34 with SMTP id 34so44371pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 07:58:06 -0700 (PDT)
In-Reply-To: <00f101ca1b5a$6e519f50$LocalHost@wipultra793> (Hemanth V.'s message of "Wed\, 12 Aug 2009 20\:07\:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
>> Known problems:
>
>> - network drivers and off-mode
>>  - various hangs when using off-while-idle and NFS-mounted rootfs
>>  - network drivers likely need some context save/restore support
>
> Kevin, was this known to work earlier. Could this be related to
> GPMC context save/restore.

I wrote this based on some early testing of the latest PM branch,
where I may of still had some bugs.  But I also have not seen
this in a while, so it may have been just a problem when I was
reworking/reordering the context save/restore code.

I decided to leave it in the 'known problems' list in case anyone else
has seen it and because I didn't go back and re-test all the boards
for this issue.

I don't see any issues on SDP or EVM anymore, have you tested the
current PM branch for this?

Kevin
