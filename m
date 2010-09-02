From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 02 Sep 2010 06:16:26 -0500
Message-ID: <6adbfbc898429de0777fa39ff2ec6fdd@secure211.sgcpanel.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf> <4C7F5DB4.70306@ti.com> <38353bada7f16740e8008e6d3f2748bd@secure211.sgcpanel.com> <4C7F799D.8020207@ti.com> <2aa29e22fb1502b14ac7850a12e68e5b@secure211.sgcpanel.com> <4C7F7F38.1050709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48802 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0IBLQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 07:16:31 -0400
In-Reply-To: <4C7F7F38.1050709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Thu, 2 Sep 2010 05:40:56 -0500, Nishanth Menon <nm@ti.com> wrote:
> Felipe Balbi had written, on 09/02/2010 05:28 AM, the following:
>> Hi,
>> 
>> On Thu, 2 Sep 2010 05:17:01 -0500, Nishanth Menon <nm@ti.com> wrote:
>>> note - if we allow unlock of irqs at this point, we cannot predictably

>>> progress down the logic.
>> 
>> spin_unlock() would not re-enable IRQs, would it ? Isn't it so that
>> spin_unlock_irq() would be the one re-enabling IRQ ?
>> 
> oopss.. my bad.. if we were to do regulator based implementation of 
> voltage framework, looking closer at the code, driver/regulator/core.c 
> -> rdev->mutex is held for set_voltage, set_mode and all entry functions

> for regulator operations -> this would be the only concern i have.. I 
> may be barking up the wrong tree here, but i think if i read 
> Documentation/mutex-design.txt right, "contexts such as tasklets and 
> timers" and "mutexes may not be used in hardware or software interrupt" 
> means to me dont do this in irq locked context such as the sitn in 
> omap_sram_idle?

true, some re-work would have to be done if you want to use requlator
framework.

-- 
balbi
