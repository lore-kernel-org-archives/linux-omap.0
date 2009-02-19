From: Wang Diancheng <dcwang@redflag-linux.com>
Subject: Re: omap24xxvout alloc DMA page failed when using openMAX
Date: Thu, 19 Feb 2009 14:37:57 +0800
Message-ID: <87ab8j0w56.fsf@redflag-linux.com>
References: <87fxien3ph.fsf@redflag-linux.com>
	<94a0d4530902160203m489098b2sd9bda7322a564a1a@mail.gmail.com>
	<e7df06480902161406s1a403c31gcf0169b60da330f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.redflag-linux.com ([219.237.229.196]:55220 "EHLO
	mail.redflag-linux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbZBSGhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 01:37:45 -0500
In-Reply-To: <e7df06480902161406s1a403c31gcf0169b60da330f9@mail.gmail.com>
	("Daniel =?utf-8?Q?D=E9=9F=86z=22's?= message of "Mon, 16 Feb 2009 16:06:31
 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel =?utf-8?Q?D=E9=9F=86z?= <mrchapp@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>


Hi Daniel and Felipe,
Thank you for your reply,
has the patch fixing this issue merged to omapzoom.org?
I try again with today's kernel and same command, but failed again.

Best Regards,

Diancheng

>>>>> Daniel D=E9=9F=86z <mrchapp@gmail.com> writes:

    > Hello!  If you don't mind the top-posting, please see the quoted
    > chain of emails below. Summary is that some changes need to make
    > it to the omapzoom.org kernel for Zoom2.

    > Greetings!

    > Daniel D=E9=9F=86z ddiaz@ti.com



    > ________________________________________ From: Jimenez Villareal,
    > Omar Sent: Monday, February 16, 2009 11:46 AM To: Mande, Nikhil;
    > Turquette, Mike; Diaz, Daniel; Castaneda Gonzalez, Axel; Munoz,
    > Jose Luis Diaz Subject: RE: omap24xxvout alloc DMA page failed
    > when using openMAX

    > This bootargs are needed since 23.12 release because of memory
    > allocation at boot time but in omap zoom this changes are not
    > merged, first need to be done changes in omap zoom kernel and the=
n
    > when merged 720p resolution support this bootargs will be needed.

    > Regards,

    > Omar Jimenez ________________________________________ De: Mande,
    > Nikhil Enviado el: lunes, 16 de febrero de 2009 10:42 a.m.  Para:
    > Turquette, Mike; Jimenez Villareal, Omar; Diaz, Daniel; Castaneda
    > Gonzalez, Axel; Munoz, Jose Luis Diaz Asunto: RE: omap24xxvout
    > alloc DMA page failed when using openMAX

    > They are related. Both kernel changes and those bootargs are
    > required.

    > -----Original Message----- From: Turquette, Mike Sent: Monday,
    > February 16, 2009 10:32 AM To: Jimenez Villareal, Omar; Mande,
    > Nikhil; Diaz, Daniel; Castaneda Gonzalez, Axel; Munoz, Jose Luis
    > Diaz Subject: RE: omap24xxvout alloc DMA page failed when using
    > openMAX

    > This is probably unrelated, but I saw in another thread by Lajos
    > that it is necessary to set omap24xxfb:rotation=3D0 in the bootar=
gs
    > to avoid some errors when specifically using the Zoom2 board.

    > Obviously a rotation of 0 is the default, but Lajos said it had t=
o
    > be specifically set to avoid some sort of issue.  Maybe related,
    > maybe not.

    > Mike

    >> -----Original Message----- From: Jimenez Villareal, Omar Sent:
    >> Monday, February 16, 2009 9:57 AM To: Mande, Nikhil; Diaz,
    >> Daniel; Turquette, Mike; Castaneda Gonzalez, Axel; Munoz, Jose
    >> Luis Diaz Subject: RE: omap24xxvout alloc DMA page failed when
    >> using openMAX
    >>=20
    >> Hi all,
    >>=20
    >> You are rigth, we are working to send the patches to sync up oma=
p
    >> zoom with 23x, with these changes this issue is gone.
    >>=20
    >> We will keep you updated when this get ready,
    >>=20
    >> Thanks,
    >>=20
    >> Omar Jimenez ________________________________________ De: Mande,
    >> Nikhil Enviado el: lunes, 16 de febrero de 2009 09:36 a.m.  Para=
:
    >> Diaz, Daniel; Turquette, Mike CC: Jimenez Villareal, Omar Asunto=
:
    >> RE: omap24xxvout alloc DMA page failed when using openMAX
    >>=20
    >> Some changes in L23.x kernel are not merged into OMAPZoom kernel
    >> yet.  Now we reserve memory required by display driver at boot
    >> time, so we don't run into this issue.
    >>=20
    >> Omar, I believe we are merging these changes for L23.14, right?
    >>=20
    >> Thanks, Nikhil
    >>=20
    >> -----Original Message----- From: Diaz, Daniel Sent: Monday,
    >> February 16, 2009 9:22 AM To: Mande, Nikhil; Turquette, Mike
    >> Subject: FW: omap24xxvout alloc DMA page failed when using
    >> openMAX
    >>=20
    >> Hello!
    >>=20
    >> Do you guys have any information on this? This appeared on the
    >> linux-omap mailing list.
    >>=20
    >> Greetings!
    >>=20
    >> Daniel D=E9=9F=86z ddiaz@ti.com
    >>=20
    >>=20
    >>=20
    >> ________________________________________ From: Felipe Contreras
    >> [felipe.contreras@gmail.com] Sent: Monday, February 16, 2009 4:0=
3
    >> AM To: Wang Diancheng Cc: linux-omap@vger.kernel.org; Diaz,
    >> Daniel Subject: Re: omap24xxvout alloc DMA page failed when usin=
g
    >> openMAX
    >>=20
    >> On Mon, Feb 16, 2009 at 11:14 AM, Wang Diancheng
    >> <dcwang@redflag-linux.com> wrote:
    >> > Hey, I posted this independently, and someone suggested I
    >> should send > it to this mailing list.  > I don't read the list,
    >> so I'm not sure if this is useful or on-topic > or what.  My
    >> apologies in advance if this is noise.  > omap24xxvout alloc DMA
    >> page failed when I use openMAX on ZOOM2 board, > following is my
    >> test command and output:
    >> >
    >> > gst-launch videotestsrc ! goosink_pp > Setting pipeline to
    >> PAUSED ...  > Pipeline is PREROLLING ...  > ^CVIDIOC_STREAMON:
    >> Cannot allocate memory > Caught interrupt -- handling interrupt.
    >>=20
    >> I'm cc'ing Daniel D=E9=9F=86z, who should know about gst-goo.
    >>=20
    >> Also, you can try gst-omapfb instead:
    >> http://github.com/felipec/gst-omapfb
    >>=20
    >> -- Felipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
