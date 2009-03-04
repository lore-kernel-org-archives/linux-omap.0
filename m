From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: omap35x mmc support
Date: Wed, 04 Mar 2009 11:19:13 +0200
Message-ID: <49AE4791.2080202@nokia.com>
References: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com> <200903031559.26946.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51894 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZCDJTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 04:19:24 -0500
In-Reply-To: <200903031559.26946.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>

David Brownell wrote:
> On Tuesday 03 March 2009, twebb wrote:
>> Does the omap kernel support SD/MMC cards on all of the three
>> interfaces on OMAP35xx: SD/MMC1, SD/MMC2, and SD/MMC3?
> 
> I've seen it work for MMC1 and MMC2, and recent patches
> should have improved the MMC3 support.
> 
> Note that MMC3 only supports 1.8V; and MMC2 needs some kind
> of level shifting solution to use other voltages, such as a
> transceiver.   (Or a dual-voltage managed NAND device.)

For MMC3 this patch:

    http://lkml.org/lkml/2009/1/27/101

seems to be missing.
