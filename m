From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: RE: Debug Output
Date: Thu, 31 Aug 2006 15:01:52 +0000
Message-ID: <BAY102-F10B934D84FAB206A1718DDA93F0@phx.gbl>
References: <B50FF75CBCFA2E4E8D23F26E18F52B101850FF@mail.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <B50FF75CBCFA2E4E8D23F26E18F52B101850FF@mail.oerlikon.ca>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Folks,


   Thanks for the help Robin!

   I've been reading the refference framework userguide, SPRA796A, it has 
been very helpful in understanding the mechanics of the system. There is a 
section in here about debugging the DSP side applicaiton, and it makes 
refference to viewing logs containing debug output. The problem is that I 
cannot figure out how to view these logs in code composer (2.21). I set a 
breakpoint that the code should hit (on one UTL debug line when the volume 
is changed), but when I run and change the volume via the terminal, CCS 
never breaks or otherwise informs me of the debug output. Is there a window 
for this that can be docked with the rest of the GUI? Does anyone know where 
this is in the menus?

Thanks,
Andy


>From: "Boivin, Robin" <RBoivin@oerlikon.ca>
>To: "Abot Botbot" <dejanigma@hotmail.com>
>Subject: RE: Debug Output
>Date: Thu, 31 Aug 2006 10:32:38 -0400
>
>The UTL* are for the DSP side. The prints are stored by the RTDX and sent 
>through JTAG to your Code Composer when you break. I find it quite 
>difficult to trace and debug using that. You could try your algorythm on 
>the data stream received on the ARM side. From there you can printf and 
>trace more easily.
>
>The CCS debugger is buggy. Well mine is, maybe because I use the CCS 31 
>EVAL version. Tell me whether you can use the CCS debugger, it would be 
>helpful for me.
>
>To integrate your algorytm through the RF6/DSP side using the TI XDAIS 
>method, you may have a couple of reading to do:
>spra796a
>spra795a
>
>The way I did is that I started from their VOL module. Adapt your algo 
>based on that. You have to get familiar with their multi-thread stuff 
>(cell, channel, task, etc)
>
>Hope it helps
>
>Robin
>
>
>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com
>[mailto:linux-omap-open-source-bounces@linux.omap.com]On Behalf Of Abot
>Botbot
>Sent: August 31, 2006 10:10 AM
>To: Linux-omap-open-source@linux.omap.com
>Subject: Debug Output
>
>
>Hello all,
>
>
>     I'm trying to edit the RF6 refference framework application to suit my
>purposes. At the moment I want to get a feel for how many samples go 
>through
>their filter with each message from the GPP. My algorithm works on a sample
>by sample basis, so I'm guessing I want to do my loop multiple times per
>message from the GPP. My questions is, how can I output basic debug 
>material
>to the console? Can I just throw printf statements in any place in the code
>and see the output in the console? I see statments like "UTL_logDebug(
>"Application started." );" etc, where does that output end up?
>
>Thanks,
>Andy
>
>_________________________________________________________________
>Windows Live Spaces is here! It's easy to create your own personal Web 
>site.
>   http://spaces.live.com/signup.aspx
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Call friends with PC-to-PC calling -- FREE   
http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline
