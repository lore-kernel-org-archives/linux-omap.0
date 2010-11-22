From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Mon, 22 Nov 2010 05:58:04 -0600
Message-ID: <AANLkTi=RegCd+VrhbPpmt-xC5RxetdzsGkAy5v-z=9fV@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
	<AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
	<4CE68E9A.5040903@ti.com>
	<20101122100815.GM2446@legolas.emea.dhcp.ti.com>
	<AANLkTim4bHJHFdOEXt-hM7Yt2wGsVTcfJExwzzcUKXmq@mail.gmail.com>
	<20101122115153.GE2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43876 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754954Ab0KVL6G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 06:58:06 -0500
Received: by qwc9 with SMTP id 9so748572qwc.33
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:58:05 -0800 (PST)
In-Reply-To: <20101122115153.GE2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

=46elipe,

On Mon, Nov 22, 2010 at 5:51 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 05:46:53AM -0600, Kanigeri, Hari wrote:
>>>
>>> From the dmtimer stuff, it looks like the driver defines the versio=
n
>>
>> types, which hwmod uses to define the rev field.
>>
>> /* timer ip constants */
>> #define OMAP_TIMER_IP_LEGACY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x1
>> #define OMAP_TIMER_IP_VERSION_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2
>
> in that case, it's the same as if you pass in a flag via platform_dat=
a.
> You might as well call it rev, then the diff when converting to hwmod
> will be smaller maybe :-p

I agree with you, the changes should be minimal converting to hwmod.


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
