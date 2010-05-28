From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 08:31:07 -0400
Message-ID: <67B0FE92-F943-470C-9B23-27BF3F7E81DB@mit.edu>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk> <06439EEF-9404-45DC-AB37-5CC0486CCF6C@mit.edu> <4BFFBBE6.50604@nokia.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BFFBBE6.50604@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org


On May 28, 2010, at 8:49 AM, Igor Stoppa wrote:

> ext Theodore Tso wrote:
> 
>> I've seen very hard to debug situations  with Maemo where users are essentially asked to uninstall all their applications, and then install them back one at a time, waiting several hours between each install for a charge/discharge cycle, to figure out which application was waking up the system so !@#@! much while the screen was turned off.   And, when the periodic wakeups are faster than the refresh time of powertop, no, powertop won't help you find the crapplication.   If you think that's acceptable, fine --- we'll see who wins in the marketplace, and who gets blamed for producing a crappy platform --- the incompetent application programmer, or the platform supplier.
>>  
> Those apps were from an experimental repository, which is not enabled by default in stock SW.

Well, yes, if the company strategy is to have a walled garden ala the Apple iPhone App store, life is much simpler.   But if the requirements mean that apps don't need preapproval, the requirements on the platform get harder.   I think the take-home here is we have a requirement that the platform behave well even without someone screening the applications for the "default SW repository".

-- Ted
> 
