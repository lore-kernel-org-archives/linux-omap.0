From: Georges Toth <georges.toth@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 06 Apr 2008 21:36:32 +0200
Message-ID: <47F92640.9080107@gmail.com>
References: <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>	 <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>	 <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>	 <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>	 <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>	 <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com>	 <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com>	 <47F7B240.2070901@gmail.com>	 <20080406132323.GA13033@bulgaria.corp.google.com>	 <47F8E66E.7080605@gmail.com> <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from terman.e-hosting.lu ([80.92.79.12]:59275 "EHLO
	terman.e-hosting.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYDFTgk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 15:36:40 -0400
In-Reply-To: <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

>  Fortunately the userspace can partially ignore the
> charging issue because the RETU (now Betty) chip takes care of that in
> the hardware.  Charging / charger-cable / power-button / battery-life
> states are readable from /sys and /dev.
>   
Hmm where exactly can you read that info from ?
I quickly searched through sysfs, proc and dev but without much luck  :-)

> The best bet for a distro is probably to leave the maemo "initfs",
> which contains closed-source DSME / BME / flasher, in place and let
> the custom rootfs run on top of it.  If you need some details about
> retu / tahvo driving / bootloading, I may be able to tell because I
> recently had to poke on it for a different project.
>   
Should I get android to work correctly it would be nice to automatically 
start android after booting the n810.
Thus if you have any info on setting up wifi automatically from a script 
and what exactly to disable to prevent the system from starting Xomap, 
dbus, hal etc... that would be nice :-)

>>  Next would be to try to get the framebuffer driver hacked to work with the
>> m5 image ... the framebuffer driver doesn't support double buffering thus we
>> only get a black screen :-(
>>     
> I understand the userspace is going to be open-source at some point,
> which would render this work a bit useless.  If it doesn't get
> open-sourced then it's a waste of time either way I think?
>   
According to what I've read so far it will be open-sourced as soon as 
the first devices start to appear...which probably won't be anytime soon

But even then that work wouldn't be useless because Google won't release 
a framebuffer driver for Nokia n800/810 ... so if one wants to be able 
to run m5 and future releases, somebody has to modify the current driver 
to be compatible with android...if that is even possible.


-- 
regards,

Georges Toth

