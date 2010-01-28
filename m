From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH v4] omap: pm: Introducing enum for OPP types
Date: Thu, 28 Jan 2010 14:45:50 -0600
Message-ID: <4B61F77E.1020900@ti.com>
References: <1264711201-16922-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab0A1UqD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 15:46:03 -0500
In-Reply-To: <1264711201-16922-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Dasgupta, Romit" <romit@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Menon, Nishanth had written, on 01/28/2010 02:40 PM, the following:
> From: Romit Dasgupta <romit@ti.com>
> 
> Using omap_opp * to refer to domain types entails opp implementation
> into maintaining pointers outside the opp layer.
> 
> Since all we need is an identifier to a specific domain for
> query/operational purposes, we introduce enum for identifying OPP
> types instead of using opp layer's internal data structure pointer.
> 
> Currently, OMAP3 is the only silicon supporting the OPP layer, hence
> mpu_opps, l3_opps and dsp_opps are deprecated and replaced with
> OPP_MPU, OPP_L3 and OPP_DSP respectively.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: Tero Kristo <Tero.Kristo@nokia.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> 
> Signed-off-by: Romit Dasgupta <romit@ti.com>
arrgh.. forgot to add, anyways, for patchworks:
Acked-by: Nishanth Menon <nm@ti.com>

Tested also on SDP3430, SDP3630
> 
> ---
> Synopsys of changes:
> Rev 1: http://marc.info/?t=126330004800004&r=1&w=2
> Rev 2: http://marc.info/?t=126355341800003&r=1&w=2
> Rev 3: http://marc.info/?t=126408156100006&r=1&w=2
> Rev 4 specific changes Vs Rev 3:
>  * Multiple TI copyrights merged to a single one
>  * Couple of checkpatch warnings for multiple assignments fixed
>  * Cpufreq rates were reversed during initialization - fixed
>  * Rebased to pm-wip-opp branch as requested for rev 3.
> 
[...]
-- 
Regards,
Nishanth Menon
