From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: n810 internal mmc boot
Date: Wed, 25 Mar 2009 13:26:10 +0200
Message-ID: <20090325132610.a859abaf.jarkko.nikula@nokia.com>
References: <20090228012717.GB4366@swansys>
	<20090321193355.GG20072@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53857 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbZCYLZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 07:25:51 -0400
In-Reply-To: <20090321193355.GG20072@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext green <greenfreedom10@gmail.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

On Sat, 21 Mar 2009 20:33:55 +0100
ext green <greenfreedom10@gmail.com> wrote:

> green wrote at 2009-02-27 18:27 -0700:
> > Any news on booting n810 from internal mmc?  It hasn't worked for a
> > while.
> 
> The kernel detects the external mmc fine (for root=), but not the
> internal... I'm just wondering whether any progress is being made or
> expected.  Sorry if I'm being a nuisance.
> 
So it has been working at least sometime in linux-omap? I've been using
prototype version of N810 with slightly different internal mmc and I
have never noticed that internal mmc is working in linux-omap.

I thought that reason was that different HW since I didn't find any
remarkable differences between our 2.6.21 kernel and linux-omap when I
diffed it shortly long time ago. At least powering sequencing looked
very much the same in board file.


Jarkko
