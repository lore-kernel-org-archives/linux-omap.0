From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH 2/3] OMAP: DSS2: Prevent recursive Panel
 Enable/Disable calls from SDI
Date: Mon, 15 Mar 2010 11:52:46 +0200
Message-ID: <1268646766.2417.37.camel@tubuntu.research.nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
	 <1268645546.2417.15.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51440 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935701Ab0COJw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 05:52:58 -0400
In-Reply-To: <1268645546.2417.15.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-03-15 at 10:32 +0100, Tomi Valkeinen wrote:
> On Fri, 2010-03-12 at 16:27 +0100, Quadros Roger (Nokia-D/Helsinki)
> wrote:
> > From: Roger Quadros <roger.quadros@nokia.com>
> > 
> > Panel enable/disable is now done inside display manager,
> > so don't need to do it again.
> > 
> 
> This looks correct, thanks.

Actually, I take my word back =).

This patch leaves the err3 label there, and you remove it in the next
patch. It should be removed in this same patch.

And the patch description is a bit strange. I think it should be
something like:

"Panel enable/disable is now done via the panel driver, so we should not
call the panel driver again."

 Tomi


