From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions
 when not needed.
Date: Mon, 13 Jun 2016 00:39:59 -0700
Message-ID: <20160613073958.GR22406@atomide.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509193624.GH5995@atomide.com>
 <5730F840.3050807@gmail.com>
 <20160610102225.GS22406@atomide.com>
 <575B2F48.4090707@gmail.com>
 <20160613071057.GQ22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160613071057.GQ22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160613 00:10]:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160610 14:23]:
> > 
> > On 10.06.2016 13:22, Tony Lindgren wrote:
> > > 
> > > OK. And I just applied the related dts changes. Please repost the driver
> > > changes and DT binding doc with Rob's ack to the driver maintainers to
> > > apply.
> > > 
> > 
> > Already did, see https://lkml.org/lkml/2016/5/16/429
> > 
> > Shall I do anything else?
> 
> Probably good idea to repost just the driver changes to the
> subsystem maintainers. With v4.7 out any pre v4.7 patchsets
> easily get forgotten.

Heh s/v4.7/v4.6/ :)

Tony
