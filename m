From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/23] ARM: dts: omap: Remove skeleton.dtsi usage and fix
 memory node DTC warning"
Date: Wed, 31 Aug 2016 07:24:44 -0700
Message-ID: <20160831142443.yevd4c6wldrprxrl@atomide.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160831 03:36]:
> Hello Tony,
> 
> This series removes the usage of the skeleton.dtsi in all the OMAP dts,
> which allows to get rid of the DTC warnings about a mismatch between the
> memory nodes unit names and reg properties.
> 
> Patches are pretty trivial and shouldn't cause functional changes AFAIK,
> but have been only built tested.

OK will take a look today and make sure things stay working.

Good to hear the solution is to remove the include of skeleton.dtsi,
I was wondering what we're going to do about those warnings.

Regards,

Tony
