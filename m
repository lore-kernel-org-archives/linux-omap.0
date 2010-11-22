From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Mon, 22 Nov 2010 12:08:15 +0200
Message-ID: <20101122100815.GM2446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
 <4CE5B68F.8000502@ti.com>
 <AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
 <20101119083250.GH6446@legolas.emea.dhcp.ti.com>
 <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
 <4CE68E9A.5040903@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36609 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753241Ab0KVKIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 05:08:09 -0500
Received: by gyd8 with SMTP id 8so4186509gyd.9
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 02:08:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE68E9A.5040903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 19, 2010 at 03:50:02PM +0100, Cousson, Benoit wrote:
>Most of the time, we do not want to use the IP revision because it is 
>un-accurate and does not reflect the change we'd like to track.
>For example some time a minor change in the RTL that will not impact 
>the SW at all might trigger a change in the IP revision, whereas on 
>the other hand a major bug fix that will impact the SW is not capture 
>in the IP revision... yeah, that's bad, but this can happen.
>
>That's why we are relying on a rev field in the hwmod.

But then, what's inside this rev field ? Is it some internal revision of
hwmod or do you read from the hw ?

-- 
balbi
