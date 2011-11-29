From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCHv7 6/7] regulator: twl: add support for external
 controller
Date: Tue, 29 Nov 2011 07:10:17 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D1214303442E@DBDE01.ent.ti.com>
References: <47CEF8C4B26E8C44B22B028A650E0EA9046299@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33475 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1K2HKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Nov 2011 02:10:31 -0500
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA9046299@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kristo, Tero
> Sent: Monday, November 28, 2011 8:23 PM
> To: linux-omap@vger.kernel.org
> Cc: sameo@linux.intel.com; broonie@opensource.wolfsonmicro.com;
> Girdwood, Liam; Hilman, Kevin; Cousson, Benoit; Nayak, Rajendra;
> gg@slimlogic.co.uk
> Subject: [PATCHv7 6/7] regulator: twl: add support for external
> controller
> 
> TWL regulator now has two alternative control paths: the default
> I2C path or an optional voltage processor path for OMAP chips.
> If the voltage processor path should be used, this can be
> indicated within the platform data by adding flag TWL_VP_SMPS_MODE
> to regulator_init_data->driver_data.
>

Other TI PMICs like TPS65910 also have two I2C interfaces. Since 
the datasheets refers to these as Control (CTL) and SmartReflex (SR) interfaces, 
instead of the OMAP specific TWL_VP_SMPS_MODE, how about renaming the flag to 
TWL_SR_SMPS_MODE?

AFAIK the second I2C interface in all these PMICs is meant only
for the SMPS outputs. Moreover, which of the two interfaces to use
would be known during the init phase.

Is there a scenario where someone would want to change this at runtime? 

At least for TPS65910, it is possible to use the SR-I2C interface 
just like the CTL interface. In other words, even SoCs which do not 
have VP/VC can choose to change the SMPS voltage using the SR-I2C 
interface. The only catch is that only the SMPS registers can be 
accessed from this interface.

If this is the case with TWL series also, we could have non VP/VC 
specific smps_get/set_voltage APIs for the SR-I2C interface which 
SoCs with VP/VC override at init time. Note that the driver will have
two smps_get/set_voltage implementations, one corresponding to CTL-I2C
and the other corresponding to SR-I2C. During the init phase, which set
of APIs to use is indicated via a flag like TWL_SR_SMPS_MODE.

With such a change, the voltage change during DVFS would also boil down
to normal regulator calls for changing the voltage. SoCs which do not
have the VP/VC functionality can use the default implementations 
via the SR-I2C or CTL-I2C (decided at init time) and SoCs with VP/VC 
use their specific implementations.

Regards,
Vaibhav

P.S. - Somehow this patch series didn't appear in my mailbox. Reply from Gmane
seems to have gotten lost. So I replying to a forwared version. Hope this appears ok.
