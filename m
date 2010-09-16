From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
Date: Thu, 16 Sep 2010 10:16:00 -0700
Message-ID: <874odpbodr.fsf@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55587 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0IPRQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:16:05 -0400
Received: by pwi3 with SMTP id 3so476911pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 10:16:05 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 16 Sep 2010 16:10:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>From: Paul Walmsley <paul@pwsan.com>
>>>
>>>The OPP layer code should be independent of the PMIC,
>>>introduce the TWL/TPS-specific code out to its own file.
>
> Hello Kevin,
>
> I have been using this code for a while now. I really do not think wee
> need a separate file for implementing the vsel to voltage in (uV) and
> vice versa formulas. Today only voltage layer is interested in these
> conversions. Voltage layer has a structure that can be populated with
> the information required from the PMIC. We only need to add two more
> function pointers to this structure. This info can then be passed from
> the actual PMIC driver file. This will make it much more simpler for
> OMAP4 where we have different formulas between different revisions of
> PMIC. Also in the omap voltage code we will no longer have to hard
> code omap_twl_vsel_to_uv and omap_twl_uv_to_vsel. 

Feel free to post an RFC series for what you're proposing.  

IMHO, even the voltage layer should not care about these conversions.
The voltage layer should care about voltages, and the PMIC layer should
handle these conversions.  IOW, this stuff is best abstracted in the
PMIC code, or board- or SoC-specific hooks that can be registered with
the PMIC.

> So please consider dropping this patch from this series.

If you pick this up as part of your voltage series (or more likely as a
pre-requisite of your voltage series) we can surely drop it from this
series, at it doesn't really belong with the OPP series.

There are no upstream users of this yet, so dropping it is easy. :)

Kevin

