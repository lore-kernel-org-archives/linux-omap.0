From: =?ISO-8859-1?Q?Daniel_D=EDaz?= <mrchapp@gmail.com>
Subject: Re: omap24xxvout alloc DMA page failed when using openMAX
Date: Mon, 16 Feb 2009 16:06:31 -0600
Message-ID: <e7df06480902161406s1a403c31gcf0169b60da330f9@mail.gmail.com>
References: <87fxien3ph.fsf@redflag-linux.com>
	 <94a0d4530902160203m489098b2sd9bda7322a564a1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:55914 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZBPWGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 17:06:34 -0500
Received: by fxm13 with SMTP id 13so6353890fxm.13
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 14:06:32 -0800 (PST)
In-Reply-To: <94a0d4530902160203m489098b2sd9bda7322a564a1a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Diancheng <dcwang@redflag-linux.com>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>

Hello!

If you don't mind the top-posting, please see the quoted chain of
emails below. Summary is that some changes need to make it to the
omapzoom.org kernel for Zoom2.

Greetings!

Daniel D=EDaz
ddiaz@ti.com



________________________________________
=46rom: Jimenez Villareal, Omar
Sent: Monday, February 16, 2009 11:46 AM
To: Mande, Nikhil; Turquette, Mike; Diaz, Daniel; Castaneda Gonzalez,
Axel; Munoz, Jose Luis Diaz
Subject: RE: omap24xxvout alloc DMA page failed when using openMAX

This bootargs are needed since 23.12 release because of memory
allocation at boot time but in omap zoom this changes are not merged,
first need to be done changes in omap zoom kernel and then when merged
720p resolution support this bootargs will be needed.

Regards,

Omar Jimenez
________________________________________
De: Mande, Nikhil
Enviado el: lunes, 16 de febrero de 2009 10:42 a.m.
Para: Turquette, Mike; Jimenez Villareal, Omar; Diaz, Daniel;
Castaneda Gonzalez, Axel; Munoz, Jose Luis Diaz
Asunto: RE: omap24xxvout alloc DMA page failed when using openMAX

They are related. Both kernel changes and those bootargs are required.

-----Original Message-----
=46rom: Turquette, Mike
Sent: Monday, February 16, 2009 10:32 AM
To: Jimenez Villareal, Omar; Mande, Nikhil; Diaz, Daniel; Castaneda
Gonzalez, Axel; Munoz, Jose Luis Diaz
Subject: RE: omap24xxvout alloc DMA page failed when using openMAX

This is probably unrelated, but I saw in another thread by Lajos that
it is necessary to set omap24xxfb:rotation=3D0 in the bootargs to avoid
some errors when specifically using the Zoom2 board.

Obviously a rotation of 0 is the default, but Lajos said it had to be
specifically set to avoid some sort of issue.  Maybe related, maybe
not.

Mike

> -----Original Message-----
> From: Jimenez Villareal, Omar
> Sent: Monday, February 16, 2009 9:57 AM
> To: Mande, Nikhil; Diaz, Daniel; Turquette, Mike; Castaneda Gonzalez,=
 Axel;
> Munoz, Jose Luis Diaz
> Subject: RE: omap24xxvout alloc DMA page failed when using openMAX
>
> Hi all,
>
> You are rigth, we are working to send the patches to sync up omap zoo=
m with
> 23x, with these changes this issue is gone.
>
> We will keep you updated when this get ready,
>
> Thanks,
>
> Omar Jimenez
> ________________________________________
> De: Mande, Nikhil
> Enviado el: lunes, 16 de febrero de 2009 09:36 a.m.
> Para: Diaz, Daniel; Turquette, Mike
> CC: Jimenez Villareal, Omar
> Asunto: RE: omap24xxvout alloc DMA page failed when using openMAX
>
> Some changes in L23.x kernel are not merged into OMAPZoom kernel yet.
> Now we reserve memory required by display driver at boot time, so we =
don't run
> into this issue.
>
> Omar,
>   I believe we are merging these changes for L23.14, right?
>
> Thanks,
> Nikhil
>
> -----Original Message-----
> From: Diaz, Daniel
> Sent: Monday, February 16, 2009 9:22 AM
> To: Mande, Nikhil; Turquette, Mike
> Subject: FW: omap24xxvout alloc DMA page failed when using openMAX
>
> Hello!
>
> Do you guys have any information on this? This appeared on the linux-=
omap
> mailing list.
>
> Greetings!
>
> Daniel D=EDaz
> ddiaz@ti.com
>
>
>
> ________________________________________
> From: Felipe Contreras [felipe.contreras@gmail.com]
> Sent: Monday, February 16, 2009 4:03 AM
> To: Wang Diancheng
> Cc: linux-omap@vger.kernel.org; Diaz, Daniel
> Subject: Re: omap24xxvout alloc DMA page failed when using openMAX
>
> On Mon, Feb 16, 2009 at 11:14 AM, Wang Diancheng
> <dcwang@redflag-linux.com> wrote:
> > Hey, I posted this independently, and someone suggested I should se=
nd
> > it to this mailing list.
> > I don't read the list, so I'm not sure if this is useful or on-topi=
c
> > or what.  My apologies in advance if this is noise.
> > omap24xxvout alloc DMA page failed when I use openMAX on ZOOM2 boar=
d,
> > following is my test command and output:
> >
> >  gst-launch videotestsrc ! goosink_pp
> > Setting pipeline to PAUSED ...
> > Pipeline is PREROLLING ...
> > ^CVIDIOC_STREAMON: Cannot allocate memory
> > Caught interrupt -- handling interrupt.
>
> I'm cc'ing Daniel D=EDaz, who should know about gst-goo.
>
> Also, you can try gst-omapfb instead:
> http://github.com/felipec/gst-omapfb
>
> --
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
