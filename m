From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 10:46:51 +0200
Message-ID: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:46919 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbCEIqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 03:46:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org

> I added power support to kernel menuconfig, such as cpuidle, and it
> seems to work fine. I also validated in counter that cpu gets into
> retention.

We observer that with highest available frequency (600000) reboot
command is OK, but when frequency is changed to lower value, the
reboot command fails.
Has anyone observed such behaviour ?

Regards,
Ran
