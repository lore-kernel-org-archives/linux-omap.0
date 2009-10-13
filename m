From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Discussion: OMAP: PM: opp table handling
Date: Wed, 14 Oct 2009 01:53:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA0D3D0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760822AbZJMUYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 16:24:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Nataraju, Kiran" <knataraju@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Giles, Rick" <rgiles@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>


Proposals for OPP table handling for OMAP34xx/35xx/36xx/44xx

Thanks to all the community members for taking time for this discussion. 
This will aid upsteaming of 35xx/36xx/44xx in coming future.

Attendees: Kevin Hilman, Paul, Nishant M, Santosh, Madhu, Benoit, Rajendra, Benoit, Vikram

Problem Statement:
	OMAP34xx has certain opp requirements (3420/3430/3440)
	OMAP35xx reuses the opp's from 34xx
	OMAP36xx has a totally new set of opps
	OMAP44xx has a totally new set of opps

Solution: 
	Align on a common approach to take for the Opp table definitions.

Define Separate Tables for each family as follows:
Step 1: Go with this approach:
	3420(65nm) 		: new arrays [defer for now]
	3430/35xx(65nm) 	: new arrays **
	3440(65nm) 		: new arrays [defer for now]
	3630(45nm) 		: new arrays
	Omap4(45nm)		: new arrays

	* new arrays = (mpu, dsp, l3)
	** Check this valid flag. Kevin can take this base on comments
		http://marc.info/?l=linux-omap&m=125512448216071&w=2
		between 3430/35xx, opp's can be managed with a flag and same table re-used
		35xx has requirement for 720Mhz opp

Step 2:
Kevin suggestion:
Define accessor APIs get the OPPs
Check Users of accessor API
	DVFS
	constraints
	sysfs debug
	Define accessor api's eg:
		index = get_opp(VDD1_OPP1);
		num = get_max_opp(VDD1);
		set_opp(index);

Step 3: 
	Paul suggestion:
	VSEL values in opp table should be in terms of voltage
	Non TWL IC's need this

Step4:
	Paul suggestion:
	VDD1 VDD2 dependencies for different chips
	Inter-connect load predictor is absent on omap3 and hence VDD1-vdd2 dependency
	OMAP4
		interconnect loading can be measured from registers
		Multi-cores dependency

Step 5:
	Paul suggestion:
	Board files adding OPPs, Modifying OPPs
	Eg: Pendora passing its own opp 


Regards,
Vikram 
