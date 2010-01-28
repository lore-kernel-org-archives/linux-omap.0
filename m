From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430
 SDP board file
Date: Thu, 28 Jan 2010 21:46:27 +0200
Message-ID: <20100128194627.GH6647@nokia.com>
References: <1262265782-17672-1-git-send-email-x0082077@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56639 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab0A1Ts4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 14:48:56 -0500
Content-Disposition: inline
In-Reply-To: <1262265782-17672-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Maulik Mankad <x0082077@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olof Johansson <olof@lixom.net>

On Thu, Dec 31, 2009 at 02:23:02PM +0100, ext Maulik Mankad wrote:
>ARM : OMAP4 : Add USB support to 4430 SDP board file
>
>This patch adds support for Mentor USB to 4430 SDP board
>file.
>
>It also defines the base address for HS USB OTG controller
>in OMAP4.
>
>Also updates platform specfic structure with base address
>and IRQ details.
>
>Signed-off-by: Maulik Mankad <x0082077@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Felipe Balbi <felipe.balbi@nokia.com>
>Cc: David Brownell <david-b@pacbell.net>
>Cc: Greg Kroah-Hartman <gregkh@suse.de>
>Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>Cc: Olof Johansson <olof@lixom.net>

I'm ok with this patch, want to hear from Tony.

Tony do you have any comment for this patch ? Will you take it or should 
Greg take it ? I believe it's better to come through your tree.

-- 
balbi
