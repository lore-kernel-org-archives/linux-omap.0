From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: mcbsp: Fix possible memory corruption
Date: Mon, 12 Dec 2011 13:57:07 +0200
Message-ID: <4EE5EC13.40901@compulab.co.il>
References: <1323678976-4119-1-git-send-email-jarkko.nikula@bitmer.com> <1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com> <4EE5D639.8080608@compulab.co.il> <4EE5E3F4.6060701@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:39684
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752379Ab1LLL5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 06:57:21 -0500
In-Reply-To: <4EE5E3F4.6060701@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, neilb@suse.de

On 12/12/11 13:22, Jarkko Nikula wrote:
> Hi
> 
> On 12/12/2011 12:23 PM, Igor Grinberg wrote:
>> On 12/12/11 10:38, Jarkko Nikula wrote:
>>> Commits 09d28d ("ARM: OMAP: mcbsp: Start generalize omap2_mcbsp_set_clks_src")
>>> and 7bc0c4 ("ARM: OMAP: mcbsp: Start generalize signal muxing functions")
>>> incorrectly set two struct omap_mcbsp_platform_data fields after
>>> omap_device_build_ss and kfree calls.
>>>
>>> Fix this by moving these pdata assignments before those calls.
>>>
>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>>> Reported-by: neilb@suse.de
>> Perhaps, should be:
>> Reported-by: NeilBrown <neilb@suse.de>
>> and
>> Cc: <stable@vger.kernel.org>	[3.1]
>> as for below.
>>> ---
>>> For 3.2, 3.1 is ok.
>>> ---
> No need to cc stable since the issue is not in stable kernels.

Ah, so I've misunderstood what was that about...
So it has been introduced in 3.2-rc cycle.
Ok. Then now it is the perfect time to fix this ;)


-- 
Regards,
Igor.
