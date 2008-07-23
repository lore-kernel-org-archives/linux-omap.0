From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: OMAP3 SYS_OFF_MODE support
Date: Wed, 23 Jul 2008 16:42:35 +0300
Message-ID: <20080723134235.GB4543@codecarver.research.nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930111C4FD8A@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB022C16CEAF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49882 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYGWNsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 09:48:22 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022C16CEAF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Rangasamy, Devaraj" <dev@ti.com>
Cc: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jul 22, 2008 at 07:56:10PM +0530, ext Rangasamy, Devaraj wrote:
> 
> Currently sr_configure_vc() is the only dedicated API to configure Voltage controller parameter. But still SYSOFF specific configuration shall be moved to prcm init.
> 

Do you suggest to move all the voltage control initialization to prcm
init ?

Cheers,

Peter.

-- 
goa is a state of mind
