From: <roman.tereshonkov@nokia.com>
Subject: RE: [PATCH] 	Support for OMAP3 SDTI (Serial Debug Trace Interface).
Date: Mon, 31 Mar 2008 16:25:13 +0300
Message-ID: <96D01537CAEBF940B0144E7F8E88229C03833138@esebe102.NOE.Nokia.com>
References: <1206452858-29570-1-git-send-email-roman.tereshonkov@nokia.com> <3B6D69C3A9EBCA4BA5DA60D91302742903D3BA03@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20032 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYCaN3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 09:29:07 -0400
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903D3BA03@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com, linux-omap@vger.kernel.org


Hi,

No, I do not use it in conjunction with semi-hosting on Lauterbach. 
Only for kernel logging.
I am not sure if OMAP3 SDTI can be used for serial port replacement.
In comparison with OMAP1 and OMAP2 there is no RX port in OMAP3 SDTI
anymore.
The only port left is TX for sending data from OMAP3.

Roman Tereshonkov






-----Original Message-----
From: ext Woodruff, Richard [mailto:r-woodruff2@ti.com] 
Sent: 25 March, 2008 16:17
To: Tereshonkov Roman (Nokia-D/Helsinki); linux-omap@vger.kernel.org
Subject: RE: [PATCH] Support for OMAP3 SDTI (Serial Debug Trace
Interface).

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> owner@vger.kernel.org] On Behalf Of Roman Tereshonkov
> Sent: Tuesday, March 25, 2008 8:48 AM
> To: linux-omap@vger.kernel.org
> Cc: Roman Tereshonkov
> Subject: [PATCH] Support for OMAP3 SDTI (Serial Debug Trace
Interface).

By chance do you use any of this in conjunction with semi-hosting on
Lauterbach?  If so is there a wiki or other with some basic information?
Having a jtag console is kind of handy if you don't have a real serial
port.

Regards,
Richard W.
 

