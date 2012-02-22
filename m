From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/3] MFD: twl6040: Conversion to i2c driver
Date: Wed, 22 Feb 2012 09:34:55 +0200
Message-ID: <4F449A9F.1040907@ti.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com> <20120220194736.GN5387@sortiz-mobl> <4F4372E3.4050408@ti.com> <20120221110533.GT5387@sortiz-mobl> <1329846755.20666.4.camel@odin> <20120221184427.GQ18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120221184427.GQ18185@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 02/21/2012 08:44 PM, Tony Lindgren wrote:
> Yeah looks OK to me, acked that patch. Let me know if there are
> others I should look.

I would appreciate if you could take a look at this series as well:
TWL6040: Regulator support
http://marc.info/?l=3Dlinux-omap&m=3D132947934522602&w=3D2

I have separated the twl6040 i2c driver conversion, and regulator
support since they are dealing with different issues.
If you know who should look at the drivers/regulator/twl-regulator.c,
drivers/mfd/twl.c changes could you CC them as well?

Regards,
P=E9ter
