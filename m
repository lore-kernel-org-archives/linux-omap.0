From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] regulator: tps65910: wire up sleep control configuration
Date: Wed, 14 Jun 2017 17:13:29 +0200
Message-ID: <20170614151329.7kb266gnksryr45y@qmqm.qmqm.pl>
References: <efc798c2a1140c545cc210a29ed2791495956510.1497442770.git.mirq-linux@rere.qmqm.pl>
 <20170614144208.nmiq2zijkyoajqgn@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170614144208.nmiq2zijkyoajqgn@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 14, 2017 at 03:42:08PM +0100, Mark Brown wrote:
> On Wed, Jun 14, 2017 at 02:25:13PM +0200, Micha³ Miros³aw wrote:
> > References: 201cf052810d20814a77ca0e0045a2c1a3508a1f
> I have no idea what you mean by this, sorry.

This is a commit id which introduced the feature:

commit 201cf052810d20814a77ca0e0045a2c1a3508a1f
Author: Laxman Dewangan <ldewangan@nvidia.com>
Date:   Wed Apr 18 12:13:51 2012 +0200

    mfd: Add support for tps65910 device sleep

    Adding support for device sleep through the external input control
    signal "SLEEP".
    Changing the SLEEP signal state can switch the device into SLEEP and
    ACTIVE state.
    Also adding sleep configuration for different resources so that they
    should be keep on during sleep state of device.

    Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Best Regards,
Micha³ Miros³aw
