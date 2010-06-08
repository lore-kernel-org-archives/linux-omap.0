From: "Menon, Nishanth" <nm@ti.com>
Subject: opp layer query apis (was RE: omap3 pm: dependency between opp
 layer and cpufreq)
Date: Mon, 7 Jun 2010 23:15:21 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C013305AA83@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	<4BFE9D7E.8020602@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	<068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	<4BFFC622.90904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	<4BFFCB6B.50005@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>
	<1275065163.10319.5.camel@Nokia-N900-51-1>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
	<4C0338B6.6070803@gmail.com> <87sk552ddx.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03232DA8BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47372 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab0FHEP2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 00:15:28 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03232DA8BC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>

> -----Original Message-----
> From: Gopinath, Thara
> Sent: Friday, June 04, 2010 3:35 PM
> To: Kevin Hilman; Nishanth Menon
> Cc: Premi, Sanjeev; Menon, Nishanth; Koen Kooi; linux-


> Slightly off the topic but considering we are discussing opp layer here, I
> do not find API's
> that take the OPP type (OPP_MPU or OPP_L3) and voltage/frequency as
> parameters and returns back the associated frequency/voltage. I do not
> want to get the opp table entry every time I do this. Any chance of
> introducing this in the framework? I could send a patch for the same.
Am curios on the usage that combination of 
opp_find_freq_exact 
opp_find_freq_ceil  
opp_find_freq_floor

and opp_get_freq, opp_get_voltage is unable to cater to? Would be interested 
in seeing a patch for the same.

Regards,
Nishanth Menon
