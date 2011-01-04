From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] omap: boards w/ wl12xx should select REGULATOR_FIXED_VOLTAGE
Date: Tue, 4 Jan 2011 21:21:51 +0200
Message-ID: <AANLkTimUd4VGycPi2y6QjrWHAVVfuMit1H20VWZ2nKJr@mail.gmail.com>
References: <1290593090-6288-1-git-send-email-ohad@wizery.com>
 <AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com> <20110104191732.GI7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:37929 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1ADTWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 14:22:12 -0500
Received: by iyf40 with SMTP id 40so6782123iyf.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 11:22:12 -0800 (PST)
In-Reply-To: <20110104191732.GI7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 4, 2011 at 9:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ohad Ben-Cohen <ohad@wizery.com> [110104 10:04]:
>> On Wed, Nov 24, 2010 at 12:04 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> > Power to the wl12xx wlan device is controlled by a fixed regulator.
>> >
>> > Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
>> > users will not be baffled.
>> >
>> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> > ---
>>
>> Hi Tony,
>>
>> Gentle reminder,
>
> This is queued for 2.6.38 in omap-for-linus as commit
> 7c50152f0851e44ef7491546a29fddbbea47735b?

Thanks!

>
> Tony
>
