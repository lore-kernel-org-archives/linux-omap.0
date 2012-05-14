From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Mon, 14 May 2012 10:20:53 +0530
Message-ID: <CAJ7qFSdLXq9dxFT65X1uSqEbqnnHXMewb+h=4mD-M1VNt1STcw@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
	<20120511201113.GA21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:40011 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363Ab2ENEu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 00:50:56 -0400
Received: by lagw12 with SMTP id w12so3645730lag.24
        for <linux-omap@vger.kernel.org>; Sun, 13 May 2012 21:50:53 -0700 (PDT)
In-Reply-To: <20120511201113.GA21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Tony,
  Thanks for you suggestions

>> =A0OMAP5 V2 series is ready with all comments addressed, but I have
>> =A0below dependencies to be merged to apply my series against your
>> =A0cleanup-soc branch
>
> OK
>
>> =A01) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.=
5
>
> This one is not merged in yet and it seems that we're out of time
> for v3.5 unless it drags on and we have -rc8 after -rc7.
>
 OK
>> =A02) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
>> =A03) https://github.com/hvaibhav/am335x-linux =A0 32ksync-timer-cle=
anup
>
> These two are merged in arm-soc now.
>
 OK
>> =A04) http://www.spinics.net/lists/arm-kernel/msg174461.html
>
> I think this series still has some pending comments?
>
 Yes, right. In fact except for the last patch,
 others should not be needed when rebased against
 paul's PRCM cleanups which is yet to be posted and
 [1] which is already acked now.

  1) http://www.spinics.net/lists/linux-omap/msg70192.html

>> =A0Can you please let me know how you want me to prepare the series
>> =A0with these dependencies.
>
> Until these dependencies get cleared out, it seems that the best
> branch to base your patches is omap-cleanup-timer-for-v3.5 tag
> and just carry the pending patches for a little bit longer.
>
 Ok, will rebase against it then and then prepare the series with a cou=
ple
of temporary patches that can be dropped when the above mentioned depen=
dencies
are sorted out.


Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
