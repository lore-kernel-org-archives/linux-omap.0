From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add required
 debugfs interfaces
Date: Wed, 18 May 2011 03:50:22 -0500
Message-ID: <BANLkTik1C2USfMTr21LFh_K28NbgSOxvbA@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-3-git-send-email-nm@ti.com>
 <878vu4z9cu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59253 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754806Ab1ERIun convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:50:43 -0400
Received: by mail-wy0-f170.google.com with SMTP id 34so1113713wyb.29
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:50:42 -0700 (PDT)
In-Reply-To: <878vu4z9cu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 03:44, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Kevin's patch:
>> OMAP3+: voltage: remove unneeded debugfs interface
>>
>> removed ability to check the voltages in the domains.
>> This puts a crunch on validation we can do, hence we
>> re-introduce them back in
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> NAK.
>
> I don't want any OMAP specific debugfs interface for this. =A0The vol=
tage
> domains will be represented by regulators (when I finish this
> cleanup/restructure), and we will use the regulator framework for
> interfacing to the voltages.
>
> If you need a temporary debugfs interface for this, then I suggest yo=
u
> revert my original patch in your internal tree, or keep $SUBJECT patc=
h
> as an internal patch.

Regulators are the right approach. dropping this patch.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
