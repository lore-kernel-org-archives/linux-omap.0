From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract regulator_init_data
Date: Mon, 24 Oct 2011 15:35:50 +0530
Message-ID: <4EA5387E.8090500@ti.com>
References: <20111019144215.GA32007@S2100-06.ap.freescale.net> <4E9FAF42.5060200@ti.com> <20111020061408.GE32007@S2100-06.ap.freescale.net> <4EA00F7C.1080005@ti.com> <20111021082309.GA337@S2100-06.ap.freescale.net> <4EA13053.7080306@ti.com> <20111021115809.GB337@S2100-06.ap.freescale.net> <4EA4FF6B.2080906@ti.com> <20111024081706.GC8708@ponder.secretlab.ca> <4EA5279E.3000505@ti.com> <20111024091924.GA6148@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111024091924.GA6148@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Shawn Guo <shawn.guo@freescale.com>, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 24 October 2011 02:49 PM, Mark Brown wrote:
> On Mon, Oct 24, 2011 at 02:23:50PM +0530, Rajendra Nayak wrote:
>
>> How about the driver passing the of_node to be associated with the
>> regulator, as part of regulator_desc, to the regulator core,
>> instead of this complete DT search and the restriction of having
>> to match DT node names with names in regulator_desc.
>
> regulator_desc should be const so that we handle multiple instances of
> the same device nicely.  We could pass the information in as an argument
> I guess.

Ok, will do. The only downside being that all existing users would
need to be changed.
