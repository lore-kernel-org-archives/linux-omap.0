From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Mon, 25 Jun 2012 13:35:17 -0500
Message-ID: <87d34nfdei.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi> <87ehp71liv.fsf@ti.com>
	<20120622203645.GD29290@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:57309 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755701Ab2FYSfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 14:35:14 -0400
Received: by ggnp1 with SMTP id p1so3651818ggn.32
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 11:35:12 -0700 (PDT)
In-Reply-To: <20120622203645.GD29290@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Fri, 22 Jun 2012 23:36:46 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

Felipe Balbi <balbi@ti.com> writes:

[...]

> Keshava is reverting a fix for a HW errata. I can't accept it as it will
> cause regressions. Granted, regression by regression, there's no change,
> but I simply can't knowingly cause a regression to the driver just to
> have PM working. We need a real fix for this issue.

Sure, as long as there is a fix in this -rc cycle.

This driver intoduced changes in v3.5 that break PM for the whole SoC
(by preventing CORE retention.)  These changes were clearly not tested
with PM.

If you cannot fix this during the -rc cycle, then you need to revert the
driver PM changes that broke PM for the *whole* SoC.

Kevin
