From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 	signature
Date: Thu, 30 Apr 2009 14:48:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B446FC72@dbde02.ent.ti.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
	 <20090429220804.2d130ceb.jhnikula@gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F96B@dbde02.ent.ti.com>
 <bd7b27490904300146p17cb127asf2013cc3f0840a26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58235 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762139AbZD3JSn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 05:18:43 -0400
In-Reply-To: <bd7b27490904300146p17cb127asf2013cc3f0840a26@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 Yor tow comments....I think I answered both.....Just a correction you comment itself.

> > You mean callback gets lch instead of chain_id as an argument?
You mean callback **** returns *** lch instead of chain_id as an argument?



		> > Two comments:
		> > "Now callback returns logical channel number and not chain_id. "
		> > You mean callback gets lch instead of chain_id as an argument?
		> Yes.


	Comment below.
	  
	


		> > Change also kernel-doc function comment for omap_request_dma_chain.
		> > I.e. those comment lines few lines before the function itself.
		> Yes would do that and send the patch.

________________________________
Regards
Santosh