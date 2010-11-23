From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 1/1] serial: omap-serial: Add support for kernel
 debugger
Date: Mon, 22 Nov 2010 16:26:09 -0800
Message-ID: <20101123002609.GA7353@kroah.com>
References: <1290468252-23539-1-git-send-email-cosmin.cojocar@gmail.com>
 <20101123001041.GA31259@kroah.com>
 <4CEB086B.6040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45920 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab0KWA0e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 19:26:34 -0500
Content-Disposition: inline
In-Reply-To: <4CEB086B.6040409@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cosmin Cojocar <cosmin.cojocar@gmail.com>
Cc: govindraj.raja@ti.com, manjugk@ti.com, khilman@deeprootsystems.com, tony@atomide.com, ben-linux@fluff.org, tklauser@distanz.ch, feng.tang@intel.com, alan@linux.intel.com, gregkh@suse.de, linux-omap@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Nov 23, 2010 at 01:18:51AM +0100, Cosmin Cojocar wrote:
> The v2 was a intermediate testing version which I sent it out by
> mistake. The difference between the tow is that the v2 uses a
> infinite loop to wait for data to be transfered out form buffer, whereas
> the v3 relies on existing wait_form_xmitr function.

In the future, please say this in the comment section in the patch (i.e.
below the "---" line.)

thanks,

greg k-h
