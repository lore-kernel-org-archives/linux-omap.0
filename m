From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Beagle PM hangs
Date: Fri, 30 Jan 2009 16:03:23 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
 <87zlhbqtrv.fsf@deeprootsystems.com> <87skn3qq6x.fsf@deeprootsystems.com>
 <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52011 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbZA3WDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 17:03:31 -0500
In-Reply-To: <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


> > Just a thought, do you still see these problems when using the CPUfreq
> > performance governor instead of the ondemand governor?
> >
> > It could be pointing to some bugs in the switching of operating
> > points.
>
> Speaking of operating points, is there a reason why cpufreq only goes
> to 550MHz? It's disappointing that omap3 gets marketed with "600MHz",
> but that TI won't let it run at that speed with their cpufreq drivers.

Run at that speed on your board if you like.  You can run even faster if you like but at some point you will start to have odd failures.

The 600MHz overdrive operating point is such that if you use it all the time your part life may be reduced.  If you use the stock ondemand governor with no kind of policy teak you'll be at that OPP a lot.

Percentage operation in overdrive figures into expected life of a given part. For reference code we just make the needed use cases explicitly ask for overdrive.  This way usage is predictable in well defined mobile product.

Depending on the chip you buy things are rated differently.  This rating requires part sorting which typically pushes the price up some.  Any step you add into fabrication of high volumes increases cost.

Regards,
Richard W.

