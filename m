From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Fri, 20 Jul 2012 17:24:03 -0500
Message-ID: <5009DA83.4040909@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2GTWYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 18:24:12 -0400
In-Reply-To: <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 07/16/2012 01:38 PM, Paul Walmsley wrote:
> Hi Jon,
>=20
> On Mon, 16 Jul 2012, Jon Hunter wrote:
>=20
>> Yes I see that makes sense. However, patch #7 has already changed th=
e
>> mapping of the flags. I had intended that patch #7 and #8 would be
>> applied together. However, I could see that patch #7 can be taken ju=
st
>> to eliminate using the SW_SLEEP state. So basically, what I am sayin=
g is
>> does patch #7 have any value without #8?
>=20
> Certainly not as much value as it had before.  But my understanding, =
which=20
> is possibly incorrect, matches what you wrote in patch #7's descripti=
on:
>=20
> "For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is=
=20
> equivalent to SW_WKUP. The only difference between HW_AUTO and SW_SLE=
EP=20
> for OMAP4 devices is that the PRM_IRQSTATUS_MPU.TRANSITION_ST interru=
pt=20
> status is set in case of SW_SLEEP transition, and not set in case of=20
> HW_AUTO transition."
>=20
> We don't use that PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt bit.  So =
if=20
> SW_SLEEP and HW_AUTO really have identical meanings otherwise, then I=
=20
> suppose we might as well use the one that does what we need with no=20
> extraneous side-effects?  My recollection from a conversation with Be=
no=EEt=20
> a few months ago was that this was his view as well.
>=20
>> That's fine with me. We can always workaround such issues by adding =
flags.
>>
>> I can give this a try this week and let you know how it goes.
>=20
> Okay, great.  No rush on my account.

I have been testing this today and is working well for OMAP4. However, =
I
noticed that this is not working for OMAP3. The problem for OMAP3 is
that we don't have hwmod support for the debugss in OMAP3 and so the
flag CLKDM_CAN_ENABLE_AUTO is shutting down the EMU PD on boot. To be
honest it is clear to me now that PMU support on OMAP3 needs some work
as it is dependent on the ETM driver as highlighted by Will.

So I think that this patch will work but I need to create a hwmod for
OMAP3's debugss. Are you able to generate this or just Benoit? I could
probably create something by hand but did not know if we could
auto-generate.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
