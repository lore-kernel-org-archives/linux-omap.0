From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Mon, 22 Nov 2010 15:57:18 +0100
Message-ID: <4CEA84CE.5010708@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com> <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com> <4CE5B68F.8000502@ti.com> <AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com> <20101119083250.GH6446@legolas.emea.dhcp.ti.com> <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com> <4CE68E9A.5040903@ti.com> <20101122100815.GM2446@legolas.emea.dhcp.ti.com> <AANLkTim4bHJHFdOEXt-hM7Yt2wGsVTcfJExwzzcUKXmq@mail.gmail.com> <20101122115153.GE2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab0KVO5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 09:57:35 -0500
In-Reply-To: <20101122115153.GE2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 11/22/2010 12:51 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 05:46:53AM -0600, Kanigeri, Hari wrote:
>> > From the dmtimer stuff, it looks like the driver defines the version
>> types, which hwmod uses to define the rev field.
>>
>> /* timer ip constants */
>> #define OMAP_TIMER_IP_LEGACY			0x1
>> #define OMAP_TIMER_IP_VERSION_2			0x2
>
> in that case, it's the same as if you pass in a flag via platform_data.
> You might as well call it rev, then the diff when converting to hwmod
> will be smaller maybe :-p

Yes, this is exactly what I was proposing to Hari.
For the moment create the pdata field that will be populated at init 
time using the cpu_is.
During the hwmod migration, the value will be extracted from the hwmod 
rev field.

Benoit

