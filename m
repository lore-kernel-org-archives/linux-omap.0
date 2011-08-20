From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 19 Aug 2011 22:24:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108192223230.18944-100000@netrider.rowland.org>
References: <20110819231419.GA3981@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:48110 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751332Ab1HTCYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 22:24:20 -0400
In-Reply-To: <20110819231419.GA3981@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Sat, 20 Aug 2011, Mark Brown wrote:

> The original issue that Kevin raised and CCed me in on was the idea of
> exposing raw per-device wakeup latency constraints to userspace; it
> seems much better to expose user level requirements via subsystem
> interfaces and let the subsystem and driver translate these into actual
> wakeup latency constraints:
> 
>   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032422.html
>   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032428.html
> 
> This is much easier for users as it translates into something they're
> actually doing (and in most cases the driver can make it Just Work) and
> it means that off the shelf applications will end up tuning the system
> appropriately by themselves.  I'm additionally concerned that if we
> expose this stuff directly to userspace that's an open invitation to
> driver authors to not even bother trying to make the kernel figure this
> stuff out by itself and to instead tie the system together with magic
> userspace.

Can you give a couple of examples to illustrate these points?  I think
it would help a lot to make the conversation more concrete.

Alan Stern

