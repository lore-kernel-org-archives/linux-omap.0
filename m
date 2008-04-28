From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP: EHCI: Wrong ehci init for 2430
Date: Mon, 28 Apr 2008 13:41:33 +0300
Message-ID: <20080428104133.GA23224@gandalf.research.nokia.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com> <1209370114-17007-2-git-send-email-jarkko.nikula@nokia.com> <20080428094833.GA4357@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30348 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYD1Kmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 06:42:45 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

btw, you have something weird in your mail settings, your patches always
come replying to the newest message in the list.

Your ehci patch came as a reply to a thread that has nothing to do with
2430.

the in-reply-to header should be empty for new messages and this is what
you got:

"In-Reply-To: <20080428094833.GA4357@gandalf.research.nokia.com>"

Could you fix this please? it breaks threading and also messes up the
archives.

-- 
	- Balbi
