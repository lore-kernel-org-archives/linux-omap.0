From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 0/2] dspbridge: reorganize initialization and probe
Date: Wed, 09 Jun 2010 11:49:02 +0300
Message-ID: <1276073342.10359.0.camel@chotu>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
	 <AANLkTil4gAHQcEdAedxamD9mi5d-0CxGLqP_8h9vY77j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23516 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab0FIItQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 04:49:16 -0400
In-Reply-To: <AANLkTil4gAHQcEdAedxamD9mi5d-0CxGLqP_8h9vY77j@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

On Wed, 2010-06-09 at 09:25 +0200, ext Felipe Contreras wrote:
> On Wed, Jun 9, 2010 at 3:48 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> > Split the functions to have cleaner error handling paths, this
> > will aslo cover a case where bridge initialization has failed but
> > device entry is still available which leads to unknown behavior.
> 
> Great, I was wondering why this was not the case.
> 
> Now that you are on this, do you know if there's something missing in
> order to automatically load the module when somebody tries to open
> /dev/DspBridge?

I thought /dev/DspBridge will only appear if you load the module ;)

Cheers,
Ameya.



