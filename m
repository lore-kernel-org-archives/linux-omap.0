From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Fri, 21 Jan 2011 13:00:16 +0530
Message-ID: <AANLkTik4yY8ZYyQ3J1JB2EokM=i_bnkbrPZWinGVd9Lh@mail.gmail.com>
References: <1295532731-5438-1-git-send-email-weber@corscience.de>
 <AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com>
 <20110120181952.GY4957@atomide.com> <AANLkTikkApJAa_mnwr9tKT2e2OUnERHoEifbdj8+CcEe@mail.gmail.com>
 <20110121092842.bd17f93b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55872 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207Ab1AUHa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 02:30:58 -0500
Received: by gxk9 with SMTP id 9so445356gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 23:30:57 -0800 (PST)
In-Reply-To: <20110121092842.bd17f93b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Poddar, Sourav" <sourav.poddar@ti.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

On Fri, Jan 21, 2011 at 12:58, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Fri, 21 Jan 2011 11:55:55 +0530
> "Varadarajan, Charulatha" <charu@ti.com> wrote:
>
>> >> I was just about to post a patch for this, but you beat me
>> >> to it!
>> >>
>> >> > Signed-off-by: Thomas Weber <weber@corscience.de>
>> >>
>> >> Acked-by: Sourav Poddar <sourav.poddar@ti.com>
>> >
>> > Thanks, merging this into the original. Also adding
>> > applying into linux-omap master.
>> >
>>
>> Aren't we breaking multi-omap build with this?
>>
> Don't point it out immediately but these patches looks like yet another
> reason why there's a need to get rid of these ifdefs and cpu_is_omapxxx
> tests from the drivers.

Yes. I agree.

>
> --
> Jarkko
>
