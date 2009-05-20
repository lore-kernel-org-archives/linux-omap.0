From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] PM: drop clocks_off_while_idle
Date: Wed, 20 May 2009 09:12:04 -0700
Message-ID: <87hbzfrbxn.fsf@deeprootsystems.com>
References: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:37999 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZETQMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 12:12:05 -0400
Received: by wf-out-1314.google.com with SMTP id 26so178199wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 09:12:07 -0700 (PDT)
In-Reply-To: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Tue\, 19 May 2009 10\:14\:22 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> The sysfs control /sys/power/clocks_off_while_idle only affects
> the UART clocks.  And these can now be controlled with a UART
> specific timeout sysfs control.  The system default behavior
> is to have the equivalent of clocks_off_while_idle == 1 and
> a UART inactivity timeout of 5 seconds.
>
> Now one can use
>
>   /sys/devices/platform/serial8250.<uart>/sleep_timeout
>
> to set the inactivity timer for the UART in seconds.  Setting
> this value to zero disables the timout and is the equivalent
> of doing an
>
>   echo 0 > /sys/power/clocks_off_while_idle
>
>

Pushing this series to the PM branch.

Kevin
