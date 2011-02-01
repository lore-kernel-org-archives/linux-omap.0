From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 09/13] OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
Date: Tue, 1 Feb 2011 19:17:53 +0530
Message-ID: <AANLkTiksT=eQ3w9P80HeXtSp2wzFjmX5Gb7YFZNjQkcp@mail.gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-10-git-send-email-kishon@ti.com>
	<4D47FA37.1060001@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58804 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752927Ab1BANr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 08:47:59 -0500
Received: by mail-iw0-f169.google.com with SMTP id 40so7745150iwn.0
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 05:47:56 -0800 (PST)
In-Reply-To: <4D47FA37.1060001@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On Tue, Feb 1, 2011 at 5:49 PM, Peter Ujfalusi <peter.ujfalusi@nokia.co=
m> wrote:
> Hi,
>
> On 01/31/2011 04:50 PM, ext Kishon Vijay Abraham I wrote:
>> McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
>> to be disabled before starting the sidetone. Also SYSCONFIG
>> register has to be set with smart idle or no idle depending on the
>> dma op mode (threshold or element sync). For doing these operations
>> dynamically at runtime, omap_device APIs are used to modify SYSCONFI=
G register.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> =A0arch/arm/plat-omap/mcbsp.c | =A0 66 +++++++++++++++++++++++------=
--------------
>> =A01 files changed, 35 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
>
> ...
>
>> =A0static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbs=
p)
>> =A0{
>> + =A0 =A0 struct omap_device *od;
>> +
>> + =A0 =A0 od =3D find_omap_device_by_dev(mcbsp->dev);
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Enable wakup behavior, smart idle and all wakeups
>> =A0 =A0 =A0 =A0* REVISIT: some wakeups may be unnecessary
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 u16 syscon;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon =3D MCBSP_READ(mcbsp, SYSCON);
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) =
| CLOCKACTIVITY(0x03));
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_MO=
DE_THRESHOLD) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscon |=3D (ENAWAKEUP | S=
IDLEMODE(0x02) |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 CLOCKACTIVITY(0x02));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mcbsp->dma_op_mode !=3D MCBSP_DMA_MODE=
_THRESHOLD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_noidle(od);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>
> Would it make sense to call here:
> omap_device_smartidle(od); ?

   I dint explicitly call it because, pm_runtime_get_sync() would have
already set the
   SYSCONFIG to smartidle.

> What happens, if we configure McBSP to element mode, play a sample,
> configure it to threshold?
> I think we should explicitly as for smartidle, when we suppose to be =
in
> smartidle.

   In either ways, this function will be called when we do a request
and this function
   (omap34xx_mcbsp_request) gets called after pm_runtime_get_sync. So b=
ased on
   the value of dma_op_mode at the time of request, either noidle or
smartidle will
   be set.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, WAKEU=
PEN, XRDYEN | RRDYEN);
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscon |=3D SIDLEMODE(0x01=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> =A0static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
>> =A0{
>> + =A0 =A0 struct omap_device *od;
>> +
>> + =A0 =A0 od =3D find_omap_device_by_dev(mcbsp->dev);
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Disable wakup behavior, smart idle and all wakeups
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 u16 syscon;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon =3D MCBSP_READ(mcbsp, SYSCON);
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) =
| CLOCKACTIVITY(0x03));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* HW bug workaround - If no_idle mode=
 is taken, we need to
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* go to smart_idle before going to al=
ways_idle, or the
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* device will not hit retention anymo=
re.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon |=3D SIDLEMODE(0x02);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 syscon &=3D ~(SIDLEMODE(0x03));
>> - =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> -
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_device_default_idle(od);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
>
> Hrm, it would be better to do it as the comment said:
> omap_device_smartidle(od);
> omap_device_forceidle(od);

  hmmm..ok. Will make this change in the next version.

>
> BTW: what is the default_idle in case of McBSP?

   The default idle mode for McBSP is SMARTIDLE. It is actually
   based on SWSUP flag. If it is set, the idlemode is NOIDLE else
   SMARTIDLE. Pls have a look at my patch that implements
   omap_device_default_idle() [1].

   [1]http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134

>
> --
> P=E9ter
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
