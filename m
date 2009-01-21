From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ASoC: Complete Beagleboard support
Date: Wed, 21 Jan 2009 06:40:41 -0800
Message-ID: <5e088bd90901210640v4ce21f8clae9469b60226a6f0@mail.gmail.com>
References: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
	 <200901210953.36630.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63436 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZAUOkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 09:40:43 -0500
Received: by bwz14 with SMTP id 14so12885050bwz.13
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 06:40:41 -0800 (PST)
In-Reply-To: <200901210953.36630.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap <linux-omap@vger.kernel.org>

On Tue, Jan 20, 2009 at 11:53 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> Hello,
>
> for ure now you can build it, but does it actually works?
> I mean there has been quite a bit of change in the twl4030
> codec driver... The DAPM routing implementation might require
> some change in the board file also (SND_SOC_DAPM_HP,
> SND_SOC_DAPM_LINE, etc).

I will test this morning.  I expect it should work since Overo works
and Beagle is largely identical.

Steve
