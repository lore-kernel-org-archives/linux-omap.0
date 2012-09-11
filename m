From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT* read/write
Date: Tue, 11 Sep 2012 11:49:44 +0530
Message-ID: <CAMQu2gxUES=s8fMpwJ77tnY1wz4b_T=yustj+C+WNkEMmEOx4w@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com> <20120910185535.GC1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58903 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755355Ab2IKGUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 02:20:06 -0400
Received: by ghbg21 with SMTP id g21so204978ghb.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 23:20:04 -0700 (PDT)
In-Reply-To: <20120910185535.GC1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Tue, Sep 11, 2012 at 12:25 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
>>
>> Will you able to pick up these couple of wakeupgen fixes from  here or
>> do you want me to send you a pull request for 3.6-rc5/6
>
> I can pick them into fixes-noncritical. But if the second one is
> a major bug for the -rc series, the patch should be describe what
> breaks (regression? oops?).
>
Fixes non critical is fine. No major issue without these patches.

Regards
Santosh
