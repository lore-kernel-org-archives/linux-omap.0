From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 0/5 V2 RESEND] ARM: OMAP: TLL driver implementation for
 USB host driver
Date: Mon, 2 Jul 2012 20:37:26 +0530
Message-ID: <CAP05o4KaSfTM48Sy7hAstikTUFfSeWuoadVXG0JmYTmEA_WBNw@mail.gmail.com>
References: <1340709962-15726-1-git-send-email-keshava_mgowda@ti.com>
	<20120702143120.GF22065@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42409 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753236Ab2GBPH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 11:07:29 -0400
Received: by lboj14 with SMTP id j14so10782119lbo.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 08:07:26 -0700 (PDT)
In-Reply-To: <20120702143120.GF22065@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, paul@pwsan.com, b-cousson@ti.com, sshtylyov@mvista.com

On Mon, Jul 2, 2012 at 8:01 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Keshava,
>
> On Tue, Jun 26, 2012 at 04:56:02PM +0530, Keshava Munegowda wrote:
>> The TLL configuration is removed from the UHH driver and implemented as
>> a seperate platform driver. Now, the UHH driver configures the TLL
>> through API's exported by the TLL platform driver. The TLL is an
>> has independent hardware mod structure for in OMAP3 and later chips,
>> hence an dedicated platform driver is created.
> I'm sort of ok with that split although the new driver is definitely not an
> MFD one, but I guess there's no better place for it.
> Now, a few comments before applying it:
>
> - I'd appreciate to get ACKs from e.g. Tony for the OMAP parts.
> - Patch #3 doesn't apply on top of my for-next branch. Would you mind rebasing
>   it properly ?
> - Fix the coypright years to 2012.
>
> Cheers,
> Samuel.


Hi samuel
    just now I have posted v3 of this series.

This series is on top of

Rus dill patch : http://permalink.gmane.org/gmane.linux.usb.general/65988
and my patch : ttp://permalink.gmane.org/gmane.linux.usb.general/66239

you need these patches before applying this series.

regards
keshava
