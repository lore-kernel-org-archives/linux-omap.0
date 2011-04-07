From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP2+: SR Layer Cleanup.
Date: Thu, 7 Apr 2011 11:55:35 +0530
Message-ID: <BANLkTimOv63R2c5EjsgR1MbMq0vK8dh2NA@mail.gmail.com>
References: <1301378352-29269-1-git-send-email-shweta.gulati@ti.com>
	<87mxk3iecz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:40482 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674Ab1DGGZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Apr 2011 02:25:37 -0400
Received: by mail-bw0-f44.google.com with SMTP id 13so2729155bwz.17
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 23:25:35 -0700 (PDT)
In-Reply-To: <87mxk3iecz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Apr 6, 2011 at 9:03 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Shweta,
>
> Shweta Gulati <shweta.gulati@ti.com> writes:
>
>> As a part of Voltage Layer Cleanup Patches,
>> submitted by Kevin Hilman, Voltage domain
>> Information is removed from hwmod,
>> So the patch removes 'vdd_name' info from omap_hwmod
>> and adds that info into dev_attr as SR code uses vdd_name
>> to get voltagedomain sructure info.
>>
>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>
> Thanks for this. =A0It looks good.
>
>> ---
>> It apllies over Voltage Layer Cleanup Patch by
>> Kevin Hilman:
>> =A0https://patchwork.kernel.org/patch/657421/
>
> Can you rebase on top of my pm-wip/voltdm_a branch? =A0It currently
> doesn't apply there because the some of the voltage domain names were
> changed, e.g. mpu -> mpu_iva, wkup -> wakeup.
Ok, I will do.
Thanks.
> Thanks,
>
> Kevin
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
