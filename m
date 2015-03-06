From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy mpurate
 command line param
Date: Fri, 6 Mar 2015 18:10:08 +0200
Message-ID: <54F9D160.7010708@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com> <1425644939-3232-12-git-send-email-t-kristo@ti.com> <20150306153254.GK13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41912 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbCFQKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 11:10:22 -0500
In-Reply-To: <20150306153254.GK13520@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On 03/06/2015 05:32 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [150306 04:29]:
>> The legacy support is wrong and dangerous, as it doesn't take any
>> OPPs into account and does not scale voltages. Switching mpurate should
>> be handled through cpufreq.
>
> Hmm I wonder if some systems actually rely on the mpurate cmdline
> parameter. If this cannot be fixed properly, you should at least
> print an error here.

Yea, I was kind of worried about this comment. We have also an option of 
doing this through clock driver, but I was hesitant of doing this 
either. Isn't having a global kernel option like this frowned upon 
anyway? I believe this piece of init code gets executed on every board 
on multiarch kernel.

-Tero
