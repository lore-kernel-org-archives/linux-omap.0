From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Mon, 7 Apr 2008 10:13:43 +0300
Message-ID: <20080407101343.a20e36a8.jarkko.nikula@nokia.com>
References: <0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com>
	<9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>
	<999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>
	<9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>
	<9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>
	<105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com>
	<f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com>
	<47F7B240.2070901@gmail.com>
	<20080406132323.GA13033@bulgaria.corp.google.com>
	<20080407094715.72685822.jarkko.nikula@nokia.com>
	<20080407065109.GA16340@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53082 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbYDGHNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 03:13:30 -0400
In-Reply-To: <20080407065109.GA16340@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Brian Swetland <swetland@google.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, Georges.Toth@gmail.com, linux-omap@vger.kernel.org

On Sun, 6 Apr 2008 23:51:09 -0700
"ext Brian Swetland" <swetland@google.com> wrote:

> Well I'm looking for two specific things:
> 
> - can I use wifi with a 2.6.23 or 2.6.24 kernel?  The proprietary
> module part of the wifi driver did not work with > 2.6.21 kernels
> when I tried (due to network stack structure changes by the look of
> things).
> 
Most probably not I think. But worth to search the maemo developers
mailing list are there any info about this.

> - can I get the battery to charge without proprietary, binary-only,
>   non-redistributable userspace code?  It did not seem like that was
>   the case a couple months ago.  Perhaps it's better now?
> 
This should work if you boot through the initfs as usual. E.g. I've
run the Debian armel on N810 using up-to-date linux-omap.


Jarkko
