From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] arm: omap3: am35x: Set proper powerdomain states
Date: Mon, 14 May 2012 11:15:46 -0700
Message-ID: <20120514181546.GA29952@animalcreek.com>
References: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45702 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab2ENSPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 14:15:47 -0400
Content-Disposition: inline
In-Reply-To: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 30, 2012 at 02:26:48PM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support the PWRSTS_ON
> state so create a new set of powerdomain structures
> that ensure that only the ON state is entered.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---

Ping?
