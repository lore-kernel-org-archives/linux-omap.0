From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Thu, 28 Jul 2011 08:31:39 -0500
Message-ID: <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E315C9F.1030801@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Balbi,
	Felipe" <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 28, 2011 at 07:57, Cousson, Benoit <b-cousson@ti.com> wrote:
[...]
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index 293fa6c..77d01a2 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -142,6 +142,7 @@
>> =A0#include "powerdomain.h"
>> =A0#include<plat/clock.h>
>> =A0#include<plat/omap_hwmod.h>
>> +#include<plat/omap_device.h>
>
> I'd rather put that code inside the omap_device.c instead of here.
> The omap_device layer is on top of the omap_hwmod.
> In order to minimize the dependencies from the low HW description layer to
> the omap_device layer, you should maybe define a omap_device_from_hwmod()
> function or something similar.
Thanks for the review. will check on this.

>
> That being said, do we really need to get the device from the hwmod name?
> Cannot we use the device name instead?
> I do not know all the usecases, that why I'm asking.
mpu.0 , are the device names - which probably lets me walk the kernel
data structrues instead of omap database to get to the right device,
Vs using the common names like "mpu" " make things a little easier to
deal with from driver perspective.

as an example, some of the dev_driver_string(dev):dev_name(dev) (in
bracket hwmod name) I collected from OMAP4 are:
platform:mpu.0 ("mpu")
platform:l3_main_1.0 ('l3_main_1")
pvrsrvkm:pvrsrvkm.0 ("gpu")
rpres:fdif.0 ("fdif")
omap_hsi:omap_hsi.0 ("hsi")
platform:iss.0 ("iss")
etc..

I mean I have'nt been keeping track of the device tree discussions so
dont know if this function could be better done - but I think I agree
with the overall idea that instead of spawning off get_xyz_device() we
need to have some uniform approach to get to the device scaling
silicon - I hoped we could consider the hwmod database/what ever
replacing it to do that.

Regards,
Nishanth Menon
