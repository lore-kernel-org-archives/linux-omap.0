From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP34xx
Date: Wed, 08 Feb 2012 15:03:19 -0800
Message-ID: <871uq53p3c.fsf@ti.com>
References: <20120205125904.GB11372@n2100.arm.linux.org.uk>
	<20120205172925.GS20333@atomide.com>
	<20120205175809.GF17309@n2100.arm.linux.org.uk>
	<20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com>
	<87y5sei1qz.fsf@ti.com>
	<CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
	<87k43xfee3.fsf@ti.com> <20120208170653.GA3492@kroah.com>
	<CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
	<20120208195327.GA5223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53810 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755241Ab2BHXD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:03:28 -0500
Received: by pbcun15 with SMTP id un15so1451318pbc.33
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 15:03:23 -0800 (PST)
In-Reply-To: <20120208195327.GA5223@kroah.com> (Greg KH's message of "Wed, 8
	Feb 2012 11:53:27 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> writes:

[...]

>> It would look to me like they are queued for 3.4 but Kevin says there
>> were intended for 3.3-rc.
>
> Kevin might have wished they would go into 3.3, but given that the first
> round of these patches had to be reverted, I thought it safer to wait
> for 3.4.

Sorry for the churn on these, but I guess we weren't expecting you to
apply the first before it got some testing/acks.  Sorry about that.

The version you have currently queued is needed for v3.3 as they fix
brokenness on v3.3.  Any chance they can be applied queued for 3.3?
We'll have another set of enhancements on top of those that are
targetted for v3.4, but those you have queued currently are defintely
fixes.

Kevin


