From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCHv6 4/4] omap: iommu - create new api to set valid da range
Date: Tue, 14 Dec 2010 12:59:44 -0600
Message-ID: <AANLkTimNeDCH4jvP1QM785oNdua+GzwmtUA+OKzmO5aX@mail.gmail.com>
References: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
	<1292332047-8206-5-git-send-email-fernando.lugo@ti.com>
	<AANLkTin0eBk1tMDUJQQ6KuM6eOu1gu+JmwY-Nz0V+jw8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43289 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754299Ab0LNS7r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 13:59:47 -0500
In-Reply-To: <AANLkTin0eBk1tMDUJQQ6KuM6eOu1gu+JmwY-Nz0V+jw8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux@arm.linux.org.uk, h-kanigeri2@ti.com, felipe.contreras@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, "Guzman Lugo, Fernando" <x0095840@ti.com>

On Tue, Dec 14, 2010 at 9:08 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Dec 14, 2010 at 3:07 PM, Fernando Guzman Lugo
> <fernando.lugo@ti.com> wrote:
>> From: Guzman Lugo, Fernando <x0095840@ti.com>
>>
>> Some IOMMUs cannot use the whole 0x0 - 0xFFFFFFFF rage.
>> With this new API the valid range can be set.
>>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> I still don't see where this API is being used.

you can find it here:

http://marc.info/?l=linux-kernel&m=128805403014740&w=2

I will add it to the iommu migration set once all the dependencies are merged.

>
> Also, the point of using platform data was to add it to omap3_devices
> in omap-iommu.c, see[1]. I thought the platform data start/end would
> move to struct iommu, and iommu_set_da_range would change the
> start/end on struct iommu, but that would only be necessary if the
> platform data doesn't match that.

it is not clear for me. do you mean having default start/end in
platform data then when iommu_get is call pass them to start/end in
struct iommu and the new api change start/end in struct iommu?

Please let me know if that is correct.

Regards,
Fernando.

>
> If there's no sensible platform data default, then there's no point in
> using platform data, as the platform is not the limiting factor, but
> the DSP SW.
>
> [1] http://article.gmane.org/gmane.linux.kernel/1051268
>
> --
> Felipe Contreras
>
