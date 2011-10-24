From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
 regulator_init_data
Date: Mon, 24 Oct 2011 15:06:37 +0200
Message-ID: <20111024130636.GB26033@opensource.wolfsonmicro.com>
References: <1318263578-7407-4-git-send-email-rnayak@ti.com>
 <20111018132032.GD30703@S2100-06.ap.freescale.net>
 <4E9EB61C.1040207@ti.com>
 <20111019144215.GA32007@S2100-06.ap.freescale.net>
 <4E9FAF42.5060200@ti.com>
 <20111020061408.GE32007@S2100-06.ap.freescale.net>
 <4EA00F7C.1080005@ti.com>
 <20111021082309.GA337@S2100-06.ap.freescale.net>
 <20111024092411.GE8708@ponder.secretlab.ca>
 <20111024130429.GD1755@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111024130429.GD1755@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rajendra Nayak <rnayak@ti.com>, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2011 at 09:04:31PM +0800, Shawn Guo wrote:

> If we can attach the device_node of 'regulators' node to dev->of_node
> when calling regulator_register(regulator_desc, dev, ...) from
> regulator driver, the regulator core will be able to find all nodes under
> 'regulators' using for_each_child_of_node(dev->of_node, child).

Please provide concrete examples of the bindings you're talking about,
the really important thing here is how sane the bindings look and I've
really got no idea what any of what you're talking about will look like
or if they make sense.

> hesitate to hack this into mfd_add_devices(), so I would like to add
> compatible string "fsl,mc13892-regulators" to node 'regulators' and
> find the node using of_find_compatible_node(dev->parent, NULL,
> "fsl,mc13892-regulators").

It's not immediately obvious to me that having a binding for the
regulators separately makes sense, it's not a usefully distinct device.
