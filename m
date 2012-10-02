From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.6-rc7
Date: Tue, 02 Oct 2012 11:38:18 +0200
Message-ID: <506AB60A.5040901@compulab.co.il>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com> <50645A1D.5040108@compulab.co.il> <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36725 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab2JBJij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Oct 2012 05:38:39 -0400
In-Reply-To: <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/02/12 01:28, Paul Walmsley wrote:
> On Thu, 27 Sep 2012, Igor Grinberg wrote:
> 
>> Have you tried the nohlt boot parameter?
>> It looks like the wfi is killing those SoCs once you use EMAC.
> 
> Just tried with nohlt.  Didn't help on CM-T3517 with either NFS or MMC 
> root, nor with the 3517EVM with NFS root.  But I was able to get the 
> 3517EVM booting to userspace with MMC root.  Looks like the CM-T3517 board 
> file is missing the MMC setup code, so would guess that adding that back 
> in would help.

It never had the MMC in mainline...
I have some patches for that, based on v3.5,
but it should not be a problem to rebase those on a more recent git.
I will send them in a week or so, and if Tony will agree to merge them,
we will have the MMC on CM-T3517 mainline.


-- 
Regards,
Igor.
