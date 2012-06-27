From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] arm: omap3: am35x: Set proper powerdomain states
Date: Wed, 27 Jun 2012 14:51:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271451180.27496@utopia.booyaka.com>
References: <1337109255-14704-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42445 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab2F0Uvv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:51:51 -0400
In-Reply-To: <1337109255-14704-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support the PWRSTS_ON
> state so create a new set of powerdomain structures
> that ensure that only the ON state is entered.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Thanks, queued for 3.6.


- Paul
