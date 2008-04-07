From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Mon, 7 Apr 2008 09:47:15 +0300
Message-ID: <20080407094715.72685822.jarkko.nikula@nokia.com>
References: <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>
	<0b2d3f9c-e29a-406a-ac8d-d8589d457a0f@m36g2000hse.googlegroups.com>
	<0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com>
	<9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>
	<999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>
	<9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>
	<9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>
	<105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com>
	<f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com>
	<47F7B240.2070901@gmail.com>
	<20080406132323.GA13033@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18055 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbYDGGrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 02:47:06 -0400
In-Reply-To: <20080406132323.GA13033@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Brian Swetland <swetland@google.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, Georges.Toth@gmail.com, linux-omap@vger.kernel.org

On Sun, 6 Apr 2008 06:23:23 -0700
"ext Brian Swetland" <swetland@google.com> wrote:

> Has anyone had any luck getting a 2.6.23 or 2.6.24 kernel working
> with the 800 or 810?  When I was poking around with it a while back,
> I had to backport our stuff to .21 due to binary-only wifi drivers
> being incompatible with newer kernels.
> 
I would say that N800 has the best support at the moment in linux-omap.
I think almost all the drivers are there. IIRC only temperature sensor
is missing.

N810 has unfortunately only very minimal support. But at least USB and
OneNAND are working so it can run as a block box. However there
shouldn't be any new binary stuff so in principle it should be able to
get into same shape than N800 with help of our kernel sources.


Jarkko
