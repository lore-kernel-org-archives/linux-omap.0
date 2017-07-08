From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] regulator: cpcap: Fix standby mode
Date: Fri, 7 Jul 2017 22:30:12 -0700
Message-ID: <20170708053012.GN3730@atomide.com>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
 <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170707 13:08]:
> While working on the audio-codec I noticed, that the
> low power mode of the regulators are not properly
> supported. This fixes the issue for vaudio.

Yeah good catch:

Acked-by: Tony Lindgren <tony@atomide.com>
