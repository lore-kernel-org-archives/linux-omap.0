From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of reset
Date: Thu, 23 Feb 2012 19:26:56 +0530
Message-ID: <CAMQu2gzrGnWOUYacg4jvVqgjrNeHfaTJre6O5rNarQSjAuOzLg@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com> <1330003320-17400-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49930 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753383Ab2BWN5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:57:17 -0500
Received: by mail-qw0-f42.google.com with SMTP id y23so10371700qad.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 05:57:16 -0800 (PST)
In-Reply-To: <1330003320-17400-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

$Subject
s/dsp/DSP
s/tesla/TESLA

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> With no driver handling DSP/TESLA, if brought out of reset, it stays
> active and does not assert standby.
>
Which lead to IVHA PD not transitiong and hence gating CHIP retention.
You may want to add these bits as well.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Patch is fine though script needs to be updated I guess

Regards
Santosh
