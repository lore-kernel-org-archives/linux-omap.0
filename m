From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: Beagle: revision detection
Date: Wed, 18 Aug 2010 09:34:27 +0300
Message-ID: <20100818093427.10c8770a.jhnikula@gmail.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
	<20100817084824.8f869e8e.jhnikula@gmail.com>
	<AANLkTinrJTCvorB0+LrFXmiChhZbbJZXeovmU3uWXYFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34089 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0HRGeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 02:34:14 -0400
Received: by eyg5 with SMTP id 5so85218eyg.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 23:34:13 -0700 (PDT)
In-Reply-To: <AANLkTinrJTCvorB0+LrFXmiChhZbbJZXeovmU3uWXYFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Tue, 17 Aug 2010 15:10:35 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> Do you have any preference if the gpio allocation fails?  Right now
> it'll just halts, we could just return as Cx based board.. Which would
> be the route the current kernel would take without this patch...
> 
I think current code printing the error and letting the revision to be
zero or undefined is just fine. It's easier to debug if we let system
to continue booting instead of halting at early stage as there is no
any fatal risk with mmc gpio_wp if we cannot determine the revision.


-- 
Jarkko
