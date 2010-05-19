From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH] arm: oprofile: remove locking from suspend/resume
Date: Wed, 19 May 2010 08:04:59 +0100
Message-ID: <20100519070459.GA22212@n2100.arm.linux.org.uk>
References: <1274227981-20130-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33037 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0ESHFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 03:05:19 -0400
Content-Disposition: inline
In-Reply-To: <1274227981-20130-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 05:13:01PM -0700, Kevin Hilman wrote:
> Since oprofile is a sysdev, its suspend/resume methods are called with
> interrupts disabled.  Using a mutex (which might sleep) in this atomic
> context is not safe.

It isn't a sysdev anymore.  Suggest you take a look at the ARM tree once
in a while.
