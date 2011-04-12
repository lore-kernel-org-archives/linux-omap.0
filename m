From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP_DSS: DSI driver with support for video mode?
Date: Tue, 12 Apr 2011 10:38:37 +0530
Message-ID: <4DA3DE55.1080704@ti.com>
References: <BANLkTi=ca5GYo1p-GT27B0Uq3RcUtDuakQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab1DLFDm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 01:03:42 -0400
In-Reply-To: <BANLkTi=ca5GYo1p-GT27B0Uq3RcUtDuakQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 12 April 2011 01:00 AM, Juha Kuikka wrote:
> Hello,
>
> I am wondering if anyone has implemented DSI video mode support in the
> DSS driver? I tried to trawl the web and the mailing list archives but
> no patches come up.
>
> I am using DM3730.

Video mode isn't supported yet. But there are lots of custom 
implementations of it over the current DSS2. One I can think of is 
motorola's droid 2 and droid X source code:

https://opensource.motorola.com/sf/sfmain/do/viewProject/projects.milestone

You could use this as reference.

Regards,
Archit
