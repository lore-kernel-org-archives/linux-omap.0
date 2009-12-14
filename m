From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Mon, 14 Dec 2009 18:39:57 +0200
Message-ID: <20091214163957.GD31829@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <20091214163324.GB31829@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59230 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZLNQkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:40:31 -0500
Content-Disposition: inline
In-Reply-To: <20091214163324.GB31829@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: ext Ajay Kumar Gupta <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, Anand Gadiyar <gadiyar@ti.com>

Hi,

On Mon, Dec 14, 2009 at 05:33:24PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>waaay too many exported functions already. Let's add some structure to
>pass functions pointers. I'll cook a patch adding suspend(), resume(),
>init() and friends and send tomorrow.
>
>Then your patch would add save_context() and restore_context().

unless you beat me on that :-)

-- 
balbi
