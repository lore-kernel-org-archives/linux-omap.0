From: Grant <emailgrant@gmail.com>
Subject: Re: omapfb segfaults
Date: Mon, 3 Feb 2014 20:42:17 -0800
Message-ID: <CAN0CFw2CZDxN_UxEYnye-bwAzL=nsr8w_Kz4cGHOaQjvpJ61nw@mail.gmail.com>
References: <CAN0CFw0hJ3=5g9NtZqK6DoGYCqyTrB+P47_TWLr03n9yh=jVoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:53604 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaBDEmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Feb 2014 23:42:18 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so12688207qcx.24
        for <linux-omap@vger.kernel.org>; Mon, 03 Feb 2014 20:42:17 -0800 (PST)
In-Reply-To: <CAN0CFw0hJ3=5g9NtZqK6DoGYCqyTrB+P47_TWLr03n9yh=jVoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> omapfb segfaults on my Pandaboard ES across several different kernel
> versions including 3.13.1.  I've tried everything I can think of.  Any
> ideas?
>
> - Grant

This was fixed with the patches here:

https://github.com/archlinuxarm/PKGBUILDs/tree/master/alarm/xf86-video-omapfb

- Grant
