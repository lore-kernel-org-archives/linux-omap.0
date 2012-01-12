From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS
 driver framework
Date: Thu, 12 Jan 2012 12:13:36 +0100
Message-ID: <CAORVsuWpKmaV9SUNEM9G=QLOb9ruKMPckeTWn3h8tkJVbQ6qJg@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123095120.GD25068@legolas.emea.dhcp.ti.com>
	<CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
	<20111123110448.GP25068@legolas.emea.dhcp.ti.com>
	<CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
	<87d3apvj26.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57127 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2ALLNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 06:13:37 -0500
Received: by vbmv11 with SMTP id v11so227199vbm.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 03:13:36 -0800 (PST)
In-Reply-To: <87d3apvj26.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

Kevin,

On Thu, Jan 12, 2012 at 1:52 AM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>>> if you already decide in runtime the correct initialization to call=
, why
>>> do you add ifdefs ?
>>
>> There is no #ifdef with CONFIG_POWER_AVS_OMAP_V[12], those options a=
re
>> used to compile or not the respective modules, cf.
>> driver/power/avs/Makefile.
>
> I'd suggest not even having user-selectable Kconfig for this.
>
> Just have a single Kconfig for POWER_AVS, then have
>
> config POWER_AVS_OMAP
> =A0 =A0 =A0 default PM && (ARCH_OMAP3 || ARCH_OMAP4)
>
> which compiles both versions of the OMAP IP.
Ok will do that.

Regards,
Jean

>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
