From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] HSMMC: Update mmc configuration for Overo
Date: Fri, 21 Nov 2008 10:35:56 -0800
Message-ID: <5e088bd90811211035m4d2d44aeyf45c63fc6dd53532@mail.gmail.com>
References: <5e088bd90811182205rf6fefb5vdbc145dcdc3980d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:38109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYKUSgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 13:36:00 -0500
Received: by ug-out-1314.google.com with SMTP id 39so188988ugf.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 10:35:56 -0800 (PST)
In-Reply-To: <5e088bd90811182205rf6fefb5vdbc145dcdc3980d5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 18, 2008 at 10:05 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> This patch adds card detect support for mmc1
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>

Tony - please don't merge this patch.

Turns out that CD for microSD isn't quite so straightforward.  I'll
resubmit at a later time.

Steve
