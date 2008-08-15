From: "Pasam, Vijay" <vpasam@ti.com>
Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Fri, 15 Aug 2008 16:59:47 -0500
Message-ID: <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com>
References: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58719 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbYHOWAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 18:00:50 -0400
Content-class: urn:content-classes:message
In-reply-to: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, soni.trilok@gmail.com, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, felipe.contreras@nokia.com

> I'm not familiar with checkpatch, but I guess the purpose is 
> not to highlight functional issues.
> 
> However, there are functional issues, but it makes sense to 
> cleanup the code first: there's no point in analyzing code 
> that is never used.

There are about 9 errors with the latest set of patches. These are all
false positives - not really errors. Majority of warnings also fall
under this category.

> I'm not familiar with checkpatch, but I guess the purpose is 
> not to highlight functional issues.
> Indeed, if I put myself the open source cap I can create ARM 
> side applications, but then I need something running on the 
> DSP in order to test them. If I put my corporate cap I can do 
> that, and see that effectively, my ARM application works. But 
> how are maintainers supposed to test this?
> 
> At the very least I would expect a base image binary, and a 
> dummy dsp node that simply copies the buffers received so 
> that anyone can get their hands dirty with the dsp bridge. 
> Otherwise it's just some code that nobody can test (hard to 
> merge that way).


There are some sample applications distributed to test bridge
functionality. There are DSP side binaries provided along with ARM side
application that can be used to test the changes done on Bridge. You can
download sample applications at
http://omapzoom.org/gf/project/omapbridge/wiki/?pagename=Software+Inform
ation

Best Regards
Vijay
 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
> Sent: Friday, August 15, 2008 4:10 PM
> To: Woodruff, Richard
> Cc: Tony Lindgren; Hiroshi DOYU; linux-omap@vger.kernel.org; 
> soni.trilok@gmail.com; Kanigeri, Hari; Ramirez Luna, Omar; 
> Gupta, Ramesh; felipe.contreras@nokia.com; Pasam, Vijay
> Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated 
> branch in linux-omap
> 
> On Fri, Aug 15, 2008 at 11:16 PM, Woodruff, Richard 
> <r-woodruff2@ti.com> wrote:
> > Hi Felipe,
> >
> >> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> >
> > <snip>
> >
> >> >> As part of contributing this code there has been a lot of 
> >> >> reworking
> >> of the code. Last I had heard checkpatch and sparse 
> warnings had been 
> >> killed. There was also a lot of work in making sure there 
> would be no 
> >> legal impact to the kernel to clear its ability to be contributed.
> >> >
> >> > Not true: 13 errors, 246 warnings.
> >
> > Today another set of warning changes is in queue. Will have 
> to check what the current number has become. It will be low. 
> The start number a while back was defiantly very high.
> >
> > Checkpatch.pl is just a guide.  Completely changing code 
> for the tool isn't probably a good idea. It might even get 
> you severally flamed on LKML :)  The recent threads are 
> informative (ok to read, bad to be in).
> >
> > Incidentally, when I asked the person working these 
> changes, they had reported 0 functional errors had been fixed 
> by the checkpatch changes.  A lot of the noise was typedef reduction.
> 
> I'm not familiar with checkpatch, but I guess the purpose is 
> not to highlight functional issues.
> 
> However, there are functional issues, but it makes sense to 
> cleanup the code first: there's no point in analyzing code 
> that is never used.
> 
> > <snip>
> >
> >> Err, I got confused about the CE/Link, I meant the xdctools... or 
> >> whatever is needed to compile DSP nodes. AFAIK the DSP compiler is 
> >> not enough.
> >
> > You are correct that the internal DSP architecture is not 
> opened up only the ARM side and the peripherals.  DSP 
> internals is another topic.  You should be able to compile 
> the ARM side.
> 
> Indeed, if I put myself the open source cap I can create ARM 
> side applications, but then I need something running on the 
> DSP in order to test them. If I put my corporate cap I can do 
> that, and see that effectively, my ARM application works. But 
> how are maintainers supposed to test this?
> 
> At the very least I would expect a base image binary, and a 
> dummy dsp node that simply copies the buffers received so 
> that anyone can get their hands dirty with the dsp bridge. 
> Otherwise it's just some code that nobody can test (hard to 
> merge that way).
> 
> > A few years back I had heard about some people even 
> successfully running Linux on the C6x DSP.  I think it ran 
> well, but kind of neat all the same.  DSPBIOS or other tiny 
> OSes work much better there.
> 
> Interesting, another platform to conquer for Linux ;)
> 
> Best regards.
> 
> --
> Felipe Contreras
> 
> 
