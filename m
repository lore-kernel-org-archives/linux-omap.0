From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 04/11] mfd: omap-usb: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 14:25:47 +0530
Message-ID: <CAP05o4L5r46UV3yte-iH1Qh7yA=dggjjHmeHvQTyURg31mo6Xw@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	<1340372890-10091-5-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46081 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189Ab2FYIzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 04:55:50 -0400
Received: by lbbgg6 with SMTP id gg6so7154498lbb.8
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 01:55:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

On Sat, Jun 23, 2012 at 12:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework (CCF) add clk_prepare()
>> and clk_unprepare() for the various usb host clocks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>
> Looks like this one will be at least partially obsoleted by this series:
>

Thanks paul
Hi Rajendra
         please re-base this patch to below series:

> ARM: OMAP: TLL driver implementation for USB host driver
> http://marc.info/?l=linux-omap&m=134019432606399&w=2
>
> and the runtime PM conversion in that series needs to be done anyway.
>
>
> - Paul
