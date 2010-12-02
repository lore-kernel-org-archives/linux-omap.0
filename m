From: David Sin <davidsin@ti.com>
Subject: Re: [RFC v2 0/8] TI DMM-TILER driver
Date: Thu, 2 Dec 2010 07:52:57 -0600
Message-ID: <20101202135254.GE22875@lba0869738>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
 <AANLkTi=39XEC9ie=bAapymAtx6k+ej49N5B1+_gfRhmE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48703 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757551Ab0LBNkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 08:40:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=39XEC9ie=bAapymAtx6k+ej49N5B1+_gfRhmE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 01, 2010 at 12:17:22PM +0530, Varadarajan, Charulatha wrote:
> On Wed, Dec 1, 2010 at 01:28, David Sin <davidsin@ti.com> wrote:
> 
> The dmm driver is making use of omap_hwmod fw. But I could not see a patch
> to add  dmm hwmod data to omap4 hwmod base in this series. Is this patch series
> tested?
yes -- this code has been tested against the omap_hwmod fw.  I will send 
out a patch in the next rev.  Thanks for your comments.
-- 
David Sin
