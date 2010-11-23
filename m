From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 1/1] serial: omap-serial: Add support for kernel
 debugger
Date: Mon, 22 Nov 2010 16:10:41 -0800
Message-ID: <20101123001041.GA31259@kroah.com>
References: <1290468252-23539-1-git-send-email-cosmin.cojocar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43727 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369Ab0KWAK4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 19:10:56 -0500
Content-Disposition: inline
In-Reply-To: <1290468252-23539-1-git-send-email-cosmin.cojocar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cosmin Cojocar <cosmin.cojocar@gmail.com>
Cc: govindraj.raja@ti.com, manjugk@ti.com, khilman@deeprootsystems.com, tony@atomide.com, ben-linux@fluff.org, tklauser@distanz.ch, feng.tang@intel.com, alan@linux.intel.com, gregkh@suse.de, linux-omap@vger.kernel.org

On Tue, Nov 23, 2010 at 12:24:12AM +0100, Cosmin Cojocar wrote:
> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch also changes the initialization order because the
> kgdb will check at the very beginning, if there is a valid serial
> driver.

What was the difference between v2 and v3?
