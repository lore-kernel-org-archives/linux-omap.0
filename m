From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Tue, 2 Apr 2013 20:35:49 +0300
Message-ID: <515B16F5.2090708@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com> <20130328212739.13785.44736@quantum> <20130328223513.GA19470@kahuna> <51596725.9060109@ti.com> <20130401181057.8177.19688@quantum> <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com> <20130401213430.8177.21940@quantum> <20130401230009.GA2038@snafu> <20130402000545.8177.65252@quantum> <20130402033545.GA2020@snafu> <20130402171614.8177.68752@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756756Ab3DBRfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 13:35:52 -0400
In-Reply-To: <20130402171614.8177.68752@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, andrii.tseglytskyi@ti.com

On 04/02/2013 08:16 PM, Mike Turquette wrote:
> Quoting Nishanth Menon (2013-04-01 20:35:45)
>> On 17:05-20130401, Mike Turquette wrote:
>>> OK, so we're in agreement on what The Future looks like.  What does that
>>> mean for Andrii's patchset?
>> Unless anyone has an fundamental issue with the approach of an "Super
>> regulator" controlling "sub regulators", I think, in-line with your
>> view, we should probably make ABB as an regulator instead of inventing
>> our own API and hooking it around clock notifiers.
> ACK.  Making the ABB code into a regulator driver is the right thing to
> do regardless of whether or not we use a Super Regulator(tm) or just
> chain together Not So Super Regulators(tm).
>
> I'm not an expert at the regulator framework, but I encourage Andrii to
> look into regulator_set_mode(), which might be a more semantically
> accurate alternative than regulator_set_voltage() for the ABB ldo.
>
> Regards,
> Mike
>
>> -- 
>> Regards,
>> Nishanth Menon

Hi,

Agree. It is a good idea in general.
regulator_set_mode() API seems to be good enough for handling ABB mode 
(FBB/RBB/Bypass).
Knowledge about ABB mode on each OPP can be moved from ABB regulator to 
"Super regulator".
Thanks a lot for all your comments.

Regards,
Andrii
