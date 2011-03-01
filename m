From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/3]OMAP: DSS2: Abstract away DSI VC information
 from dsi panel drivers
Date: Tue, 1 Mar 2011 17:56:42 +0200
Message-ID: <1298995002.2049.8.camel@deskari>
References: <1298982743-6771-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48172 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539Ab1CAP4o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 10:56:44 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21Fui87016469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 09:56:44 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p21Fui7F013947
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 09:56:44 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p21FuipA028124
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 09:56:44 -0600 (CST)
In-Reply-To: <1298982743-6771-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 06:32 -0600, Taneja, Archit wrote:
> The current DSI driver design requires the DSI panel driver to specify the
> DSI Virtual Channel and the Panel Virtual Channel ID for the transfer of
> commands and frame data. Out of these, only the second parameter is a property
> of the Panel.
> 
> The DSI Virtual Channel in use by the panel driver ideally shouldn't be provided
> by the panel driver. The current design leads to the following issues:
> -Multiple panels connected to the same DSI interface would be unaware of the
> VC's in use.
> -Hard coded Virtual Channel numbers in panel drivers which is not generic.
> -No clean way of configuring DSI for panels which need atleast 2 DSI Virtual
> Channels.
> -No clean way of configuring DSI for the special case where a panel may have 2
> or VC ID's corresponding to it.
> 
> The panel driver should, instead, request for, and release DSI Virtual Channels
> through calls to the DSI driver. The DSI driver should return VC numbers which
> the panel can use. The panel driver then uses this VC to either send pixel data,
> send commands and receive data from the panel. The DSI driver then automatically
> configures the Virtual Channel source to either Video Port or L4 Slave Port.
> 
> This patch set tries to achieve the above design, and make Panel Taal driver use
> this approach.

This patch set doesn't apply, and seems not to be based on Linus',
Tony's or my tree. What is it based on?

You should always base the patches on top of a public tree before
sending the patches. Otherwise it is difficult to apply those patches.
Or clearly say the required patch sets, which have previously been sent
for review, but not yet applied.

 Tomi


