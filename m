From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Thu, 2 Sep 2010 09:43:27 +0200
Message-ID: <20100902094327.31a96174@surf>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:57476 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab0IBHvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 03:51:32 -0400
In-Reply-To: <87eiddgjr7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Hello,

On Wed, 01 Sep 2010 15:51:40 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Looking closer at this, keeping track of a list of devices and
> constraints is what the regulator framework does as well.  
> 
> Before we get too far down this path, we need to start working with
> Thomas Petazzoni to better understand how we can use the regulator
> framework for much of the management levels of the voltage layer.

Yes, as discussed on IRC with Kevin, I think that some of this voltage
layer mechanisms would benefit from using the existing kernel regulator
framework.

The regulator framework already keeps tracks of consumers (in your
patch set called "vdd users"), and for each consumer, keeps track of
the requested voltage. The maximum requested voltage is then applied to
the regulator. It seems to fit quite well some of the mechanisms you're
introducing in this patch set.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
