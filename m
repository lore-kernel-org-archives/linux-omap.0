From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Asoc with TWL4030 on overo
Date: Thu, 18 Mar 2010 15:42:57 +0000
Message-ID: <20100318154256.GA17200@sirena.org.uk>
References: <201003180823.55248.rok@kanardia.eu> <20100318164002.70c710a3.jhnikula@gmail.com> <201003181552.00203.rok@kanardia.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46128 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0CRPnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 11:43:00 -0400
Content-Disposition: inline
In-Reply-To: <201003181552.00203.rok@kanardia.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rok Markovi?? <rok@kanardia.eu>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

On Thu, Mar 18, 2010 at 03:52:00PM +0100, Rok Markovi?? wrote:

> Yes muted sound was the culprit. :), why does not kernel enable sound by 
> default and why are there so many mixer controls.

It is difficult for the kernel to know what a sensible configuration is
for all hardware at all times - much embedded hardware has a wide range
of possible audio configurations, and often the choice depends not only
on the hardware but also which sounds are being played.
