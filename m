From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Mon, 26 Sep 2011 15:59:41 -0700
Message-ID: <87mxdq9ag2.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	<87mxdrcfnf.fsf@ti.com>
	<CAC83ZvLcq+N_LL4AD=r4hZxPeQtrAEvR7MzoANtNmQBNR7AqGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48319 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711Ab1IZW7t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 18:59:49 -0400
Received: by mail-yi0-f49.google.com with SMTP id 24so5722950yic.36
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 15:59:45 -0700 (PDT)
In-Reply-To: <CAC83ZvLcq+N_LL4AD=r4hZxPeQtrAEvR7MzoANtNmQBNR7AqGw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 27 Sep 2011 03:40:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>>> - Added the debounce clock fix in the end.
>>
>> Thanks. =C2=A0Glad you found and fixed it.
>>
>> Rather than add this patch as a fix at the end, I prefer if the prob=
lem
>> is fixed in the original patches that added/created the problem.
> Sure. I will put the changes in respective patches.

Also, when you rebase, please be sure to add the Acked-by from Tony
to the various patches he ack'd.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
