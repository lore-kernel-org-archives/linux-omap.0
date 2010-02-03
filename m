From: Tony Lindgren <tony@atomide.com>
Subject: Re: dspbridge patches in patchwork
Date: Wed, 3 Feb 2010 09:08:16 -0800
Message-ID: <20100203170815.GC22747@atomide.com>
References: <1265199981.2740.8.camel@sanganak>
 <20100203170314.GB22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50078 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563Ab0BCRHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 12:07:51 -0500
Content-Disposition: inline
In-Reply-To: <20100203170314.GB22747@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: omar.ramirez@ti.com, linux-omap@vger.kernel.org, Contreras Felipe <felipe.contreras@nokia.com>, nm@ti.com

* Tony Lindgren <tony@atomide.com> [100203 09:00]:
> * Ameya Palande <ameya.palande@nokia.com> [100203 04:24]:
> > Hi Tony,
> > 
> > As more and more people start contributing to dspbridge code (as we have
> > seen recently) tracking patches is becoming difficult.
> > 
> > Is it possible to delegate dspbridge patches to dspbridge maintainer in
> > patchwork?
> 
> Yeh sure. All it takes is registering a user for pw.k.o and selecting
> linux-omap as the project.
> 
> Then I need send an email with the pw.k.o user name to allow changing
> the omap patch status.

If you just want to follow the dspbridge patches, you can configure
your pwclient:

$ cat /home/tmlind/.pwclientrc 
# Sample .pwclientrc file for the linux-omap project,
# running on patchwork.kernel.org.
#
# Save this file to ~/.pwclientrc
#
[base]
url: http://patchwork.kernel.org/xmlrpc/
project: linux-omap

# Adding authentication parameters will allow you to use the 'update'
# command on patches that you are allowed to edit.
# [auth]
# username: yourusername
# password: yourpassword

Then to see all the dspbridge patches, just do:

$ pwclient search dspbridge
ID    State        Name
--    -----        ----
6777  Not Applicable [1/3] DSPBRIDGE Offmode and DVFS Support
6778  Not Applicable [2/3] DSPBRIDGE DVFS and OFF mode support with OPP2
6814  Not Applicable [1/1] DSPBRIDGE Fix condition statement for Global Flush
...

Regards,

Tony
