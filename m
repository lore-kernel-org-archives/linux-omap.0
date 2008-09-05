From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/2] OMAP2xxx EAC build fix and sparse cleanup
Date: Fri, 5 Sep 2008 11:28:46 -0700
Message-ID: <20080905182846.GT24202@atomide.com>
References: <20080905073522.7741.76584.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52183 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIES2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 14:28:55 -0400
Content-Disposition: inline
In-Reply-To: <20080905073522.7741.76584.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, jarkko.nikula@nokia.com

* Paul Walmsley <paul@pwsan.com> [080905 01:29]:
> This series fixes a build bug in the EAC driver after the recent IO address
> changes, and resolves some sparse warnings.  Updated to use ioremap(). 
> Thanks to Jarkko Nikula <jarkko.nikula@nokia.com> for testing and Russell
> King <linux@arm.linux.org.uk> for review.
> 
> Compile-tested only.

Pushing both today.

Tony
