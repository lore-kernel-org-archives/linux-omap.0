From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 02 Sep 2010 05:28:47 -0500
Message-ID: <2aa29e22fb1502b14ac7850a12e68e5b@secure211.sgcpanel.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf> <4C7F5DB4.70306@ti.com> <38353bada7f16740e8008e6d3f2748bd@secure211.sgcpanel.com> <4C7F799D.8020207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45044 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0IBK24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 06:28:56 -0400
In-Reply-To: <4C7F799D.8020207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Thu, 2 Sep 2010 05:17:01 -0500, Nishanth Menon <nm@ti.com> wrote:
> note - if we allow unlock of irqs at this point, we cannot predictably 
> progress down the logic.

spin_unlock() would not re-enable IRQs, would it ? Isn't it so that
spin_unlock_irq() would be the one re-enabling IRQ ?

-- 
balbi
