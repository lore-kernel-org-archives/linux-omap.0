From: "iqbal shareef" <iqbalshareef.list@gmail.com>
Subject: Using sys_ck for GPT8
Date: Wed, 22 Oct 2008 14:43:18 +0900
Message-ID: <c6a924220810212243p6237400bjac8a56f032baccab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:32071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYJVFnU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 01:43:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so226417fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 22:43:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

My OMAP3 board requires >13Mhz frequency PWM output from GPT8, but the
default clock source gives me Khz range.
What would be the exact impact If I use Sys clock source for the GPT8.

Thanks
Iqbal
