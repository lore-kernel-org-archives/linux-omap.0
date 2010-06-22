From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 22 Jun 2010 11:55:56 +0300
Message-ID: <4C207A9C.7070309@compulab.co.il>
References: <4C1F9B80.9010708@gmail.com> <874ogw1dy2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:39176 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab0FVI5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 04:57:14 -0400
In-Reply-To: <874ogw1dy2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Tseng <tsenpet09@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Han Wang <hw342@cornell.edu>

Kevin Hilman wrote:
> Peter Tseng <tsenpet09@gmail.com> writes:
> 
>> I am seeing some discrepancies between the Overo (I believe I have a
>> Water) and the Beagleboard (I have a Rev. B5) when resuming after a
>> suspend to RAM.
> 
> Not that it is much comfort, but I have the same problem on Overo but
> don't see it on any other OMAP3 board.
> 
> I have yet to debug this particular issue further.

I had the same issue on CM-T35 and when I've disabled CONFIG_CPU_IDLE in the 
kernel configuration the issue disappeared. Maybe it'll be of some help.

> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
