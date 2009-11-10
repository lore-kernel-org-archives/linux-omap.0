From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Tue, 10 Nov 2009 12:12:36 +0200
Message-ID: <1257847956.2400.62.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1256724210-20581-1-git-send-email-hvaibhav@ti.com>
	 <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com>
	 <20091110010905.GR23952@atomide.com>
	 <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24325 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbZKJKN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:13:29 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-11-10 at 04:42 +0100, ext Hiremath, Vaibhav wrote:

> > 
> > It's best that we let Tomi queue up all the DSS2 related patches.
> [Hiremath, Vaibhav] I am ok with that.
> Let me update this patch with the latest kernel + DSS2 and re-submit it again.

Wait until DSS2 patches have been merged. I don't want the extra
complexity of board/panel patches, there's enough work with just the
half-megabyte DSS patches =).

 Tomi


