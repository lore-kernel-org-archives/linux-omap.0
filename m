From: "sahlot arvind" <asahlot@gmail.com>
Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Fri, 2 Mar 2007 10:09:34 +0530
Message-ID: <d94614c90703012039u12812c0jd25cf5e65dceca7b@mail.gmail.com>
References: <20070301080643.GC26097@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C475C9FE7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C475C9FE7@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All

Can some one tell me when I use the camera on N800 then which part of the
code gets executed?
I mean is there some application, which starts running and opens camera
driver or there is no application program on the top of camera driver, it is
just the camera driver which gets started when I start using the camera and
takes care of capturing pics?

If it is some application on top of camera driver then how does it interact
with the camera driver? does it interacts in a linux std way, I mean first
it opens /dev/video0 then it sends ioctl commands etc.?
Please enlighten these points, I am confused.

Thanks in advance.
Sahlot


On 3/2/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> >> do you have any kind of design doc or ppt that
> >> gives a brief overview of what the code is and the interface
> considered
>
> Sakari, taking this back :) Sorry was kind of used to these for a while.
>
>
> >> Do you mean "rotation" of the preview window ? See, preview in camera
> >> driver is just a add-on functionality _but_ not must. I would not use
> >> this auto preview functionality, instead captured stream will go to
> >> /dev/fb1 and then shown on the LCD/TV out and rotated based on the
> >> N800 sensor or app commands.
>
> Trilok, this may be your use case but not true for all OMAP users :)
> Few take preview seriously; I have seen demands for a preview with
> rotation/mirroring/cropping/scaling :) Again it's as per demands.
> Why to send a data to app that is not getting stored?
>
> No issues, as Tony suggested we can go ahead and add more functionality
> later (if required).
>
> Trilok, will you be pushing the Micron sensor library too?
>
> Regards,
> Khasim
>
>
>
> >-----Original Message-----
> >From: tony@atomide.com [mailto:tony@atomide.com]
> >Sent: Thursday, March 01, 2007 2:07 AM
> >To: Trilok Soni
> >Cc: Syed Mohammed, Khasim; linux-omap-open-source@linux.omap.com
> >Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
> >
> >* Trilok Soni <soni.trilok@gmail.com> [070228 21:50]:
> >> Syed,
> >>
> >> On 2/28/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> >> >If some patches are for review please mark them as "RFC". "Patch" is
> >> >when it has to go into tree - Some one can correct me if I am wrong.
> >> >
> >> >Sakari,
> >> >
> >> >Thanks for the code, do you have any kind of design doc or ppt that
> >> >gives a brief overview of what the code is and the interface
> considered
> >> >etc. Its bit hard to go directly to code :(
> >>
> >> I don't think that you will need this. What interface you would like
> >> to understand? Please phrase the questions based on the code and may
> >> Sakari can help you to understand :) I believe some of the changes in
> >> N800 camera driver was also done to reduce the interrupt latencies
> and
> >> bugs in video-buf.
> >
> >I agree with Trilok. The idea is to do incremental changes based on
> >patches.
> >
> >> >The second issue is merging TI's camera code with this. I can post
> our
> >> >design considerations for camera. We can see how to integrate TIs
> sensor
> >> >and additional functionality provided by TI's camera code (like
> >> >rotation, scatter gather dma, multiple sensors handling etc).
> >>
> >> Do you mean "rotation" of the preview window ? See, preview in camera
> >> driver is just a add-on functionality _but_ not must. I would not use
> >> this auto preview functionality, instead captured stream will go to
> >> /dev/fb1 and then shown on the LCD/TV out and rotated based on the
> >> N800 sensor or app commands.
> >
> >Yyp, additional features are easy to add later once we have basics
> >in place.
> >
> >Regards,
> >
> >Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
