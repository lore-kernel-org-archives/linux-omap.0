From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Fri, 15 Aug 2008 16:32:46 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D6E0060@dlee01.ent.ti.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
	 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
	 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
	 <20080815112112.GB16840@atomide.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
	 <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com>
 <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:52336 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141AbYHOVdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 17:33:00 -0400
In-Reply-To: <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>

Hi Felipe,


> > What TI has offered so far is code, and the comments have been on this
> > code. You seem to want maintainers to understand that this is code
> > that works "today", but I don't think the code can be tested right now
> > since the tools (CE/Link) are not available out in the open.
>
> Err, I got confused about the CE/Link, I meant the xdctools... or
> whatever is needed to compile DSP nodes. AFAIK the DSP compiler is not
> enough.


Yes, today certain components (such as codec-engine, dspbios) do require the xdctools. There are a couple components that don't (such as DSPLink) but these will probably use xdctools in the future too.

Anyway, just in case you have not seen there is a TI DSP Wiki page now for all things DSP and a lot of the tools/software are available through here. However, not all is source. See below:

TI DSP Wiki
http://tiexpressdsp.com/

With regard to the xdctools, TI has kicked off an open-source project to for these. Details can be found here:

http://wiki.eclipse.org/DSDP/RTSC

It may seem a bit messy right now (with bridge, link, etc), but hopefully all of this will get straighten out as we progress.

Cheers
Jon
