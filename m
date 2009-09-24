From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap3: ehci: remove chargepump hack
Date: Thu, 24 Sep 2009 15:10:51 +0300
Message-ID: <20090924121051.GG4186@nokia.com>
References: <1253794017-25552-1-git-send-email-gadiyar@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22612 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZIXMLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 08:11:13 -0400
Content-Disposition: inline
In-Reply-To: <1253794017-25552-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anand Gadiyar <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 24, 2009 at 02:06:57PM +0200, ext Anand Gadiyar wrote:
> omap3: ehci: remove chargepump hack
> 
> This hack was for a very early development board that is no longer
> in use. Remove it. No board should require it.

do we have anyone using it besides development boards ?

-- 
balbi
