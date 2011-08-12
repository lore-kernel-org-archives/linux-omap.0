From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] rtc: twl: Fix registration vs. init order
Date: Fri, 12 Aug 2011 16:36:52 -0700
Message-ID: <1313192212.2970.45.camel@work-vm>
References: <1313032836-347-1-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:50744 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1HLXg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 19:36:57 -0400
In-Reply-To: <1313032836-347-1-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2011-08-10 at 20:20 -0700, Todd Poynor wrote:
> Only register as an RTC device after the hardware has been
> successfully initialized.  The RTC class driver will call
> back to this driver to read a pending alarm, and other
> drivers watching for new devices on the RTC class may
> read the RTC time upon registration.  Such access might
> occur while the RTC is stopped, prior to clearing
> pending alarms, etc.
> 
> The new ordering also avoids leaving the platform
> device drvdata set to an unregistered struct rtc_device *
> on probe errors.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks! Queued.
-john

