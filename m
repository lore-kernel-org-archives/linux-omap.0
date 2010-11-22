From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Mon, 22 Nov 2010 13:51:53 +0200
Message-ID: <20101122115153.GE2446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
 <4CE5B68F.8000502@ti.com>
 <AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
 <20101119083250.GH6446@legolas.emea.dhcp.ti.com>
 <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
 <4CE68E9A.5040903@ti.com>
 <20101122100815.GM2446@legolas.emea.dhcp.ti.com>
 <AANLkTim4bHJHFdOEXt-hM7Yt2wGsVTcfJExwzzcUKXmq@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50299 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652Ab0KVLvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 06:51:47 -0500
Received: by mail-gx0-f169.google.com with SMTP id 7so5059613gxk.0
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:51:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim4bHJHFdOEXt-hM7Yt2wGsVTcfJExwzzcUKXmq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: balbi@ti.com, "Cousson, Benoit" <b-cousson@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi,

On Mon, Nov 22, 2010 at 05:46:53AM -0600, Kanigeri, Hari wrote:
>>From the dmtimer stuff, it looks like the driver defines the version
>types, which hwmod uses to define the rev field.
>
>/* timer ip constants */
>#define OMAP_TIMER_IP_LEGACY			0x1
>#define OMAP_TIMER_IP_VERSION_2			0x2

in that case, it's the same as if you pass in a flag via platform_data.
You might as well call it rev, then the diff when converting to hwmod
will be smaller maybe :-p

-- 
balbi
