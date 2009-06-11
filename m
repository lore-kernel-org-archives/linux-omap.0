From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] input: export gpio-keys driven switch status
	over gpiolib sysfs
Date: Wed, 10 Jun 2009 23:18:56 -0700
Message-ID: <20090611061855.GA8035@dtor-d630.eng.vmware.com>
References: <200906050039.40050.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:60768 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700AbZFKGTC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 02:19:02 -0400
Content-Disposition: inline
In-Reply-To: <200906050039.40050.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

Hi Janusz,

On Fri, Jun 05, 2009 at 12:39:39AM +0200, Janusz Krzysztofik wrote:
> This patch adds support for exporting status of GPIO switches, configured as
> gpio-keys buttons that generate events of type EV_SW, over standard gpiolib
> sysfs interface. That way, switch state can be easily accessed from userspace
> via a modern sysfs API in addition to traditional ioclt API, without the need
> for adding a new, usualy controversial entry to sysfs interface.
>

But this would make your application only work with devices using
gpio-keys driver and nothing else. I don't think it's a good idea.

Thanks.

-- 
Dmitry
