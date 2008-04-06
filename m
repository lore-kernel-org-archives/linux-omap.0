From: Brian Swetland <swetland@google.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 6 Apr 2008 15:25:08 -0700
Message-ID: <20080406222508.GA22955@bulgaria.corp.google.com>
References: <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com> <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com> <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com> <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com> <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com> <20080406132323.GA13033@bulgaria.corp.google.com> <47F8E66E.7080605@gmail.com> <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:59950 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbYDFWZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 18:25:36 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Georges Toth <georges.toth@gmail.com>, linux-omap@vger.kernel.org

[andrzej zaborowski <balrogg@gmail.com>]
> 
> Poky (pokylinux.org) and mamona both work pretty well for everyday use
> on the nseries.  Fortunately the userspace can partially ignore the
> charging issue because the RETU (now Betty) chip takes care of that in
> the hardware.  Charging / charger-cable / power-button / battery-life
> states are readable from /sys and /dev.

Ah, interesting.  When I was looking at the nokia patches to 2.6.21
it seemed like all power control happened from the userspace side
and the retu driver just allowed userspace to read/write the chip.
Does this patches beyond kernel-source-rx-34_2.6.21.0-osso71.diff.gz?

Where would I be looking in /sys or /dev for the charger/battery
state?

Thanks,

Brian
