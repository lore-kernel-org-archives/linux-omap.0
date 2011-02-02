From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Query]Using vcxio regulator on 4430sdp
Date: Wed, 2 Feb 2011 10:56:15 +0000
Message-ID: <20110202105615.GC9810@sirena.org.uk>
References: <4D494045.1020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:32879 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1BBK4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 05:56:17 -0500
Content-Disposition: inline
In-Reply-To: <4D494045.1020901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 02, 2011 at 05:00:13PM +0530, archit taneja wrote:

> How can I implement regulator_enable/disable calls in my driver for a  
> consumer of vcxio without disturbing the mpu and iva etc consumers which  
> don't use regulator api to enable/disable the regulator at all.

Set the regulator always_on in its constraints.
