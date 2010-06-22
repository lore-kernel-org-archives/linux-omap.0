From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 22 Jun 2010 11:06:38 +0200
Message-ID: <4C207D1E.7010508@nt.tu-darmstadt.de>
References: <4C1F9B80.9010708@gmail.com> <874ogw1dy2.fsf@deeprootsystems.com> <4C207A9C.7070309@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:56660 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758957Ab0FVJGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 05:06:37 -0400
In-Reply-To: <4C207A9C.7070309@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Peter Tseng <tsenpet09@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Han Wang <hw342@cornell.edu>

Mike Rapoport wrote:
> Kevin Hilman wrote:
>>  Peter Tseng<tsenpet09@gmail.com>  writes:
>>
>>>  I am seeing some discrepancies between the Overo (I believe I have a
>>>  Water) and the Beagleboard (I have a Rev. B5) when resuming after a
>>>  suspend to RAM.
>>
>>  Not that it is much comfort, but I have the same problem on Overo but
>>  don't see it on any other OMAP3 board.
>>
>>  I have yet to debug this particular issue further.
>
> I had the same issue on CM-T35 and when I've disabled CONFIG_CPU_IDLE in the
> kernel configuration the issue disappeared. Maybe it'll be of some help.

I have that disabled as well on my debug builds, but only in order not to have
1 char swallowed when the serial wakes the cpu... Still might be worth a
try on overo/summit

