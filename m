From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 1/4] Adding OMAP3 EVM support
Date: Fri, 25 Apr 2008 11:57:00 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A001922B8D@dbde01.ent.ti.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8F1B@dbde01.ent.ti.com> <87tzhqet3k.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48976 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758602AbYDYGfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 02:35:30 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87tzhqet3k.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@mvista.com]
> Sent: Friday, April 25, 2008 4:52 AM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org; discussion@beagleboard.org
> Subject: Re: [PATCH 1/4] Adding OMAP3 EVM support
> 
> Minor cosmetic suggestion...
> 
> As new files are added, can we please leave out full path to the file
> in the file header?  Not only is this unnecessary clutter, after a
> short amount of time, these are usually wrong as files get renamed,
> reorganized etc. and the paths rarely get updated.
> 
> It's best to just leave them out.
> 

Will consider this, but sometimes it is also better to have complete path, especially when I pass complete file to some one, I don't have to give path names separately, and they can just get this info from file header. But as you said, it has to be maintained properly :)

Do you think we should also consider removing the last line in this paragraph from the GPL header,

* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*

"either version 2 of the License, or (at your option) any later version."

Any later version will add GPL version 3 to the list. 

Any thoughts on this?

Regards,
Khasim
