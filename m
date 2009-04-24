From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: n800 high idle power consumption
Date: Fri, 24 Apr 2009 06:45:08 -0700
Message-ID: <87zle6xj17.fsf@deeprootsystems.com>
References: <877i1aejon.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:50171 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbZDXNpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 09:45:11 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1011325rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2009 06:45:10 -0700 (PDT)
In-Reply-To: <877i1aejon.fsf@litku.valot.fi> (Kalle Valo's message of "Fri\, 24 Apr 2009 07\:53\:44 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org

Kalle Valo <kalle.valo@iki.fi> writes:

> Hello all,
>
> I was testing 2.6.30-rc3-omap1 on n800 and noticed that idle power
> consumption is very high, ten times compared to a 2.6.29 I tested few
> weeks back. I'm guessing that CPU doesn't sleep at all.
>
> Is this a regression? How should I debug this further?

Between .29 and .30, the PM code in l-o was dropped and re-sync'd to
kernel.org code.  This is so that PM can be separated out into a
separate branch and submitted upstream independently.

The current PM branch is in the process of being re-based onto 2.6.30.
When it's ready, I'd appreciate any testing on n800.

Kevin
