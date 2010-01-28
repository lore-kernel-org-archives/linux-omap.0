From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 1/2] ARM : OMAP: MUSB : Pass board specific data
 using a structure
Date: Thu, 28 Jan 2010 21:46:58 +0200
Message-ID: <20100128194658.GI6647@nokia.com>
References: <1262265756-17634-1-git-send-email-x0082077@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39253 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0A1TtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 14:49:21 -0500
Content-Disposition: inline
In-Reply-To: <1262265756-17634-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Maulik Mankad <x0082077@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Gupta Ajay Kumar <ajay.gupta@ti.com>

On Thu, Dec 31, 2009 at 02:22:36PM +0100, ext Maulik Mankad wrote:
>ARM : OMAP: MUSB :Pass board specific data from board file
>
>This patch proposes to pass board specific data for MUSB
>(like interface_type, mode etc) from board file by defining
>board specific structure.
>
>Each board file can define this structure based on
>its requirement and pass this information to the
>driver.
>
>Signed-off-by: Maulik Mankad <x0082077@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Felipe Balbi <felipe.balbi@nokia.com>
>Cc: David Brownell <david-b@pacbell.net>
>Cc: Greg Kroah-Hartman <gregkh@suse.de>
>Cc: Gupta Ajay Kumar <ajay.gupta@ti.com>

Fine by me, Tony, any comments ?

-- 
balbi
