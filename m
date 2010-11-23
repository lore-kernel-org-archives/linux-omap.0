From: Cosmin Cojocar <cosmin.cojocar@gmail.com>
Subject: Re: [PATCH v3 1/1] serial: omap-serial: Add support for kernel debugger
Date: Tue, 23 Nov 2010 01:18:51 +0100
Message-ID: <4CEB086B.6040409@gmail.com>
References: <1290468252-23539-1-git-send-email-cosmin.cojocar@gmail.com> <20101123001041.GA31259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47263 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab0KWAS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 19:18:56 -0500
Received: by eye27 with SMTP id 27so4374777eye.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 16:18:55 -0800 (PST)
In-Reply-To: <20101123001041.GA31259@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: govindraj.raja@ti.com, manjugk@ti.com, khilman@deeprootsystems.com, tony@atomide.com, ben-linux@fluff.org, tklauser@distanz.ch, feng.tang@intel.com, alan@linux.intel.com, gregkh@suse.de, linux-omap@vger.kernel.org

The v2 was a intermediate testing version which I sent it out by
mistake. The difference between the tow is that the v2 uses a
infinite loop to wait for data to be transfered out form buffer, whereas
the v3 relies on existing wait_form_xmitr function.

Regards,
Cosmin

Greg KH wrote:
> On Tue, Nov 23, 2010 at 12:24:12AM +0100, Cosmin Cojocar wrote:
>> The kgdb invokes the poll_put_char and poll_get_char when communicating
>> with the host. This patch also changes the initialization order because the
>> kgdb will check at the very beginning, if there is a valid serial
>> driver.
> 
> What was the difference between v2 and v3?
> 

