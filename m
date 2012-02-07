From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
Date: Tue, 07 Feb 2012 15:30:26 +0200
Message-ID: <4F312772.6090000@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com> <1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com> <20120207131657.GL3332@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120207131657.GL3332@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/07/2012 03:16 PM, Mark Brown wrote:
> though I'd be inclined to just embed this structure into the twl6040
> struct directly, you're always going to need to allocate it and it sa=
ves
> a tiny bit of error handling and whatnot.

True. I'm not sure why I have settled with this solution... As I recall
I just did not wanted to add the regulator related includes to the
mfd/twl6040.h header.

--=20
P=E9ter
