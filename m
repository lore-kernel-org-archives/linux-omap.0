From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 0/4] hwspinlock core & omap dt support
Date: Thu, 16 Apr 2015 10:31:31 +0100
Message-ID: <20150416093130.GH2866@leverpostej>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
 <CAK=WgbY1Gbc+b1YtHafUyph6P60fees1ND_K5OE=9MXuqszbOg@mail.gmail.com>
 <5509F4E7.6070607@ti.com>
 <551D70EE.307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37633 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757077AbbDPJbg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 05:31:36 -0400
Content-Disposition: inline
In-Reply-To: <551D70EE.307@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi,

Apologies for the delay on this.

> > Gentle reminder. Can you please provide your ack on the bindings in this
> > series (Patches 1 & 3) for Ohad to queue up the series for 4.1.
> > 
> 
> Ping again, if you can provide your ack on these bindings and the qcom
> hwmutex bindings, then Ohad can pick up both the series for 4.1. Both
> series are blocked on getting the binding acks.

Both the bindings look sane to me, so for patches 1 and 3:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
