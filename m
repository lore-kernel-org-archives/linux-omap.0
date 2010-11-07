From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 5/6] omap: iommu: hwmod device enable/disable routines
Date: Sun, 7 Nov 2010 10:24:23 -0600
Message-ID: <AANLkTimskJ7qWYE1JsoTuu+=ZJdaKSmAiS_8rx30sq5B@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-6-git-send-email-omar.ramirez@ti.com>
	<4CD5C5FF.9050804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50600 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753463Ab0KGQYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 11:24:23 -0500
Received: by mail-iw0-f169.google.com with SMTP id 9so5028658iwn.14
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:24:23 -0800 (PST)
In-Reply-To: <4CD5C5FF.9050804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 4:17 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> You should use runtime PM directly. That omap_device step is useless.
>
> Moreover, this patch should be merged with the previous one.

Agree, will check on runtime PM.

Regards,

Omar
