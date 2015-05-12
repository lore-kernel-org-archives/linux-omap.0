From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Tue, 12 May 2015 14:21:47 -0500
Message-ID: <555252CB.3010208@ti.com>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org> <55524D20.2050203@ti.com> <20150512191905.GY3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbbELTWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2015 15:22:13 -0400
In-Reply-To: <20150512191905.GY3066@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Michael Welling <mwelling@ieee.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/12/2015 02:19 PM, Mark Brown wrote:
> On Tue, May 12, 2015 at 01:57:36PM -0500, Nishanth Menon wrote:
>> On 05/12/2015 12:38 PM, Michael Welling wrote:
>>> GPIO chip select patch series appears to have broken the native chip select
>>> support. This patch pulls the manual native chip select toggling out of
>>> the transfer_one routine and adds a set_cs routine.
> 
> Please remember to delete unneeded context from your replies, the reader
> shouldn't need to page through the entire patch to find out you reviewed
> it.

Will do so. Anyways, I did test it to be accurate - have'nt reviewed it.


-- 
Regards,
Nishanth Menon
