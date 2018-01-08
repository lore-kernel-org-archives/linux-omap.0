From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Add capture functionality to OMAP pwm driver
Date: Mon, 8 Jan 2018 13:51:23 -0800
Message-ID: <20180108215123.GU3875@atomide.com>
References: <20180108153926.GA3916@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108153926.GA3916@lenoch>
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [180108 15:42]:
> Tony, I wanted to do something easy to understand as a base for
> event capture interrupt, but either I do not understand hardware,
> or it indeed cannot do pulse capture.

Hmm OK. Presumably it works as it's been around for a long time,
I thought any edge trigger will just sample the current counter
value and that's it..

Regards,

Tony
