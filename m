From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 14:15:02 +0300 (EEST)
Message-ID: <20080820.141502.262218398.Hiroshi.DOYU@nokia.com>
References: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<20080820100444.GA22373@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22635 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYHTLQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 07:16:05 -0400
In-Reply-To: <20080820100444.GA22373@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: daniel.stone@nokia.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, eduardo.valentin@indt.org.br

From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 13:04:44 +0300

> On Wed, Aug 20, 2008 at 12:51:51PM +0300, ext Hiroshi DOYU wrote:
> > +	struct clk **childs;
> > +	int n_childs;
> 
> This is a ridiculously pedantic nitpick, but s/childs/children/. :)

Right. I will take an english language class again....

       Hiroshi DOYU

