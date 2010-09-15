From: Tony Lindgren <tony@atomide.com>
Subject: Re: Using C++ style inheritance for board files
Date: Wed, 15 Sep 2010 10:48:48 -0700
Message-ID: <20100915174848.GB4174@atomide.com>
References: <66D2DD39-F82B-49BA-89FE-5993B2BF471E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57547 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0IORsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:48:51 -0400
Content-Disposition: inline
In-Reply-To: <66D2DD39-F82B-49BA-89FE-5993B2BF471E@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Elvis Dowson <elvis.dowson@mac.com> [100914 12:58]:
> 
> For example, I have a platform that is based on board-overo.c. Instead copy pasting and creating a new board-overo-variant.c, if the core structures were defined as classes, I could potentially inherit from the base overo board definition, and add my own specific modifications. 

Uhh, let's leave c++ out of this..

You can already easily share most of the code among boards
by having multiple MACHINE entries in the board-*.c file.
See board-n8x0.c for example.

Then you can spend some effort to create common platform
device init code, see gpmc-*.c and hsmmc.c for examples.

Regards,

Tony
