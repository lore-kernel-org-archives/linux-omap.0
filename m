From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1] regulator: twl: Provide of_map_mode for twl4030
Date: Fri, 8 Apr 2016 08:49:07 -0700
Message-ID: <20160408154907.GT16484@atomide.com>
References: <20160404222638.GM2350@sirena.org.uk>
 <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160407175745.GK32257@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407175745.GK32257@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, broonie@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [160407 10:58]:
> On Tue, Apr 05, 2016 at 08:59:34AM +0300, Ivaylo Dimitrov wrote:
> > of_map_mode is needed so to be possible to set initial regulators mode from
> > the board DTS. Otherwise, for DT boot, regulators are left in their default
> > state after reset/reboot. Document device specific modes as well.
> > 
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > ---
> >  .../bindings/regulator/twl-regulator.txt           |  6 ++++++
> 
> Acked-by: Rob Herring <robh@kernel.org>

I'd like to test these patches, but I don't know which combination
of patches needed? It seems we're waiting for an update on at least
one of the patches in this series?

Might be best to repost the whole series so people can test the
right patches.

Regards,

Tony
