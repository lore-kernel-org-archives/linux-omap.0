From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Tue, 18 Aug 2015 11:23:54 +0530
Message-ID: <55D2C872.9000400@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150814180006.GB10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150814180006.GB10748@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark Brown,

On Friday 14 August 2015 11:30 PM, Mark Brown wrote:
> On Mon, Jul 27, 2015 at 04:54:09PM +0530, Kishon Vijay Abraham I wrote:
> 
>> vsel_reg and enable_reg of the pbias regulator descriptor should actually
>> have the offset from syscon. However after the pbias device tree node
> 
> I'm having a hard time understanding this statement, sorry.  What makes
> you say that they "shouild actually have the offset from syscon"?  What
> is the problem that this is supposed to fix?

The register to program pbias regulator is 0x4A002E00. The syscon base address
is 0x4a002000. So the vsel_reg and enable_reg should have the offset from
syscon base address. regulator_enable_regmap gets the base address from
'regmap' and offset from 'enable_reg' in order to program the pbias regulator.

But without this patch vsel_reg and enable_reg have the absolute address
instead of just the offset.
> 
>> is moved as a child node of syscon, vsel_reg and enable_reg has the
>> absolute address because of the address translation that happens while
>> creating device from device tree node.
>> So avoid using platform_get_resource and use of_get_address in order to
>> get only the offset (untranslated address) and populate these in
>> vsel_reg and enable_reg.
> 
> This sounds like we're going in the wrong direction, we're moving from a
> more generic API to a firmware specific one.  Why is this a good fix?

platform_get_resource can be used if we need the absolute address but here we
need only the offset.

Thanks
Kishon
