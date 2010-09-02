From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 2 Sep 2010 03:17:56 -0500
Message-ID: <4C7F5DB4.70306@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0IBISB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 04:18:01 -0400
In-Reply-To: <20100902094327.31a96174@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Thomas Petazzoni had written, on 09/02/2010 02:43 AM, the following:
> Hello,
> 
> On Wed, 01 Sep 2010 15:51:40 -0700
> Kevin Hilman <khilman@deeprootsystems.com> wrote:
> 
>> Looking closer at this, keeping track of a list of devices and
>> constraints is what the regulator framework does as well.  
>>
>> Before we get too far down this path, we need to start working with
>> Thomas Petazzoni to better understand how we can use the regulator
>> framework for much of the management levels of the voltage layer.
> 
> Yes, as discussed on IRC with Kevin, I think that some of this voltage
> layer mechanisms would benefit from using the existing kernel regulator
> framework.
> 
> The regulator framework already keeps tracks of consumers (in your
> patch set called "vdd users"), and for each consumer, keeps track of
> the requested voltage. The maximum requested voltage is then applied to
> the regulator. It seems to fit quite well some of the mechanisms you're
> introducing in this patch set.

Just brainstorming -> if we use the regulator framework - there are 
potential benefits - agreed. BUT, consider the cpuidle path -> currently 
we disable SR while hitting off/ret for class3, this is done in irq 
locked context while the regulator framework uses locks by itself - we 
would probably have to evolve an entirely different mechanism to handle 
this.

SR by itself can easily be represented I believe and my thoughts  when i 
initialy looked at that option had been:
a) latency overheads
b) flexibility we achieve vs complexity in s/w implementation
c) lock handling - esp impact on omap_sram_idle paths..

-- 
Regards,
Nishanth Menon

PS:personally though concept of latency additions when scaling voltages, 
disabling SR etc should be a parameter in userspace governor decisions 
(the fact that cpuidle and cpufreq are independent statemachine is not 
my personal fav either). But this is a larger topic of discussion not 
pertinent to this thread..

