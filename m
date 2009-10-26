From: "Girish S G" <girishsg@ti.com>
Subject: RE: update: n8x0 idle power problem
Date: Mon, 26 Oct 2009 18:57:43 -0500
Message-ID: <006001ca5698$1bad9960$a14ff780@am.dhcp.ti.com>
References: <f25d86460910261536k5003954ehec9f30a936a6766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42992 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbZJZX56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 19:57:58 -0400
In-Reply-To: <f25d86460910261536k5003954ehec9f30a936a6766@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Felix Xiaozhu Lin' <xzl@rice.edu>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felix
> Xiaozhu Lin
> Sent: Monday, October 26, 2009 5:36 PM
> To: linux-omap@vger.kernel.org
> Subject: update: n8x0 idle power problem
> 
> Hi, All,
> 
> Regarding the idle power problem I've mentioned in a mail last weekend:
> 
> http://marc.info/?l=linux-omap&m=125634121921583&w=2
> 
> I have spent more efforts on this problem. By comparing with PM debug
> messages from Maemo kernel, it seems full-retention in linux-omap
> 2.6.28 has no problem on n810. Moreover, I've observed that l-o kernel
> consumes more power in other power states (e.g. when USB is plugged
> and the screen is dim but not off, Maemo kernel takes ~90mA@3.8V while
> l-o kernel takes ~180mA@3.8V). As a result, I think the extra power
> may not be consumed by OMAP processor core but by some device.

I assume you are measuring at the battery level(?). If you have measurement done across
different rails then it would help to understand who is consuming more.


-Girish


