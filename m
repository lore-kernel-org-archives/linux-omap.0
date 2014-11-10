From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: Re: BeagleBoard-X15 - seriously? :)
Date: Mon, 10 Nov 2014 16:29:35 -0600
Message-ID: <CAGo_u6qsMkvimymMg2nYJ5UkyDOWeNUxZV4uToGgTn+0McE=ig@mail.gmail.com>
References: <CAP3+TEr-AakTZs1rqGFjP7UsTREKW20h+kpc=SvcKqGJyvbseQ@mail.gmail.com>
	<04092472-cf97-458f-a76c-2800368e10d9@googlegroups.com>
	<D083D545.59578%john3909@gmail.com>
	<CAP3+TEp0Xn74Txsf7p1symT+=PJQiO2BKd9wHxJoBYzAASrP4g@mail.gmail.com>
	<CA+T6QPnSdxeB7=jdvWUbuwMWShrDF+6+=gEVRhAOd_MaHaeOaw@mail.gmail.com>
	<D08638F8.59B9B%john3909@gmail.com>
	<CAGo_u6qsbDtc0fj37qiLw62+YT_cdjJ7Oxqu2sZ8P-zDqDJDPQ@mail.gmail.com>
	<D0865AF6.59CA5%john3909@gmail.com>
	<546128DD.2040205@ti.com>
	<D08669B8.59D39%john3909@gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <beagleboard+bncBCO3XAUMTIFRBT7YQSRQKGQE7RGGN6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <D08669B8.59D39%john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/beagleboard/subscribe>
To: BeagleBoard <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 10, 2014 at 3:18 PM, John Syn <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On 11/10/14, 1:06 PM, "Suman Anna" <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>
>>Hi John,
>>
>>On 11/10/2014 02:24 PM, John Syn wrote:
>>>
>>> On 11/10/14, 10:58 AM, "Nishanth Menon" <nm-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>>> On Mon, Nov 10, 2014 at 11:54 AM, John Syn <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>
>>>>> On 11/10/14, 1:15 AM, "Jason Kridner" <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
>>>>>wrote:
>>>>>
>>>>>> On Sun, Nov 9, 2014 at 1:13 AM, Maxim Podbereznyy
>>>>>><lisarden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>> wrote:
>>>>>>> John Syn,
>>>>>>> Wandboard Quad does have 64 bit memory bus.
>>>>>>>
>>>>>>> P.S. I don't know who needs dual DSP onboard because TI definitely
>>>>>>> will
>>>>>>> not
>>>>>>> support them as should like it was for omap3/dm37. I'd better have
>>>>>>> well
>>>>>>> supported hardware video encoder/decoder rather than double general
>>>>>>> purpose
>>>>>>> DSPs without any software support
>>>>>>
>>>>>> When OMAP3 came out, the only compilers for C6000 were expensive,
>>>>>> closed-source compilers. Now, there is support in mainline GCC for
>>>>>> C6000. As the BeagleBoard.org community, we have to work together to
>>>>>> enable use of the DSPs if they are of interest to the
>>>>>> community---there aren't any barriers in our way.
>>>>> The TI C6000 does some amazing pipeline optimization, which seems to
>>>>>be
>>>>> missing from the GCC compiler. Anyway, using CCSV6 is no big deal, bu=
t
>>
>>One should be able to directly download the C6000 compilers at
>>http://software-dl.ti.com/codegen/non-esd/downloads/download.htm#C6000
>>
>>>>> support for RPMSG/REMOTEPROC on this processor is a big issue. The
>>>>> source
>>>>> is difficult to follow and my guess is we would need input from the
>>>>> original authors to do this work.
>>>>
>>>> Why dont we get involved in linux-omap discussions on the topic? most
>>>> of the rpmsg and remote proc discussions do take place in kernel
>>>> mailing list. usually discussing in context helps move patches forward
>>>> since it makes it clear to certain maintainers that these things are
>>>> important and help community.
>>>>
>>>>
>>>> Do you have anything specific that you are concerned about?
>>
>>> Looking at git.ti.com/rpmsg/rpmsg, I don=C2=B9t see any support for AM5=
72x
>>> processors. Also, Beagleboard-X15 is to be released with Kernel V3.18
>>>but
>>> I don=C2=B9t see support for this kernel versions. Last I heard, RPMSG =
was
>>> working on OMAP4, but not fully implemented on OMAP5, but this was a
>>>while
>>> ago and perhaps this has changed. Perhaps Suman can give us an update.
>>> Similar concerns about REMOTEPROC. What I know is that I have been
>>>pushing
>>> this issue on the beta list and the only feedback I received was that
>>> "RPMSG/REMOTEPROC was in a SW blackhole=C2=B2.
>>
>>The rpmsg-ti-linux-3.14.y branch in the above tree is the feature
>>integration branch for rpmsg/remoteproc and does support all the
>>processors on OMAP4, OMAP5 and AM572x/DRA7x. The AM572x support should
>>be present through the am57xx-beagle-x15.dts file (its been sometime
>>since I pulled the required platform branch with any updates to this).
>>
>>I am in the process of pushing all these features/patches upstream, but
>>it will mostly be sometime next year before all the patches and their
>>dependencies will make it into the upstream kernel, so until then have
>>to rely on a TI tree.
> Hi Suman,
>
> That is really good news. I=E2=80=99m guessing that V3.18 support will oc=
cur with
> the push to mainline? Any chance that we will see support when
> Beagleboard-X15 launches in Feb 2015?
>
> Regards,
> John
>>
>>regards
>>Suman
>>
>>>
>>> Based on the TRM, this processor looks extremely attractive, and we nee=
d
>>> RPMSG/REMOTEPROC to take advantage of the powerful dual DSPs and dual
>>> CortexM4s.
>>>

Fixing up linux-omap mailing list

--=20
For more options, visit http://beagleboard.org/discuss
---=20
You received this message because you are subscribed to the Google Groups "=
BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
