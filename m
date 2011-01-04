From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 01/10] cbus: retu: give it a context structure
Date: Tue, 4 Jan 2011 08:51:34 +0200
Message-ID: <20110104065134.GA2367@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-2-git-send-email-balbi@ti.com>
 <20110104014016.GW7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43694 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547Ab1ADGvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 01:51:39 -0500
Received: by yib18 with SMTP id 18so3388744yib.33
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 22:51:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104014016.GW7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Jan 03, 2011 at 05:40:16PM -0800, Tony Lindgren wrote:
>* Felipe Balbi <balbi@ti.com> [110102 23:49]:
>> This is pretty much a cleanup patch just
>> adding a context structure for Retu, to avoid
>> all the globals it had.
>>
>> Note that this breaks retu-user.c due to moving
>> the lock around, but that retu-user.c has to
>> go anyway as it's completely non-standard way
>> of accessing Retu children.
>
>FYI, this one alone fails to compile with:

Yeah, there's a note on commit log about it. Anyway, I don't know what I
had in mind, I'll drop retu-user.c before this patch and there won't be
problems.

-- 
balbi
