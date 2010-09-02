From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 02 Sep 2010 05:00:50 -0500
Message-ID: <38353bada7f16740e8008e6d3f2748bd@secure211.sgcpanel.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf> <4C7F5DB4.70306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55825 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0IBKBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 06:01:01 -0400
In-Reply-To: <4C7F5DB4.70306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, 2 Sep 2010 03:17:56 -0500, Nishanth Menon <nm@ti.com> wrote:
> Just brainstorming -> if we use the regulator framework - there are 
> potential benefits - agreed. BUT, consider the cpuidle path -> currently

> we disable SR while hitting off/ret for class3, this is done in irq 
> locked context while the regulator framework uses locks by itself - we 

wouldn't it be enough to:

spin_unlock(&sr_lock);
call_whatever_regulator_api();
spin_lock(&sr_lock);

[...]

spin_unlock_irqrestore(&sr_lock, flags);

??

otherwise we will have yet another OMAP-only API to maintain.

-- 
balbi
