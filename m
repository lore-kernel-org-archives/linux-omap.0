From: Paul Walmsley <paul@pwsan.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Tue, 3 Jul 2012 21:06:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207032104320.6760@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com> <alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com> <CAMQu2gztSV1qtgea9rL46orqTFR-vQkES5fen4GCqEfBh046-Q@mail.gmail.com> <4FF1766A.5060605@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33639 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab2GDDGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 23:06:04 -0400
In-Reply-To: <4FF1766A.5060605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

On Mon, 2 Jul 2012, Shubhrajyoti wrote:

> I do not have access to a 3530 Beagle

I'm afraid that's what you'll need.

I suggest you try reproducing the problem on a configuration similar to 
mine: a 3530ES3 Beagle running v3.5-rc4.


- Paul
