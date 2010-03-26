From: Maulik Mankad <mankad.maulik@gmail.com>
Subject: Re: Problems with workqueue
Date: Fri, 26 Mar 2010 16:40:26 +0530
Message-ID: <cc627b81003260410i24b7c42ak6e234c91b7755d06@mail.gmail.com>
References: <loom.20100325T122311-43@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:37771 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0CZLK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 07:10:28 -0400
Received: by bwz1 with SMTP id 1so1688538bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 04:10:27 -0700 (PDT)
In-Reply-To: <loom.20100325T122311-43@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NS <nags75@yahoo.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 25, 2010 at 4:54 PM, NS <nags75@yahoo.com> wrote:
> Hi All,
>
> I am facing a problem with Work Queues and need some help debugging. We are
> using 2.6.22 Kernel. I know that it is old kernel version, but this kernel
> version was chosen for the product almost a year back and we are not in a
> position to change the kernel version due to time constraints.
>
> Problem description
> We use work queues for the second half of the ISR with a touch screen driver.
> Most of the times, everything works fine. However, occasionally, the work does
> not seem to get a chance to execute.

Are you using the default work queue or a dedeicated work queue for your
touch screen driver?

If you are using the default work queue you can try using a dedicated work
queue in your touch screen driver and see if this resolves the issue.

Then debug further to find a root cause.

Regards,
Maulik
