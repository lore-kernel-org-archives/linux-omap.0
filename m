From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 08/11] ARM: OMAP4+: Adding the temperature sensor
 register set bit fields
Date: Mon, 28 May 2012 14:18:18 +0300
Message-ID: <20120528111818.GE3923@besouro>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-9-git-send-email-eduardo.valentin@ti.com>
 <CAMQu2gweS9O7+n3_J=7W3CeDOBgMML+z+BXKafqChhEZd3bmDQ@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35790 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752539Ab2E1LSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 May 2012 07:18:25 -0400
Received: by obbun3 with SMTP id un3so6797755obb.11
        for <linux-omap@vger.kernel.org>; Mon, 28 May 2012 04:18:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gweS9O7+n3_J=7W3CeDOBgMML+z+BXKafqChhEZd3bmDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Keerthy <j-keerthy@ti.com>

On Mon, May 28, 2012 at 03:34:28PM +0530, Shilimkar, Santosh wrote:
> On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > OMAP4460 specific temperature sensor register bit fields are added.
> > Existing OMAP4 entries are renamed to OMAP4430.
> >
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> Once you split the header, as mentioned in earlier comment,
> you can move those defines in driver file directly.

Agreed, this patch is gonna be dropped and the definition will be part of patch introducing the bandgap driver

> 
> Regards
> Santsoh
