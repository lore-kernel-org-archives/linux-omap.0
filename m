From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Fri, 3 Feb 2012 12:45:09 +0530
Message-ID: <CAMQu2gy2jDWszUAMDCfgyXsLNWUAb6phWpOP=7geFXTkc30S_g@mail.gmail.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com> <87obthcc57.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35423 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753831Ab2BCHPb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 02:15:31 -0500
Received: by qadc10 with SMTP id c10so595899qad.5
        for <linux-omap@vger.kernel.org>; Thu, 02 Feb 2012 23:15:29 -0800 (PST)
In-Reply-To: <87obthcc57.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

On Fri, Feb 3, 2012 at 12:10 AM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> hwmod setup already does a reset and sets the OCP sysconfig
>> registers appropriately. Avoid doing a reset again and overriding
>> the OCP sysconfig settings in the system timer init code.
>
> That is true for OMAP4, but have you verified if this is indeed a
> duplicate reset on =A0OMAP2/3?
>
Yes. It is duplicate for OMAP2 and OMAP3 devices as well.
Actually this should have been fixed when the driver was
hwmod converted but some how got missed. We noticed
an issue on OMAP5, when timer interrupts stopped firing when
always on clock domain was allowed to idle. This was because
this reset was clearing the correctly set sysc value by hwmod.

The patch is also tested on ZOOM3 ( OMAP3630)
and OMAP2430SDP.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
