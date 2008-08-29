From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Pin mux utility?
Date: Fri, 29 Aug 2008 20:31:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C418C4EB@dbde02.ent.ti.com>
References: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbYH2PBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 11:01:24 -0400
In-Reply-To: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Steve Sakoman
> 
> Is anyone aware of a utility to report the state of pin mux settings?
> 
> I'd like to verify that u-boot is setting things up properly.

How about reading the pin-mux registers directly?

