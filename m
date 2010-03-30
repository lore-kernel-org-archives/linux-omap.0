From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 1/1] Registering sgx device and it's platform data
Date: Tue, 30 Mar 2010 12:49:02 +0300
Message-ID: <20100330094902.GG30597@nokia.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBF372@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1003300218100.14474@utopia.booyaka.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36711 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0C3Jtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 05:49:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1003300218100.14474@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "Agarwal, Preshit" <preshit.agarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Hi,

On Tue, Mar 30, 2010 at 10:49:19AM +0200, ext Paul Walmsley wrote:
>I would suggest that you name this function be named something more
>specific, such as omap_sgx_set_bus_tput(), since the SGX driver may also
>need to set other PM constraints later, such as wakeup latency
>constraints.

then it could just add the contraints to the same function instead of 
passing another pointer to driver ??

-- 
balbi
