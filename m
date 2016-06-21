From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 02/19] HSI: omap_ssi: do not reset module
Date: Tue, 21 Jun 2016 04:38:13 -0700
Message-ID: <20160621113812.GR22406@atomide.com>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
 <1466267229-25012-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466267229-25012-3-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160618 09:30]:
> module reset and power management rule setup
> is already done by hwmod. Remove this cruft,
> which predates hwmod.

Sounds good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
