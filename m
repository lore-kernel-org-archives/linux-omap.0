From: Michael Welling <mwelling@ieee.org>
Subject: AM335x OMAP2 common clock external fixed-clock registration
Date: Tue, 14 Apr 2015 16:17:35 -0500
Message-ID: <20150414211734.GA28974@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, gregkh@linuxfoundation.org
Cc: Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

Greetings,

I have developed an AM3354 based SoM and it uses an external SI5351 clock
generator to drive the clock inputs for an external duart and I2S audio
master clock. With the registration according to the documentation the
reference clock is not being detected and hence the clock generator is
not working as expect.

After trying many different things, I started to look around the mailing
lists to find information related to this issue.

I came acrossed post that has the exact same issue:
https://lkml.org/lkml/2013/2/18/468

Seeing as the patch did not land upstream, I am wondering if there is
a solution that I am not seeing.

I am willing to provide a patch given appropriate guidance.

Regards,

Michael
