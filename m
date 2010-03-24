From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH FIX] OMAP: DSS: Fix for kernel crash during reboot
Date: Wed, 24 Mar 2010 10:23:12 +0200
Message-ID: <1269418992.3032.34.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268372062-5269-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33752 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0CXIXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 04:23:31 -0400
In-Reply-To: <1268372062-5269-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Fri, 2010-03-12 at 06:34 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Kernel crash is observed when you include DSS, respctive drivers and issue
> "reboot" command.
> Added return from function omapdss_dpi_display_disable, if interface is already
> disabled.

This should actually be fixed in the panel driver. It should never call
the core DSS functions in the wrong way, in this case calling disable
twice.

 Tomi


