From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: + drivers-video-omap2-dss-rfbic-port-to-new-kfifo-api.patch
 added to -mm tree
Date: Tue, 05 Jan 2010 13:26:47 +0200
Message-ID: <1262690807.32628.11.camel@tubuntu.research.nokia.com>
References: <201001042307.o04N7KaB023799@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21043 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0AEL1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 06:27:35 -0500
In-Reply-To: <201001042307.o04N7KaB023799@imap1.linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "stefani@seibold.net" <stefani@seibold.net>, "greg@kroah.com" <greg@kroah.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-01-05 at 00:07 +0100, ext akpm@linux-foundation.org wrote:
> The patch titled
>      drivers/video/omap2/dss/rfbi.c: port to new kfifo API
> has been added to the -mm tree.  Its filename is
>      drivers-video-omap2-dss-rfbic-port-to-new-kfifo-api.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: drivers/video/omap2/dss/rfbi.c: port to new kfifo API
> From: Stefani Seibold <stefani@seibold.net>
> 
> Port drivers/video/omap2/dss/rfbi.c to the new kfifo API.  This should be
> the last one.
> 
> Signed-off-by: Stefani Seibold <stefani@seibold.net>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/video/omap2/dss/rfbi.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

This patch is not correct, rfbi.c doesn't compile. I made a patch for
this yesterday, and if it's ok for everyone, I'll put that patch into my
dss tree, and this patch can be discarded.

 Tomi


