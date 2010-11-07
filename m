From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
Date: Sun, 7 Nov 2010 10:00:26 -0600
Message-ID: <AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-3-git-send-email-omar.ramirez@ti.com>
	<4CD5A96D.1000806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50872 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab0KGQA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 11:00:27 -0500
Received: by mail-iw0-f178.google.com with SMTP id 1so5075900iwn.9
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:00:26 -0800 (PST)
In-Reply-To: <4CD5A96D.1000806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 2:15 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Add mmu hwmod data for iva2 and isp.
>
> s/iva2/iva/

Where this terminology can be found? I'm basing this naming on what
was there or TRM. For omap3 there is no such thing as iva, it is iva2.

I can change it but I just wanted to know.

> If you do need the version information, you should use the rev field in the
> hwmod class.

I don't.

> All the comments about the structure fields order I did on your mailbox
> series will apply here as well.

Same for my comments.

Regards,

Omar
