From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] regulator: cpcap: Add basic regulator support
Date: Thu, 2 Feb 2017 15:36:30 -0800
Message-ID: <20170202233629.GH7403@atomide.com>
References: <20170131001241.5926-1-tony@atomide.com>
 <20170201171435.hl3atrmrrz7mjsmo@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201171435.hl3atrmrrz7mjsmo@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [170201 09:15]:
> On Mon, Jan 30, 2017 at 04:12:41PM -0800, Tony Lindgren wrote:
> > +Example:
> > +
> > +cpcap_regulator: regulator@600 {
> 
> unit-address with no reg prop.

Oops thanks for spotting that. Will resend v2 shortly.

Regards,

Tony
