From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Working with Linux-Omap GIT Tree
Date: Thu, 4 Sep 2008 14:04:10 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A86A45@dlee02.ent.ti.com>
References: <1f11a5490809041150y69023b30ub166cc34615744b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54560 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYIDTES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 15:04:18 -0400
In-Reply-To: <1f11a5490809041150y69023b30ub166cc34615744b5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

And one more thing...

If you have a driver which was previously including a header like this:

#include <arch/arm/clock.h>

You have to change it to:

#include <mach/clock.h>

To point to the new location.

Regards,
Sergio

-----Original Message-----
From: Ashwin Bihari [mailto:abihari@gmail.com] 
Sent: Thursday, September 04, 2008 1:51 PM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: Re: Working with Linux-Omap GIT Tree

On Thu, Sep 4, 2008 at 2:44 PM, Aguirre Rodriguez, Sergio Alberto
<saaguirre@ti.com> wrote:
> Hi Ashwin,
>
> The folder you're looking for has been moved to arch/arm/plat-omap/include/
>
> This has to have the same contents you had in that version + the following changes to them.
>
> Hope this helped you.
>
> Regards,
> Sergio

Hi Sergio,

Thanks for the pointer on the move. I should've spent more time poking
around the trees I guess. Sorry for the noise..

~ Ashwin

