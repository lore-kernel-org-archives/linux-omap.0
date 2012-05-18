From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: tps65910
Date: Fri, 18 May 2012 09:12:06 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98DDAD@DBDE01.ent.ti.com>
References: <CAP3+TErDaA9Sdf2yf9asu1kNqRowTAga6NksVW9j4c+fzi9v=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57515 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967112Ab2ERJML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 05:12:11 -0400
In-Reply-To: <CAP3+TErDaA9Sdf2yf9asu1kNqRowTAga6NksVW9j4c+fzi9v=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxim Podbereznyy <lisarden@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Maxim,

On Fri, May 18, 2012 at 13:23:53, Maxim Podbereznyy wrote:
> Hey guys!
> 
> Who knows how to initialize and use tps65910 driver in linux with
> am3517? I designed a board using the Craneboard schematic as a
> reference. Mistral provides the kernel 2.6.32 and it works fine. Now
> I'm porting the BSP to kernel 3.0.17 and don't know how to implement
> voltage regulator features with the tps65910 driver (it appeared in
> kernel 3.0 ) under kernel 3.0 environment.
> 
> I'm watching board-omap3beagle.c as a reference and tps65910.c driver
> and can't find any correlation. Any suggestions?
> 
> Any help is appreciated!

AM335X EVM (support not yet in mainline) works with tps65910, in case AM335X
release helps you, 

git://arago-project.org/git/projects/linux-am33x.git v3.2_AM335xPSP_04.06.00.07

Regards
Afzal
