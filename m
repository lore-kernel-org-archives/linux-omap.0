From: David Wagner <david.wagner@free-electrons.com>
Subject: Re: [PATCH 1/2] Macro for getting the BASEADDRESS field in omap's
 gpmc configuration
Date: Thu, 11 Aug 2011 17:00:23 +0200
Message-ID: <4E43EE87.8050900@free-electrons.com>
References: <1312470395-19672-1-git-send-email-david.wagner@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53379 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1HKO5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 10:57:30 -0400
In-Reply-To: <1312470395-19672-1-git-send-email-david.wagner@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Wagner <david.wagner@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

	Hi,

On 08/04/2011 05:06 PM, David Wagner wrote:
> BASEADDRESS is located in the 6 lower bits of the CONFIG7 register.
> See OMAP 35x Technical Reference Manual, p. 1169.
> 
> Signed-off-by: David Wagner <david.wagner@free-electrons.com>

I'm not subscribed to the linux-omap mailing list but I saw no answer on
this patch and the next one in the archive.

The second one (replaces bitwise operations in board-igep0020.c with
GPMC macros) partly depends on the first one, but can be split so that
part of it can be standalone. Should I do so and resubmit or is it ok
like this ?

Regards,
David.

-- 
David Wagner, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
