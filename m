From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 14:55:31 +0200
Message-ID: <AANLkTikQmd8IxZlFELUGmVJh59DpXrqIS_yjmMLuaj0D@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<20100526120242.5c9b73ad@schatten.dmk.lab>
	<AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	<20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64628 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0EZMzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 08:55:36 -0400
In-Reply-To: <20100526142430.327ccbc4@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Wed, May 26, 2010 at 2:24 PM, Florian Mickler <florian@mickler.org> wrote:

> Really, what are you getting at? Do you deny that there are programs,
> that prevent a device from sleeping? (Just think of the bouncing
> cows app)
>
> And if you have two kernels, one with which your device is dead after 1
> hour and one with which your device is dead after 10 hours. Which would
> you prefer? I mean really... this is ridiculous.

You almost always need to "hack" the mainline software for a
production system. So do it here as well. Make sure the hack is well
isolated and local. You can even submit it to the mainline, better as
a configuration option, _unless_ it is a *framework* that provokes
writing code in an ugly and unsafe way.

~Vitaly
