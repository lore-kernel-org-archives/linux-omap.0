From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to test regulator driver?
Date: Mon, 9 Mar 2009 15:32:51 +0000
Message-ID: <20090309153250.GF13593@sirena.org.uk>
References: <2ee9e08d0903090802u72426757m8de7669800b5e94b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4550 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZCIPcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 11:32:54 -0400
Content-Disposition: inline
In-Reply-To: <2ee9e08d0903090802u72426757m8de7669800b5e94b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>

On Mon, Mar 09, 2009 at 08:32:55PM +0530, Anuj Aggarwal wrote:

> I want to test my regulator driver by writing a small kernel module.
> But I am a little confused as what should be passed as the first
> argument of regulator_get(). How would the kernel module know about
> the device pointer that needs to be passed to the _get function?

regulator_get() takes the struct device for the consumer as an argument
so it depends on what your consumer is.  For test purposes there's an
existing virtual consumer driver in the tree which should hopefully save
you having to write your own - it allows you to poke the settings from
sysfs.  drivers/regulator/virtual.c

Questions like this that aren't OMAP-specific should really be asked on
the relevant general list (in this case linux-kernel).
