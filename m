From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
Date: Mon, 5 Dec 2011 10:34:47 +0000
Message-ID: <20111205103447.GC11150@opensource.wolfsonmicro.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
 <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
 <20111204155433.GA16287@opensource.wolfsonmicro.com>
 <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, robherring2@gmail.com, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 05, 2011 at 02:40:50PM +0530, Thomas Abraham wrote:
> On 4 December 2011 21:24, Mark Brown

> > If the regulator isn't software managed then always_on covers this - the
> > regulator core will enable any always_on regulators that haven't been
> > enabled already.

> Thanks for the hint. I was trying to deal with a regulator that was
> not software managed but also required the voltage level to be set to
> certain level. That was possible with 'apply_uV' constraint in non-dt
> case. Anyway, I have modified the code to manage the regulator and
> this works fine in dt case as well without the 'apply_uV' constraint.

With the regulator device tree bindings if the regulator is configured
to run a single voltage the bindings will set apply_uV unconditionally
so there's no need for a separate constraint.
