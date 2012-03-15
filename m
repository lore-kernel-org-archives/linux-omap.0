From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits
 are reprogrammed after a reset
Date: Thu, 15 Mar 2012 00:25:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053657.16278.76132.stgit@dusk> <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36018 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2COGZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 02:25:59 -0400
In-Reply-To: <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

Hola Omar,

On Wed, 14 Mar 2012, Ramirez Luna, Omar wrote:

> If we reached here the reset lines will be asserted, and then the code
> below touches sysc registers on a module under reset.

Do you know of any case where this would be a problem?  Seems like it 
would only affect IP blocks that have both hard reset lines and SYSCONFIG 
registers, and as far as I know, we don't have any of those defined?


- Paul
