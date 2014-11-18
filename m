From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Fail to enter retention
Date: Tue, 18 Nov 2014 23:47:14 +0200
Message-ID: <CAJ2oMhKaMxJmPy2oN65b-rg=8xnHMT3gmp8F=x63B+NfV-BQCg@mail.gmail.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
	<20141117162209.GE7046@atomide.com>
	<CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
	<20141117180944.GG7046@atomide.com>
	<CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
	<20141117203808.GH7046@atomide.com>
	<CAJ2oMhJxnRjb8NUz+JyYLJYiRBA+vSA3C2q7viEZf0sVXqFtqw@mail.gmail.com>
	<CAJ2oMhKPb-Hde--2WfQT=9U5r8XQUKo2UHHvsJ8D841zpMqLRA@mail.gmail.com>
	<CAJ2oMhJLo04q3Y48Q_f4VX=ew+tMJbBmY7toAODTsqbKRReHLw@mail.gmail.com>
	<20141118154543.GJ7046@atomide.com>
	<CAJ2oMhJUNsKtP1VYF+6dWDfmAEF3qvfbN7ahhVBdDBgZt7thGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61945 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaKRVrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 16:47:15 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so14235200wiw.16
        for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2014 13:47:14 -0800 (PST)
In-Reply-To: <CAJ2oMhJUNsKtP1VYF+6dWDfmAEF3qvfbN7ahhVBdDBgZt7thGA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

 I eventually managed to enter retention :))

I did the following changes:
 1. added CONFIG_SUSPEND (though I do not use suspend/resume but only
 cpuidle, it seems to have some effect, I think without it the wakeup in
 console did not function correctly.
 2. enabled sleep for all uart not just the console uart (as I did at first)
 3. uart rx was configured as wakeup source

 Than I can see that cpu0/state4/time is incremented. As I understand state4
 is retention in OMAP3530.

 The only bit strange thing is that I still see picture in screen. I wander
 how omap can enter retention can be while screen is on.

 Thanks very much for your assistance,
 Ran
