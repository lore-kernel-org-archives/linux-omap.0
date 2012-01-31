From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/7] ARM: OMAP2+: hwmod/timer: first set of cleanups for
 3.4
Date: Tue, 31 Jan 2012 01:14:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201310111300.10061@utopia.booyaka.com>
References: <20120130101251.10450.58423.stgit@dusk> <87ty3cpyuk.fsf@ti.com> <4F27A0B0.50704@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60420 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab2AaIOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 03:14:54 -0500
In-Reply-To: <4F27A0B0.50704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Tue, 31 Jan 2012, Cousson, Benoit wrote:

> Thanks to the L3 log error:
> [    0.838439] L3 custom error: MASTER:DucatiM3 TARGET:GPMC
> 
> I guess that I understand why I was not releasing the hardreset at boot time
> before:-)
> 
> DSP and CortexM3 cannot be released from reset until someone loaded a firmware
> in memory. Otherwise they will start executing some random instructions that
> in this case are trying to access an area that is not accessible.
> 
> We have to let the driver handle the hardreset because it is mainly used for
> processors.

Currently we're not asserting hardreset in the hwmod code during _reset().  
I had that patch in the series at some point, but took it out before 
posting it.  So maybe that might resolve this particular issue.  Also 
sounds like we should make sure that we keep the processor IPs in 
hardreset until some driver explicitly releases it; we'll need to make 
sure the code does that too.


- Paul
