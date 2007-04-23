From: "Hades Liu" <lcc0917@msn.com>
Subject: RE: TV-out problem
Date: Mon, 23 Apr 2007 20:00:57 +0900
Message-ID: <BAY111-F218508B8D3123563BC5EFA64B0@phx.gbl>
References: <9C23CDD79DA20A479D4615857B2E2C4708106D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4708106D@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: x0khasim@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

My code base is the newest version, 2.6.14, on linux.omap.com. But my LCD's 
resulution is 800x480 and the  frame buffer is the same, too.

I found that the problem is caused by wrong frame buffer settings. I had 
changed the default output device from LCD to TV, and the initialling 
function will initialize frame buffer for default output device. The tv-out 
will work when set as default output device.

However, when I change output device in kernel console via command,
echo tv > /sys/class/display_control/omap_disp_control/graphics,
the frame buffer seems not be reset for tv-out. The output result is not 
correct and showen as descripted in before e-mail.Therefore, the frame 
buffer should be reset for tv-out while changing the output device 
dynamically.

Is my absorbing correct? If it is correct, willTI modify the code for this 
issue in future version?

Another question: Is it possible to output to LCD and tv-out concurrently 
with a single frame buffer?


Thank you.

Best Regards
Hades


>From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
>To: "Hades Liu" <lcc0917@msn.com>, <linux-omap-open-source@linux.omap.com>
>Subject: RE: TV-out problem
>Date: Wed, 18 Apr 2007 06:50:06 -0500
>
>Which code base are you using?
>
>Try the one on linux.omap.com 
>:http://linux.omap.com/pub/kernel/2430sdp/source/
>linux-2.6.14-omap2420-omap2430.tgz 
><https://webmail.ti.com/exchange/x0khasim/Drafts/RE:%20TV-out%20problem.EML/linux-2.6.14-omap2420-omap2430.tgz>
>
>Boot the system, then do a
>echo "tv" > /sys/class/omap_disp/display_control/graphics, You should see 
>the penguin on TV out.
>
>You can use either projector or TV. Makesure the projector is set to NTSC 
>input (if such configuration is available in your projector).
>
>Regards,
>Khasim
>________________________________
>
>From: linux-omap-open-source-bounces@linux.omap.com on behalf of Hades Liu
>Sent: Wed 4/18/2007 6:03 AM
>To: linux-omap-open-source@linux.omap.com
>Subject: TV-out problem
>
>
>
>Hi all,
>I am trying the tv-out feature of omap2430.
>
>I had output the displaying graphic to tv-out target, but the output image
>is not correct. My original display is to show a linux penguin at left-top
>of displaying. But when output to tv-out, it became foggy and many penguins
>at the left-top, middle-left-top, middle-right-top, and right-top of
>displaying.
>
>What will cause this problem? I used a projector to be the tv-out target,
>does the projector cause the result?
>
>
>Thank you.
>
>Best Regards
>Hades
>
>_________________________________________________________________
>Express yourself instantly with MSN Messenger! Download today it's FREE!
>http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/
