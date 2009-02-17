From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Backlight driver for omap3evm
Date: Tue, 17 Feb 2009 18:20:11 +0000
Message-ID: <1234894811.5312.59.camel@dax.rpnet.com>
References: <19F8576C6E063C45BE387C64729E739403FA81B8D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA81B8D2@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi,
	Sanjeev" <premi@ti.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org


On Tue, 2009-02-10 at 22:52 +0530, Hiremath, Vaibhav wrote:
> [Hiremath, Vaibhav] Now I will be following up for OMAP3EVM backlight
> driver patch initiated/posted by Sanjeev. I was just referring to the
> backlight drives currently available under Linux tree, and observed
> that almost all drivers have been implemented in different way. I
> could not able to get one driver to which I can refer to for adding
> support for OMAP3EVM backlight driver.
> 
> Can anybody tell me the expected way of implementation for backlight driver is?
> 
> I have some questions here,
> 
> 	- If I understand correctly (and as mentioned and pointed out by
> Richard in the mail-chain), platform_device should get added in
> platform file where it registers the pointer to the structure "struct
> generic_bl_info". 
> This I believe should be standard way everybody should follow, which
> is not the case.
> Am I missing something here?
> 
> 	- The below question may sound foolish, but to is important for me to understand the framework.
> 
> If I have simple and straight control of backlight, do I really
> required to have separate backlight driver for my platform? Can I make
> use of generic-bl driver?
> The only difference (atleast to my platform) would be the SYSFS entry,
> the entry will get created something like
> /sys/class/backlight/generic-bl/
> 
> Is it required to make driver, Power aware and differentiate from generic driver?

You should be able to make the driver power aware and still use the
generic driver.

The basic idea is that your platform would register a platform device
and some code to control the backlight, e.g.:


void omap_set_bl_intensity(int X)
{
	/* Code to set backlight intensity to X */
}

static struct generic_bl_info bl_platform_data = {
	.name			= "omap-bl",
	.max_intensity		= 5,
	.default_intensity	= 2,
	.set_bl_intensity	= omap_set_bl_intensity,
};

static struct platform_device backlight_device = {
	.name			= "generic-bl",
	.id			= -1,
	.dev.platform_data	= &bl_platform_data,
};

and that should be all you need as the core class and generic-bl code
will take care of most other things for you. The code above would go
somewhere in arch/arm/mach-omap*/.

If any improvements are needed to generic-bl to make it useful, please
let me know (set_bl_intensity could maybe do with being passed more
information).

Regards,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
