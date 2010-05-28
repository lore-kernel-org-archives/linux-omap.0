From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 17:28:59 +0300
Message-ID: <4BFFD32B.5090105@nokia.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>	<20100528114123.GA22947@srcf.ucam.org> <20100528145444.265d1853@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528145444.265d1853@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

ext Alan Cox wrote:

> Be that as it may the question of how you manage a naughty app is a good
> one. Historically we've managed them for network abuse, memory abuse, cpu
> use abuse, access rights, but not yet power.
>
> Whether that looks like
>
> 	setrlimit(pid, LIMIT_CHARGE, 150mWH);
>
> or
> 	setrlimit(pid, LIMIT_POWER, 150mW);
>
> or something else is the question.

Either way, this will require a detailed model of the system in terms of 
latency, throughput, current consumption and heat generation.

Which can be provided only by the HW manufacturer.

But, should such model be available (and we have some form of it for the 
OMAP3 in N900), then it can be abstracted through generic interfaces, 
which accept constraints and produce the selected target state 
(typically a vector of states for each sub component).

igor
