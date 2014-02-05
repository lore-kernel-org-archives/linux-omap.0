From: Grant <emailgrant@gmail.com>
Subject: Re: omapfb segfaults
Date: Wed, 5 Feb 2014 05:46:53 -0800
Message-ID: <CAN0CFw29qM14Q-1HNyKhA23bLC8Kd+7ZeJCptVdDGXssfbLY=Q@mail.gmail.com>
References: <CAN0CFw0hJ3=5g9NtZqK6DoGYCqyTrB+P47_TWLr03n9yh=jVoQ@mail.gmail.com>
	<CAN0CFw2CZDxN_UxEYnye-bwAzL=nsr8w_Kz4cGHOaQjvpJ61nw@mail.gmail.com>
	<20140204165344.GB755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:38342 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaBENqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 08:46:54 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so589414qcx.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Feb 2014 05:46:54 -0800 (PST)
In-Reply-To: <20140204165344.GB755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

>> > omapfb segfaults on my Pandaboard ES across several different kernel
>> > versions including 3.13.1.  I've tried everything I can think of.  Any
>> > ideas?
>> >
>> > - Grant
>>
>> This was fixed with the patches here:
>>
>> https://github.com/archlinuxarm/PKGBUILDs/tree/master/alarm/xf86-video-omapfb
>
> OK good to hear.
>
> Tony

Do you know if omapfb should be able to scale video?

- Grant
