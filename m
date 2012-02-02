From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 5/7] OMAP: sdp4430: Add fixed regulator for twl6040 needs
Date: Thu, 02 Feb 2012 15:03:56 +0200
Message-ID: <4F2A89BC.6090303@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com> <1328185019-29575-6-git-send-email-peter.ujfalusi@ti.com> <20120202124025.GF7428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120202124025.GF7428@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/02/2012 02:40 PM, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 02:16:57PM +0200, Peter Ujfalusi wrote:
>> The twl6040 VIO power is connected to SMPS V1V8, the
>> V2V1 power is coming from SMPS V2V1 of twl6030.
>> These are fixed, always on regulators.
>> Create fixed voltage regulators for these supplies.
>=20
> Shouldn't the PMIC be creating the relevant fixed voltage regulators?
> It's a bit clearer given that the supplies actually come from the PMI=
C
> and it would cut down a bit on the boilerplate in boards (though much
> less so with device tree, sadly).

Yes these are coming from twl6030, so it might be better to create the
fixed regulators in the PMIC driver. I'll take a look.

Thanks,
P=E9ter
