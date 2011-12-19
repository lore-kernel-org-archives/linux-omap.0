From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Mon, 19 Dec 2011 09:56:50 +0000
Message-ID: <CABS+qY1XqhhyXJUPoiueAM5Exf_QoXcnN9_9sKK72nmi5k-GqA@mail.gmail.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	<1323444589-19940-5-git-send-email-t-kristo@ti.com>
	<20111219083331.GW11800@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58107 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501Ab1LSJ4w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 04:56:52 -0500
Received: by mail-vx0-f171.google.com with SMTP id fl11so5039777vcb.16
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 01:56:51 -0800 (PST)
In-Reply-To: <20111219083331.GW11800@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 19 December 2011 08:33, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Tero,
>
> On Fri, Dec 09, 2011 at 05:29:48PM +0200, Tero Kristo wrote:
>> This is needed for SMPS regulators, which use the OMAP voltage
>> processor for voltage get/set functions instead of the normal I2C
>> channel. For this purpose, regulator_init_data->driver_data contents
>> are expanded, it is now a struct which contains function pointers
>> for the set/get voltage operations, a data pointer for these, and
>> the previously used features bitmask.
> Looks better than the previous versions. For the MFD part:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
>
> Liam, I assume this is going through your tree ?
>
> Cheers,
> Samuel.
>

Mark will take it for this kernel release (if he's OK with it).

Thanks

Liam
