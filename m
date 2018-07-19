From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Date: Wed, 18 Jul 2018 23:42:05 -0700
Message-ID: <20180719064205.GI99251@atomide.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
 <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
 <20180717055547.GV99251@atomide.com>
 <70f28466-fd13-58cd-cb5b-9857d7670d69@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70f28466-fd13-58cd-cb5b-9857d7670d69@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: daniel.lezcano@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [180717 20:31]:
> On 17/07/2018 07:55, Tony Lindgren wrote:
> > These should all use the clkctrl clock nodes, see:
> 
> Even the already configured timer1 & timer2 ?

Yeah that way things will work in a generic way for the SoCs
using clkctrl registers. That's omap4 and later and including
ti81xx.

Regards,

Tony
