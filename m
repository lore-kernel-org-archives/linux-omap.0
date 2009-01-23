From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 16:54:16 -0600
Message-ID: <7B4574D56E4ADF438756313E9A172A872CB819E0@dlee01.ent.ti.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk>
	 <20090123011726.GG7172@atomide.com>
	 <20090123174249.GM26184@n2100.arm.linux.org.uk>
	 <20090123175401.GU7172@atomide.com>
	 <7B4574D56E4ADF438756313E9A172A872CABB868@dlee01.ent.ti.com>
	 <20090123191721.GW7172@atomide.com>
	 <b6ab3a160901231159xcfca2ebx3e7390e195bfa102@mail.gmail.com>
	 <b6ab3a160901231202s1422a1b4o7507ecb058c3b309@mail.gmail.com>
	 <7B4574D56E4ADF438756313E9A172A872CB818B5@dlee01.ent.ti.com>
	 <b6ab3a160901231347n67feec99va7731328671925fe@mail.gmail.com>
 <b6ab3a160901231348m4d1808a9ycd3519058324aafb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38927 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757789AbZAWWyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 17:54:25 -0500
In-Reply-To: <b6ab3a160901231348m4d1808a9ycd3519058324aafb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Alejandro Blanca G." <alex.blanca@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Alejandro Blanca G wrote on :

> So, if I understood correctly, the internal RAM you're talking about
> is the one coming with the OMAP itself. Additionally, you could count
> on the RAM coming with the board and the internal caches available,
> right? Or are you using the term "internal RAM" to refer to the L1 /
> L2 caches (if any)?

Yes, the internal RAM being the SRAM inside the OMAP. The SRAM is accessible by the ARM and DSP cores. This is should not be confused with the ARM or DSP caches, these are separate.

> Regarding peripheral support, then this means that the driver support
> should be basically the same among revisions, right?

Yes they will be pretty much the same. Actually, here is what I recommend...

The initial OMAP5912 devices were in fact OMAP1611 and the production version is a OMAP1621. If you refer to the OMAP5912 documentation on the below webpage, you will see in some documents that it states "not available on XOMAP5912 or POMAP5912" in certain areas. The XOMAP5912 and POMAP5912 are indeed OMAP1611 devices. So if OMAP1611 is what you have then anything that says "not available on XOMAP5912 or POMAP5912" will also be not available on the OMAP1611.

You will find some examples of this in the OMAP5912 Subsystem User Guide:
http://focus.ti.com/dsp/docs/dspsupporttechdocsc.tsp?sectionId=3&tabId=409&familyId=325&abstractName=spru749b

All OMAP5912 documentation can be found here: http://focus.ti.com/docs/prod/folders/print/omap5912.html

Jon
