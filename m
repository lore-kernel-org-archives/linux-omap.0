From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] debugfs entries for PM counters
Date: Wed, 29 Oct 2008 11:22:52 -0700
Message-ID: <4908A9FC.4090001@deeprootsystems.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.154]:35797 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYJ2SWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 14:22:55 -0400
Received: by po-out-1718.google.com with SMTP id y22so5388975pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:22:54 -0700 (PDT)
In-Reply-To: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Peter 'p2' De Schrijver wrote:
> This patchset adds 2 debugfs entries for power management counters.
> pm_debug/count indicates how many times each powerdomain entered each state
> (On, Inactive, Retention, Off).
> pm_debug/time indicates how much time each powerdomain spent per state.
> 
> Peter 'p2' De Schrijver (3):
>   Add closures to clkdm_for_each.
>   Add pm-debug counters
>   Hook into powerdomain code
> 

Thanks, pulling this series into next PM branch.

Kevin
