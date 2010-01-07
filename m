From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Thu, 7 Jan 2010 08:18:43 -0600
Message-ID: <4B45ED43.3090607@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>	<1258004721-7315-2-git-send-email-nm@ti.com>	<1258004721-7315-3-git-send-email-nm@ti.com>	<1258004721-7315-4-git-send-email-nm@ti.com>	<1258004721-7315-5-git-send-email-nm@ti.com>	<1258004721-7315-6-git-send-email-nm@ti.com>	<87eimrx4em.fsf@deeprootsystems.com> <4B2CBA8A.5030905@ti.com> <87k4wfrm89.fsf@deeprootsystems.com> <4B4520CF.3000306@ti.com> <FCCFB4CDC6E5564B9182F639FC3560870300519667@dbde02.ent.ti.com> <4B45D065.6090800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280Ab0AGOSt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 09:18:49 -0500
In-Reply-To: <4B45D065.6090800@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "K, Ambresh" <ambresh@ti.com>

Nishanth Menon had written, on 01/07/2010 06:15 AM, the following:
> Sripathy, Vishwanath said the following on 01/07/2010 02:35 AM:
>> Nishant,
>> Have you tested your opp patches on 3630? Apparently opp changes in wip branch does not even boot on ZOOM3 board.
>>   
> The original series was tested and reported with results. I have'nt had 
> a chance to try with the newer patch set. if there are patches, they are 
> most welcome meanwhile. I will also try to do some on SDP3630 later today.
> 
[...]
http://pastebin.mozilla.org/695411 has the boot log on SDP3630! as 
reported previously clock framework is crashing, that is probably 
because the clock framework changes for 3630 corresponding to 3630 OPPs 
are not available.

the scripts and kernel details are part of
http://marc.info/?l=linux-omap&m=126282159227739&w=2

-- 
Regards,
Nishanth Menon
