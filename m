From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 1 Apr 2013 22:35:45 -0500
Message-ID: <20130402033545.GA2020@snafu>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
 <20130328212739.13785.44736@quantum>
 <20130328223513.GA19470@kahuna>
 <51596725.9060109@ti.com>
 <20130401181057.8177.19688@quantum>
 <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com>
 <20130401213430.8177.21940@quantum>
 <20130401230009.GA2038@snafu>
 <20130402000545.8177.65252@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58893 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759877Ab3DBDfs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 23:35:48 -0400
Content-Disposition: inline
In-Reply-To: <20130402000545.8177.65252@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

On 17:05-20130401, Mike Turquette wrote:
> OK, so we're in agreement on what The Future looks like.  What does that
> mean for Andrii's patchset?
Unless anyone has an fundamental issue with the approach of an "Super
regulator" controlling "sub regulators", I think, in-line with your
view, we should probably make ABB as an regulator instead of inventing
our own API and hooking it around clock notifiers.
-- 
Regards,
Nishanth Menon
