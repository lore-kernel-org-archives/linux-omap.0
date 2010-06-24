From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 24 Jun 2010 10:59:02 -0700
Message-ID: <87mxukcnx5.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-12-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
	<alpine.DEB.2.00.1006240050570.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41324 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0FXR7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:59:06 -0400
Received: by pwj8 with SMTP id 8so1961241pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:59:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006240050570.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 24 Jun 2010 00:55:35 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> one other thought.
>
> On Thu, 24 Jun 2010, Paul Walmsley wrote:
>
>> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>> 
>> > Create simple omap_devices for the main processors and busses.
>> > 
>> > This is required to support the forth-coming device-based OPP
>> > approach, where OPPs are managed and tracked at the device level.
>
> If these omap_devices are only to deal with OPPs, you might only need one 
> omap_device for the MPU subsystem for OMAP4, since I think both cores 
> receive the same clock.  That might simplify this patch for the current 
> timeframe.

Agreed.

Again, I fall victim to my own last-minute changes.  Up until yesterday
I wasn't trying to deal with SMP, and decided to add it yesterday,
clearly without a good (enough) understanding of the PER_CPU stuff for
SMP.

Will re-spin without the SMP and multiple-devices-in-class support.

Kevin

