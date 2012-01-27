From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 14:32:43 +0100
Message-ID: <CAMsRxf++i+CQZvPvGaHD_zOT-B-P0R-UyLTVRiA-XdFYUiY_JA@mail.gmail.com>
References: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54193 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2A0Nco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 08:32:44 -0500
Received: by vbbfc26 with SMTP id fc26so1229859vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 05:32:43 -0800 (PST)
In-Reply-To: <20120127132826.GD2347@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2012/1/27 Will Deacon <will.deacon@arm.com>:
> Mans,
>
> On Fri, Jan 27, 2012 at 12:56:35PM +0000, M=C3=A5ns Rullg=C3=A5rd wro=
te:
>> Will Deacon <will.deacon@arm.com> writes:
>> > Did this lead anywhere in the end? It seems as though Ming Lei has=
 a working
>> > setup but Stephane is unable to replicate it, despite applying the=
 necessary
>> > patches and trying an updated bootloader.
>>
>> With the patches listed above plus the one in [1], I get PMU interru=
pts.
>> However, unless I restrict the profiled process to one CPU
>> (taskset 1 perf record ...), I get a panic in armpmu_event_update() =
with
>> the 'event' argument being null when called from armv7pmu_handle_irq=
().
>>
>> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>
Ok, I am recompiling the kernel for this one line fix:

--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D {
       .prcm_partition   =3D OMAP4430_PRM_PARTITION,
       .cm_inst          =3D OMAP4430_PRM_EMU_CM_INST,
       .clkdm_offs       =3D OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-       .flags            =3D CLKDM_CAN_HWSUP,
+       .flags            =3D CLKDM_CAN_SWSUP,
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
