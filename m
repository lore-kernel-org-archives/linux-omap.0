From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: DSPBRIDGE: Tie Resource accounting to Process Context
Date: Wed, 12 Aug 2009 13:49:47 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060068B6D46E@dlee01.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZHLSty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 14:49:54 -0400
In-Reply-To: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>

Hi,

Hi Ameya,

Patches look good only one comment,

In PROC_Attach:
===============
- Why don't use only one hProcessor? If hProcessor already exists then just return the pointer. We can use a counter to know when to release the handle. Or maybe we can do the Detach only in bridge_release but that might imply to leave the exported detach function "empty" or do not export detach function but it would impact the dspbridge users. That would avoid the use of a list to keep track of the handles.

Let me try your patch with this modification and I'll let you know.

/Ernesto

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Monday, August 10, 2009 8:22 PM
> To: linux-omap@vger.kernel.org
> Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando;
> Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
> Subject: DSPBRIDGE: Tie Resource accounting to Process Context
> 
> This patch series uses filp->private data to get access to a
> PROCESS_CONTEXT
> pointer which in turn tracks all the resources tied to an open file
> handle.
> 
> This will help in:
> 1. Implementation of clean resource accounting.
> 2. Proper resource cleanup irrespective of multithreading or multitasking
> in
>    user space applications.
> 

