From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
Date: Mon, 09 Jan 2012 15:12:50 -0800
Message-ID: <4F0B7472.3000108@ti.com>
References: <20120109131412.6238edf3@notabene.brown> <87obucxyif.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59466 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932953Ab2AIXMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 18:12:52 -0500
Received: by mail-gy0-f180.google.com with SMTP id r20so1763155ghr.25
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 15:12:51 -0800 (PST)
In-Reply-To: <87obucxyif.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/09/2012 03:11 PM, Kevin Hilman wrote:
> NeilBrown<neilb@suse.de>  writes:
>
>> opp_find_freq_ceil and opp_get_voltage are documented as requiring
>> rcu_lock to be held.  So hold it.
>>
>> Signed-off-by: NeilBrown<neilb@suse.de>
>
> Missing 'ARM: ' prefix, but I added it locally and queued as a fix for
> v3.3.

oops, sent this before I saw your updated version.

Kevin

