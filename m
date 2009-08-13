From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
Date: Thu, 13 Aug 2009 11:30:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050777@dbde02.ent.ti.com>
References: <87fxcqq44h.fsf@deeprootsystems.com>
	<00f101ca1b5a$6e519f50$LocalHost@wipultra793>
 <87my65yt8k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45663 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbZHMGBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 02:01:05 -0400
In-Reply-To: <87my65yt8k.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "V, Hemanth" <hemanthv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

I did some testing with the current PM branch and don't see this issue on SDP. 

I could not find the patch which fixes this issue. Can you please point us to the patch which fixes this issue?

Regards,
Teerth

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
Sent: Wednesday, August 12, 2009 8:28 PM
To: V, Hemanth
Cc: linux-omap@vger.kernel.org
Subject: Re: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

