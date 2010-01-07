From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Thu, 07 Jan 2010 06:15:33 -0600
Message-ID: <4B45D065.6090800@gmail.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>	<1258004721-7315-2-git-send-email-nm@ti.com>	<1258004721-7315-3-git-send-email-nm@ti.com>	<1258004721-7315-4-git-send-email-nm@ti.com>	<1258004721-7315-5-git-send-email-nm@ti.com>	<1258004721-7315-6-git-send-email-nm@ti.com>	<87eimrx4em.fsf@deeprootsystems.com> <4B2CBA8A.5030905@ti.com> <87k4wfrm89.fsf@deeprootsystems.com> <4B4520CF.3000306@ti.com> <FCCFB4CDC6E5564B9182F639FC3560870300519667@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51120 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab0AGMPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 07:15:36 -0500
Received: by ywh6 with SMTP id 6so18377950ywh.4
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 04:15:35 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300519667@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "K, Ambresh" <ambresh@ti.com>

Sripathy, Vishwanath said the following on 01/07/2010 02:35 AM:
> Nishant,
> Have you tested your opp patches on 3630? Apparently opp changes in wip branch does not even boot on ZOOM3 board.
>   
The original series was tested and reported with results. I have'nt had 
a chance to try with the newer patch set. if there are patches, they are 
most welcome meanwhile. I will also try to do some on SDP3630 later today.

> Vishwa
>
>   
>> -----Original Message-----
>> From: Menon, Nishanth
>> Sent: Thursday, January 07, 2010 5:16 AM
>> To: Kevin Hilman
>> Cc: linux-omap; Cousson, Benoit; Chikkature Rajashekar, Madhusudhan; Paul
>> Walmsley; Dasgupta, Romit; Premi, Sanjeev; Shilimkar, Santosh; Aguirre, Sergio;
>> Gopinath, Thara; Sripathy, Vishwanath; K, Ambresh
>> Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
>>     
being a nitpick: could we avoid top-posting please?



Regards,
Nishanth Menon
