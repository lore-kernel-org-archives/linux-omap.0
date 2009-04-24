From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 24 Apr 2009 09:46:28 +0300
Message-ID: <49F16044.6000603@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com> <87d4b4zc8e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48770 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbZDXGsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 02:48:19 -0400
In-Reply-To: <87d4b4zc8e.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>

ext Kevin Hilman wrote:
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
>> Re-sending this patch-set with some mailer issues resolved. They now apply cleanly
>> with a git-am/git-apply.
>>
>> Hi,
>>
>> This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
>> functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.
>>
>> The patches also make the Smartreflex driver independent of SRF by using the OMAP PM apis
>> instead of calls to SRF.
>>
>> Patches apply on top of the latest pm branch from Kevin's pm tree.
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 
> 
> Rajendra,
> 
> This series seems to boot on SDP and Beagle but I recetly tried on
> RX51 and it hangs in omap3_sr_init().
> 
> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
> PRM write to the PRM_VP1_VLIMITTO register:
> 
> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
> 					PRM_VP1_VLIMITTO_VDDMIN |
> 					PRM_VP1_VLIMITTO_TIMEOUT,
> 					OMAP3430_GR_MOD,
> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
> 
> 
> Should these min/max/timeout values be board specific?
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

It runs on rx51 if we set CONFIG_OMAP_PM_SRF instead of CONFIG_OMAP_PM_NOOP.

Should Smartreflex option be dependent or independent of the CONFIG_OMAP_PM_??? 
setting?

-roger
