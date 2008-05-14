From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Resend] [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 15 May 2008 01:56:37 +0300
Message-ID: <20080514225636.GE1582@kedavra.cpe.vivax.com.br>
References: <C5EF98DB-8FEF-4AE0-A6BF-7D3FD1E41313@student.utwente.nl> <20080514224253.GE8928@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33186 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYENWzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:55:48 -0400
Content-Disposition: inline
In-Reply-To: <20080514224253.GE8928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org

On Wed, May 14, 2008 at 03:42:53PM -0700, Tony Lindgren wrote:
> * Koen Kooi <k.kooi@student.utwente.nl> [080513 01:20]:
> > This patch adds RTC support to the omap3 based beagleboard
> 
> I've pushed this after tweaking it manually again. It seems it was for
> some older kernel? Also you should check your mail client or smtp server
> to make sure patches don't wrap like this one is wrapped. It makes it
> hard to read and apply them.

maybe

$ git send-email --from "Koen Kooi <koen@openembedded.org>" --to linux-omap@vger.kernel.org file.patch

is enough. At least it doesn't wrap lines ;-)

just set

$ git config --global sendemail.smtpserver mail.openembedded.org

or whatever you use as smtp server.

if you need auth:

$ git config --global sendemail.user <username>

recent versions of git will interactively ask password.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
