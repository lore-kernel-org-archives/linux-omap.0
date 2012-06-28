From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 0/7] OMAP System Control Module
Date: Thu, 28 Jun 2012 09:29:35 +0300
Message-ID: <CAGF5oy925c96QqwjqMEaUYDon+mSVGd2dtgnWrzwnrq0rN14Ng@mail.gmail.com>
References: <4FEB4B30.2040305@dev.rtsoft.ru>
	<20120628044343.GA2471@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53888 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932294Ab2F1G3h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 02:29:37 -0400
Received: by vbbfn1 with SMTP id fn1so1568670vbb.32
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 23:29:35 -0700 (PDT)
In-Reply-To: <20120628044343.GA2471@besouro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Konstantin,

On Thu, Jun 28, 2012 at 7:43 AM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Hello,
>
> On Wed, Jun 27, 2012 at 10:04:32PM +0400, Konstantin Baydarov wrote:
>> =A0Hello.
>>
>> This is a next version of series of patches(based on Eduardo Valenti=
n's patch set) adding a basic support for system control module, on OMA=
P4+ context. It is a working in progress.
>>
>> Main changes since previous patch set version:
>> - Bandgap and usb phy: drivers are now independent from control modu=
le driver, they use their own functions to acess scm registers.
>
> Well, I believe the idea of having them with their own io resource wa=
s to avoid
> children drivers accessing each other io areas. Is this now working?
>
>> - omap-control-core: resources aren't hardcoded, they are specified =
in dts file.
>> - omap-control-core: Control module is a built-in driver - added con=
trol module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
>> Probably, no configuration option is required!
>
> Why is this? I suppose the idea is to have the arch config selecting =
that flag.
>
>> - omap-control-core: Added early init call that ioremaps control mod=
ule IOMEM window, this allows access of SCM registers very early, for e=
xample from omap_type()
>
> Is this going to be reserved as well? if yes, how children are going =
to have
> their own access functions?
>
>> - omap-control-core: Removed device pointer from omap-control-core A=
PI arguments, becuase there can be only one instance control
>> module device.
>> - omap-control-core: removed omap_control_get, omap_control_readl, o=
map_control_writel
>
> fine, assuming the io split works...
>
>> - omap-control-core: added omap_control_status_read that is used ear=
ly in omap_type
>> - Bandgap and usb phy: Added private spinlocks for bandgap and usb d=
rivers.
>> - Bandgap: Check the type of bandgap dynamically in bandgap driver p=
robe function by reading
>> omap core control module revision register CONTROL_GEN_CORE_REVISION=
=2E
>
> this has some issue... I will post comment on the patch
>
>> - Bandgap and usb phy: Parent SCM platform device IOMEM resources is=
 used to get the base address of SCM window.
>
> Ohh.. Then what is the point of having them using their own io access=
 functions,
> nothing is again protected as you have only 1 io resource which is sh=
ared.
> And now is even worse because you have several io access function..
> I think this is moving backwards.
>
>> - Bandgap masks defines were moved to drivers/thermal/omap-bandgap.c=
=2E
>>
>> TODO list for bandgap driver:
>> - Reserve omap-control-core IOMEM window.
>> - Improve thermal zone definition for OMAP4
>> - Introduce the thermal zones for OMAP5
>
> Based on the review comments on RFC patch series, there are more
> things to be done.
>
> I have the O4 and O5 zone definition ready. But that work depends
> on generic CPU cooling patches. I have also looked the driver support
> for 4430. But the probing and io resource split is still based on
> previous design. I have also a patch which does the remapping in the
> bandgap driver. But really, for this to work it would require to have
> several entries in the reg property. And that is going to change from
> BG version to BG version.
>
> I can prepare some patches for this.

You can find the updated patches here:
git@gitorious.org:thermal-framework/thermal-framework.git
thermal_work/omap/bandgap_clean

But, as I said they are based on the generic cpu cooling. And the zone
registration follows the API as in linux-next.


--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
