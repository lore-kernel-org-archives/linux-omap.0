From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Tue, 27 Sep 2011 03:40:53 +0530
Message-ID: <CAC83ZvLcq+N_LL4AD=r4hZxPeQtrAEvR7MzoANtNmQBNR7AqGw@mail.gmail.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	<87mxdrcfnf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34493 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774Ab1IZWKz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 18:10:55 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so7945367bkb.40
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 15:10:54 -0700 (PDT)
In-Reply-To: <87mxdrcfnf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

[...]
>> - Added the debounce clock fix in the end.
>
> Thanks. =A0Glad you found and fixed it.
>
> Rather than add this patch as a fix at the end, I prefer if the probl=
em
> is fixed in the original patches that added/created the problem.
Sure. I will put the changes in respective patches.
--
Tarun
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
