From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 15:29:58 -0600
Message-ID: <7B4574D56E4ADF438756313E9A172A872CB818B5@dlee01.ent.ti.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk>
	 <20090123011726.GG7172@atomide.com>
	 <20090123174249.GM26184@n2100.arm.linux.org.uk>
	 <20090123175401.GU7172@atomide.com>
	 <7B4574D56E4ADF438756313E9A172A872CABB868@dlee01.ent.ti.com>
	 <20090123191721.GW7172@atomide.com>
	 <b6ab3a160901231159xcfca2ebx3e7390e195bfa102@mail.gmail.com>
 <b6ab3a160901231202s1422a1b4o7507ecb058c3b309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbZAWVaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 16:30:05 -0500
In-Reply-To: <b6ab3a160901231202s1422a1b4o7507ecb058c3b309@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Alejandro Blanca G." <alex.blanca@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Alejandro Blanca G wrote on :

> First, I'm relatively new to the list and I'm still catching up with
> the etiquette to follow. So, if I break it somehow, please do let me
> know. It's not my intention to do so.

No problem, but you may wish to post under a new subject, although I guess we did go off the main topic :-)

> Now, I know that the OMAP16xx line of processors is composed (as far
> as I know) by the following:
>
> * 1610
> * 1611
> * 1621
> * 1623
>
> Does anybody know about the differences between them and / or about a
> document explaining them?

This is testing my memory now, but here is the way I recall it...

OMAP1610 was the original device and to be honest all these devices have the same peripheral features.

The OMAP1610 only has 16KB of internal RAM where as the other 3 (1611, 1621, 1623) all have 250KB of internal RAM.

The OMAP1611 was rev'ed and a few improvements were made. Now from the user point of view not too many changes were made (ie. no new peripherals that I recall) but there were some new registers added in some modules. The OMAP1611 became the OMAP1621 after it was revised. So if you have a OMAP1611 this was the original device.

The OMAP1623 is simply a OMAP1621 with stacked DDR memory.

Hope this helps.

Jon
