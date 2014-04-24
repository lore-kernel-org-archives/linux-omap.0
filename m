From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: omap-serial: use mctrl_gpio helpers
Date: Thu, 24 Apr 2014 15:10:14 -0700
Message-ID: <20140424221014.GA29114@kroah.com>
References: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40016 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbaDXWHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 18:07:21 -0400
Content-Disposition: inline
In-Reply-To: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Apr 24, 2014 at 11:24:30AM +0200, yegorslists@googlemail.com wrote:
> This patch is based on Richard Genoud' patch adding generic GPIO support [1]
> and my patch adding get_direction() functionality to OMAP's GPIO driver [2].
> 
> So far RTS/DTR are working both as modem control outputs and RTS as RS-485 2-wire controller.
> 
> CTS/DSR/DSR/RI are generating interrupts.
> 
> Richard, Greg, what is the status of [1]? It seems like it will be available in 3.16 first?

Probably.
