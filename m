From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [RFC][PATCH 1/3] OMAP: DSS2: Do regulator stuff in dpi_init_display()
Date: Mon, 15 Mar 2010 11:57:55 +0200
Message-ID: <4B9E04A3.5050305@nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com> <1268645429.2417.14.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31080 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936033Ab0COJ63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 05:58:29 -0400
In-Reply-To: <1268645429.2417.14.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Valkeinen Tomi (Nokia-D/Helsinki) wrote:

> I don't think this is quite correct. dpi_init_display() will be called
> for all DPI displays, which means that it may be called more than once.
> dpi_init() is meant for global initializations.
> 
> Perhaps it would be best to have DPI compiled conditionally like
> SDI/DSI/RFBI.
> 
OK, will do it this way. Compiled conditionally makes sense.

-roger
