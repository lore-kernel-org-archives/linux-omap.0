From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/13] OMAP: Implement Basic DVFS
Date: Wed, 09 Feb 2011 07:59:32 -0800
Message-ID: <87sjvxdwrf.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-4-git-send-email-vishwanath.bs@ti.com>
	<87mxmcy51u.fsf@ti.com>
	<da15cb476bc1779775448cc5dcd372f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44562 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419Ab1BIP7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:59:40 -0500
Received: by mail-iy0-f176.google.com with SMTP id 26so310157iyb.35
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 07:59:36 -0800 (PST)
In-Reply-To: <da15cb476bc1779775448cc5dcd372f3@mail.gmail.com> (Vishwanath
	Sripathy's message of "Mon, 7 Feb 2011 19:48:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

>> This needs a comment to, but I'm not sure I understand what's going on
>> here.  What it seems like:
>>
>> if this device has no OPP for this voltage, just silently move on to the
>> next device?   doesn't seem quite right, but not sure I fully grok the
>> failure modes of omap_dvfs_find_voltage()
>
> Yes, your understanding is right. omap_dvfs_find_voltage will return error
> if the device does not have an OPP table.
> Typically devices should not register with a vdd (using
> omap_dvfs_register_device) if it has no OPP table associated with it. So
> ideally we should not hit this error case. But only exception so far is SR
> driver. SR hwmod has vdd_name field set so as to get voltagedomain
> pointers. But SR does not have any opp table. So there is no harm in
> ignoring the error and moving to next device.

And what happens when other devices add voltage domains but don't have
OPP tables?

The point is that this error handling is 1) difficult to understand upon
first (or fifth) read and 2) very fragile with other changes.

Kevin
