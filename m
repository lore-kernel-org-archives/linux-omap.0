From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: N900: TWL4030 Keypad Matrix definition
Date: Fri, 11 Oct 2013 16:39:36 -0700
Message-ID: <20131011233935.GF29913@atomide.com>
References: <1381353447-32708-1-git-send-email-sre@debian.org>
 <1381353447-32708-2-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381353447-32708-2-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org, =?utf-8?Q?'Beno=C3=AEt?= Cousson' <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131009 14:26]:
> Add Keyboard Matrix information to N900's DTS file.
> This patch maps the keys exactly as the original
> board code.

This should be queued by Benoit along with other .dts
changes, not via the input tree:

Acked-by: Tony Lindgren <tony@atomide.com>
