From: Nishanth Menon <nm@ti.com>
Subject: Re: [RESEND PATCH] regulator: core: Disable unused regulators after
 deferred probing is done
Date: Thu, 24 Apr 2014 09:18:22 -0500
Message-ID: <53591D2E.8020505@ti.com>
References: <1398294650-24821-1-git-send-email-nm@ti.com> <20140424133451.GZ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424133451.GZ12304@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Saravana Kannan <skannan@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On 04/24/2014 08:34 AM, Mark Brown wrote:
> On Wed, Apr 23, 2014 at 06:10:50PM -0500, Nishanth Menon wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>>
>> regulator_init_complete does a scan of regulators which dont have
>> always-on or consumers are automatically disabled as being unused.
>> However, with deferred probing, late_initcall() is too soon to
>> declare a regulator as unused as the regulator itself might not
>> have registered due to defferal - Example: A regulator deffered due
>> to i2bus not available which in turn is deffered due to pinctrl
>> availability.
>>
>> Since deferred probing is done in late_initcall(), do the cleanup of
>> unused regulators by regulator_init_complete in late_initcall_sync
>> instead of late_initcall.
> 
> I'll apply this however since as we discussed on IRC last night it's
> going to make the issues with unconfigured regulators getting powered
> off more severe before I do so I'll change things so that regulators
> with no configuration at all don't get touched by the core.
> 
Thanks Mark.

-- 
Regards,
Nishanth Menon
