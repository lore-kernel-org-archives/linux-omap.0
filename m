From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] arm: omap: let pm code always handle musb pm init
Date: Wed, 19 May 2010 14:43:13 +0300
Message-ID: <20100519114313.GD925@nokia.com>
References: <1274262018-32631-1-git-send-email-felipe.balbi@nokia.com>
 <1274262018-32631-2-git-send-email-felipe.balbi@nokia.com>
 <20100519112431.GM4265@besouro.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26578 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab0ESLpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 07:45:45 -0400
Content-Disposition: inline
In-Reply-To: <20100519112431.GM4265@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, May 19, 2010 at 01:24:31PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
>But IIRC, if we are coming back from OFF mode the autoidle bit will be 
>1 again.
>Which means, we still need this part to set it back to 0, otherwise, 
>the sw wa is screwed.

ok, I'll put it back here, or we could leave this to be done by the musb 
driver as, ideally, the same are shouldn't be ioremapped twice.

Kevin and Tony, do you have comments ?

-- 
balbi

DefectiveByDesign.org
