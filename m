From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: OMAP camera with BT-656 sensor
Date: Mon, 27 Jul 2009 14:51:10 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A16F057@dlee02.ent.ti.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
	 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>
	 <a187869d0907270911j74ee55b9nc872687eb32aecce@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ED18@dlee02.ent.ti.com>
	 <a187869d0907271036meb56ce9r32c5f5e823465e87@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EE88@dlee02.ent.ti.com>
	 <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com>
 <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com>
 <4A6DFBBE.6020805@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbZG0Trg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 15:47:36 -0400
In-Reply-To: <4A6DFBBE.6020805@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Monday, July 27, 2009 2:11 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: OMAP camera with BT-656 sensor
> 
> Sergio,
> 
> I'm trying to use your tree with a BT-656 style sensor(*).  I've
> managed to get this [more or less] working when I use the official
> TI PSP tree + OMAP3 patches, but I'm not getting very far with
> your code.  I just updated my copy from your tree, but I don't
> see any real changes since June 18 when I first started looking
> at this.

Yeah, I know, and I'm sorry for that :(

Lately, I have been busy with some high priority customer specific tasks, and haven't had time to work on the public tree at all...

The good thing is that I'll be now dedicating on this full time, as This will eventually become my only task in the future (interact with the community for enahncemets/fixes in the driver).

One bad thing is that as I don't have a BT656 sensor with me, its near to impossible for me to develop on that area, so Vaibhav Hiremath in their PSP releases, is doing that instead. Anyways, I'll be looking forward to make those changes part of my tree aswell, if Vaibhav is ok with it (as I'm almost completely sure he is)
> 
> I've made a number of changes, inspired by the PSP code to get
> the BT-656 handling enabled in the CCDC.  I do see that the PSP
> codebase seems older than yours? but is more complete in other
> respects.  Can you enlighten me as to the heritage of these
> different trees?

Ok, let me explain the currently existing trees, and their connection:

Linux-omap is the "baseline" in which all this code is based, because you couldn't find everything yet on kernel.org.

Sakari Ailus (from Nokia) and Myself (from TI) we're trying to get the code accepted on the linux-omap and linux-media lists, so Sakari created a tree which contains the latest developed driver in Nokia, which is based on an older internal TI code, and in which I have been helping to fix for acceptance aswell. You can find that tree here:

	http://gitorious.org/omap3camera

But that tree only contains the core OMAP3 Camera-ISP driver, without any sensor or board specific code, and also it is based on an older kernel (because is the one in which Sakari tests). So there's when my tree comes to overcome this things. So I created a tree in gitorious right away:

	http://gitorious.org/omap3-linux-camera-driver

And Vaibhav, who was interested in bringing up this code on 3530EVM with an onboard TV tuner interfaced with BT656 to the camera driver (like it was a sensor), started his development on top of my gitorious tree.

Later on, Sakari updated his tree with some more code changes, but this time I could get a more formal tree under the omapzoom server, in which TI has full control. So instead of updating my gitorious, I decided to better create a new tree, and pull there the new code coming from Sakari's tree instead. So I created the tree you're currently looking at:

	http://dev.omapzoom.org/?p=saaguirre/linux-omap-camera.git;a=shortlog;h=refs/heads/devel

In which I'm trying to make work my 3430SDP with some camera sensors I have handy (MT9P012 and OV3640), an OMAP Zoom1 (a.k.a. LDP), and an OMAP Zoom2 (under works still).

So, I hope looks clear for you on how all these trees are related...

> 
> The problem I have at the moment is that sensor data is getting
> into the CCDC module, but since the previewer/resizer modules
> are not used, nothing is ever delivered to my user code.

The CCDC is capable of saving to memory directly, so you don't specifically need Preview and resizer all the time.
> 
> Bottom line, I'm confused as to how I should go about getting
> my driver/system working.  Do I use your work, or just stick
> with the PSP base (why?)??

What I do feel is that the PSP base will fulfill better your immediate needs, but in the future, as I'm getting aware of Vaibhav changes, I'll be interested in making them part of my tree aswell, so Vaibhav could avoid rebasing the BT646 support internally everytime...

> 
> Thanks

Thanks for your interest!

Regards,
Sergio
> 
> (*) I cloned: git://dev.omapzoom.org/pub/scm/saaguirre/linux-omap-
> camera.git
> 
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------

