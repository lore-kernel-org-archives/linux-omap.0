From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Help with interfacing to OMAP2+: McBSP
Date: Wed, 19 Oct 2011 09:54:50 +0300
Message-ID: <20111019095450.edaefce276ef5c03c454cfbb@bitmer.com>
References: <51A4F524D105AA4C93787F33E2C90E62EE5B4D@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:54265 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab1JSGzT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 02:55:19 -0400
In-Reply-To: <51A4F524D105AA4C93787F33E2C90E62EE5B4D@greysvr02.GreyInnovation.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Chiha <paul.chiha@greyinnovation.com>
Cc: linux-omap@vger.kernel.org

On Wed, 19 Oct 2011 17:18:54 +1100
"Paul Chiha" <paul.chiha@greyinnovation.com> wrote:

> Hi,
> 
> I need to write a simple driver sends and receives packets over McBSP3
> on the DM3730 processor, and was wondering if anyone has already this.
> I understand that the functions in arch/arm/plat-omap/mcbsp.c need to be
> used, and so I would like to see an example driver which uses them that
> I can base mine one.
> Any help would be appreciated.
> 
Only public user at the moment is sound/soc/omap/omap-mcbsp.c.

-- 
Jarkko
