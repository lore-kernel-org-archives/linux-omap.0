From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv4 00/15] voltdm cleanup + auto-ret / auto-off support
Date: Wed, 30 Nov 2011 11:06:35 +0100
Message-ID: <CAORVsuUQPJPYehWVBMpgNF8HTk1zsDqVLV1RoY6StydX=FnoJw@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39277 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab1K3KGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 05:06:37 -0500
Received: by vcbfk14 with SMTP id fk14so209663vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 02:06:36 -0800 (PST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

Hi Tero,

On Fri, Nov 25, 2011 at 4:49 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hi,
>
> Changes compared to previous version:
>
> - merged most of the voltagedomain cleanup fixes to patch 2
> - moved pmic latencies to omap_voltdm_pmic struct
> - renamed omap_lp_params to omap2_oscillator as it only contains
> =A0osc info now
> - major changes to usecount support (patch 11+, needed for auto-ret)
> =A0* added usecounts to voltagedomain / powerdomain
> =A0* fixed usecount tracking so that the numbers are sane now
> =A0* changed behavior of some usecounting sources that they do not
> =A0 =A0update the counts (autoidle support)
> - added auto-ret / auto-off support, based on fixed usecounting
> =A0* smartreflex disabled / enabled
> =A0* auto-ret / auto-off enabled based on target state
> - some other minor tweaks I have probably forgotten to mention
Ok after review, except the remarks I sent as replies to the specific p=
atches.

Minor remark: the patch set could be split into the following features:
- oscillator startup/shutdown time,
- Beagle OPP6,
- usecount code,
- auto ret/off.

> Tested on omap3 beagle:
> - voltages for vdd1 and vdd2 change when entering idle
Nice!

> - both suspend and dynamic idle tested
> - tested that voltages reach target levels for both ret / off
>
> Tested on omap4 blaze with custom kernel
> - this requires a few additional patches missing from this set as
> =A0omap4 PM support is still not merged
> - will post missing patches once possible from upstream point of view
> - voltages for vdd1 and vdd3 change when entering idle
>
> Applies on top of Kevin's for_3.2/voltage-cleanup branch.
>
> I have a bunch of additional debugging patches I have used in verific=
ation
> of this set if anybody is interested.
>
> TBD:
> - no pmic off support yet
> =A0* no pmic script support
> =A0* vdd1 / vdd2 only reach 0.6V, not 0V in off
> =A0* oscillator is not turned off
That would be nice to have. IIRC last time I checked the existing T2
scripts where not working on Beagle due to a different wiring of the
PMIC<->OMAP signals.

>
> -Tero

Regards,
Jean

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
