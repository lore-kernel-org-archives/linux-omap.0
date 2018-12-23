From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Date: Sun, 23 Dec 2018 08:40:30 -0800
Message-ID: <20181223164030.GQ6707@atomide.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221110128.GO13248@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [181221 11:01]:
> On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
> 
> > These options apply to all regulators in this chip.
> > 
> > strict-supply-voltage:
> >   Set STRICT flag in CONFIG1
> > under-voltage-limit:
> >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > under-voltage-hysteresis:
> >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > 
> > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > ---
> >  drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> 
> This needs a close review by Tony and any of the other OMAP guys.

Adding Keerthy to Cc, he's probably the best person to review these
changes.

Regards,

Tony
