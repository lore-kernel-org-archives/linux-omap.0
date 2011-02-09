From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce accessory APIs for DVFS
Date: Wed, 09 Feb 2011 07:35:04 -0800
Message-ID: <87zkq5dxw7.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-2-git-send-email-vishwanath.bs@ti.com>
	<87wrli2aes.fsf@ti.com>
	<3febc6b67a44427808992af8e95e3c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48328 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751937Ab1BIPfJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:35:09 -0500
Received: by gyc15 with SMTP id 15so123851gyc.41
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 07:35:08 -0800 (PST)
In-Reply-To: <3febc6b67a44427808992af8e95e3c9a@mail.gmail.com> (Vishwanath
	Sripathy's message of "Tue, 8 Feb 2011 16:52:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> > + * This is a fundamental structure used to store all the required
>> > + * DVFS related information for a vdd.
>> > + */
>> > +struct omap_vdd_dvfs_info {
>> > +	spinlock_t user_lock; /* spin lock */
>>
>> comment redundant
>>
>
> I added this because checkpatch was giving a warning saying mutex added
> w/o comments.
>

The point of the checkpatch warning is not to add just any comment.  The
point is to add a *useful* comment.

It is extremely helpful to readers of code with locking to know what the
locks are intended to protect.  The comment should indicate what the
lock is protecting and why.

Kevin
