From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Errors when building for omap4 only
Date: Thu, 6 Jan 2011 19:19:04 +0530
Message-ID: <568127b70200733a61aa8c358fb49292@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302482019D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36771 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1AFNtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:49:06 -0500
Received: by mail-gw0-f49.google.com with SMTP id 20so8327504gwj.22
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 05:49:05 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302482019D4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Sanjeev,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Thursday, January 06, 2011 6:18 PM
> To: linux-omap Mailing List
> Subject: Errors when building for omap4 only
>
> Hi all,
>
> I was trying to build OMAP4 only kernel from the linux-omap master.
> Came across few failures caused by exclusion of OMAP3/3 specific
> code via #ifdef.
>
These are addressed already. You could look at below series
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html
