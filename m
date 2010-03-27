From: Maulik Mankad <mankad.maulik@gmail.com>
Subject: Re: Problems with workqueue
Date: Sat, 27 Mar 2010 22:47:11 +0530
Message-ID: <cc627b81003271017l14a95365m1b253140a0e8b2b2@mail.gmail.com>
References: <cc627b81003260410i24b7c42ak6e234c91b7755d06@mail.gmail.com>
	 <447756.96477.qm@web51701.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54612 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab0C0RRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Mar 2010 13:17:14 -0400
Received: by bwz1 with SMTP id 1so2563610bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 10:17:12 -0700 (PDT)
In-Reply-To: <447756.96477.qm@web51701.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nagendra <nags75@yahoo.com>
Cc: linux-omap@vger.kernel.org

> Thanks for the response.
> Are you saying that instead of using the default thread (events/0) for scheduling the work, I should be using the dedicated thread for scheduling the work?

Yes that's what i meant.

>We did this experiment and it worked fine. However, I want to get to the root cause and that would require some utility to display (or examine) >the status of the work present on the queue.

What happens when you use the default thread for scheduling the work?
Does the system freeze when the issue occurs? You need to look at the
various tasks / threads running on the system and what is their status
when the issue occurs.

You can use SYSREQ Magic key to see what tasks are running. Also
enable some of the debugging features under Kernel hacking like lock
debugging etc. This will give some more pointers.

>
> Do you have any suggestion on that?
> How about changing the work queue to a Kernel Thread. Are there any potential issues with this? We did this - changed the work queue to >Kernel Thread the system is behaving as expected how. However, I am not sure if having too many threads is a good idea in the system and >hence contemplating the idea.

How many new threads are you creating? If its only one I dont see a
problem. But if the root cause is known a most appropriate solution
can be thought.

Thanks,
Maulik
