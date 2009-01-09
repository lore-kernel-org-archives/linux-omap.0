From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Powertop on Beagle
Date: Fri, 9 Jan 2009 07:54:57 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D4E6661@dlee02.ent.ti.com>
References: <49675282.1040100@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59959 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZAINzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 08:55:06 -0500
In-Reply-To: <49675282.1040100@balister.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I'm trying to get powertop running on the latest git. It basically
> works, but I do not get displays for the C and P states. This has worked
> in the past, but the OE kernel I'm using had a lot of patches then :)
>
> Does anyone have a list of things to check, before I start working
> through my kernel patch history?

For kernel:
You need cpuidle in kernel and configured on.
You need to enable timerstats under kernel debug options.

For Userspace:
You need powetop binary
You need ncurses package installed

Regards,
Richard W.
