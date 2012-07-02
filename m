From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Mon, 2 Jul 2012 19:54:41 +0530
Message-ID: <CAP05o4+jmFba4z5UCoZWTnptnjUcw+OQT_69gxw42=S9zJCVLA@mail.gmail.com>
References: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
	<Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54036 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183Ab2GBOY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 10:24:58 -0400
Received: by lbbgk8 with SMTP id gk8so8219099lbb.12
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 07:24:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

On Mon, Jul 2, 2012 at 7:35 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 2 Jul 2012, Munegowda, Keshava wrote:
>
>> Hi Samuel
>>        please drop this patch for now , since Alan stern has mentioned
>> improvements for this patch and we
>> need to wait for Alan's new patch on ehci-omap.c and then Rus dill
>> patch and my usbhs tll
>> patch series need to be rebased.
>
> No, that's okay.  I rebased my patch on top of Russ's; see
>
>         http://marc.info/?l=linux-usb&m=134098478928668&w=2
>
> so Russ's patch should be kept.  My patch needed other changes also, so
> this wasn't a big deal.
>
> The extra problems I mentioned in an earlier email will still need to
> be fixed after both Russ's patch and my own are merged.
>
> Alan Stern

Thanks Alan,
            Ok, then I will rebase my TLL driver patch series on top
of this patch.

regards
keshava
