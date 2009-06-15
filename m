From: Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [patch] Fix brf6510 cleanup code
Date: Mon, 15 Jun 2009 11:38:47 +0300
Message-ID: <4A360897.1050701@nokia.com>
References: <20090530180721.75203sfsqbpppfi8@lidskialf.net> <20090608210333.11295srly8te8xog@lidskialf.net> <20090615080242.GD4474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21000 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZFOIi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 04:38:58 -0400
In-Reply-To: <20090615080242.GD4474@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Andrew,

ext Tony Lindgren wrote:
> * Andrew de Quincey <adq_dvb@lidskialf.net> [090608 13:04]:
>> The brf6150 driver is missing several necessary cleanup steps to allow  
>> module unloading. Add them.

Yes. This driver was used as compiled in driver and seems to be missing 
cleanups.

As you may have noticed this brf6150 driver has been replaced by hci_h4p 
drier in later tablets and the easiest way to maintain support for Nokia 
770 bluetooth would be to make sure that also brf6150 works with the 
current driver. AFAIK it should work with quite little modifications. 
The settings negotiation is a little bit different.

> 
> I've removed the brf6150 from linux-omap as this should get merged into
> the mainline kernel via bt list.
> 
> Ville & Andrew, can you guys please coordinate on the bt list to get
> the driver merged in? I believe there were some changes needed for
> passing the hw address as a module option and for loading the firmware
> or something..

Is 2.6.30 booting in Nokia 770/N800/N810? If so then I guess this should 
be quite easy task.

-- 
Ville
