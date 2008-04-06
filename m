From: Georges Toth <georges.toth@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 06 Apr 2008 17:04:14 +0200
Message-ID: <47F8E66E.7080605@gmail.com>
References: <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com> <0b2d3f9c-e29a-406a-ac8d-d8589d457a0f@m36g2000hse.googlegroups.com> <0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com> <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com> <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com> <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com> <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com> <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com> <20080406132323.GA13033@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from terman.e-hosting.lu ([80.92.79.12]:52760 "EHLO
	terman.e-hosting.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbYDFPEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 11:04:21 -0400
In-Reply-To: <20080406132323.GA13033@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: linux-omap@vger.kernel.org


> Congrats.
>   
Thnx :-)

> Has anyone had any luck getting a 2.6.23 or 2.6.24 kernel working
> with the 800 or 810?  When I was poking around with it a while back,
> I had to backport our stuff to .21 due to binary-only wifi drivers
> being incompatible with newer kernels.
>   
AFAIK, no.

I've just searched through some mailinglists and apparently it is 
possible to use a more recent kernel with the n800/n810.
You basically compile a module called cx3110x which is open source [1], 
and force to load a binary-only module (umac); in order to get wifi to work.

I'll probably look into this over the next few days as time permits.


[1]: http://repository.maemo.org/pool/chinook/free/c/cx3110x-module-src/

> Also, if anyone knows of work done to figure out how the battery
> charge control, etc works on the 800/810 hardware, I'm highly curious.  
> Have not had the spare time to reverse engineer that stuff and if
> somebody's already done the hard work, so much the better.
I've only started to work on this last week, but AFAIK the only work that has been done on the n800/n810 so far is to actually get the android patches to work and get it to run.

Next would be to try to get the framebuffer driver hacked to work with the m5 image ... the framebuffer driver doesn't support double buffering thus we only get a black screen :-(

Sebastian (android-internals ml) is currently looking into that.

And of course the touchscreen and buttons issue.

-- 
regards,

Georges Toth

