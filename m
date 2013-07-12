From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: find real users and drivers of rpmsg
Date: Fri, 12 Jul 2013 11:48:53 +0800
Message-ID: <CAGsJ_4zdX0Y_H2U1ffJbnGqvjPWh1n2ERsgZGSGqxZmBE_ftyg@mail.gmail.com>
References: <CAGsJ_4z3-g_u5qHdoje=MASbRBoRMFjCU4jUfrrCc2836E_umQ@mail.gmail.com>
 <CAK=WgbYavJUg3WGU9gCF133kEsFF_1ViAT04SDE7Eps8B4h=tA@mail.gmail.com>
 <51DC841A.9070409@ti.com> <CAGsJ_4w1aK3Za3LpejTWuvHArhoOeXBc6+Ox_ZWx3mVmt42q0g@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504D4660@DLEE11.ent.ti.com>
Reply-To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <pandaboard+bncBD4IBNO3YAGRBOPZ7WHAKGQEHEBOI6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504D4660-hpfExfDTTN2IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Post: <http://groups.google.com/group/pandaboard/post>, <mailto:pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:pandaboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/pandaboard>
Sender: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/pandaboard/subscribe>, <mailto:pandaboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/pandaboard/subscribe>, <mailto:googlegroups-manage+575825281776+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, zilong.wu-kQvG35nSl+M@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2013/7/10 Anna, Suman <s-anna-l0cyMroinI0@public.gmane.org>:
> Barry,
>
>> >> On Mon, Jul 8, 2013 at 10:31 AM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >>> hi Ohad/all,
>> >>> i am trying to find some real users of rpmsg, here i only get
>> >>> samples/rpmsg/rpmsg_client_sample.c, does it mean other real drivers
>> >>> are out of mainline?
>> >>
>> >> Yes
>> >>
>> >>> where could i get them?
>> >>
>> >> TI maintains them in internal trees, some of which might be public.
>> >> I'm looping in Suman from TI who might be able to refer you to some
>> >
>> > You will find couple of rpmsg client drivers in our product kernels.
>> > Following is a kernel used towards our Android product, you can look
>> > in the drivers/rpmsg folder.
>> >
>> > http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-
>> linux-omap-3.4
>>
>> yes. i have repmsg-resmgr and repmsg-omx now. and i also have
>> sysbios-rpmsg and domx. thanks!
>>
>> >
>> >>
>> >>> i am also trying to find source codes running in Cortex-M3 which use
>> >>> rpmsg and hope to find some Linux userspace codes which use rpmsg too.
>> >>> Thanks
>> >>> barry
>> >
>> > Some information from the following wiki might also be handy (kinda old,
>> > but still useful) for you to find the equivalent code running on the
>> > Cortex-M3
>> >
>> > http://omappedia.org/wiki/Category:RPMsg
>>
>> DOMX(Distributed OpenMAX for OMAP4 processors) on the page seems to be
>> based on syslink and lose maintaince for 3 years, where can i get a
>> new version based on rpmsg?
>>
>
> Look through the following project,
> http://git.omapzoom.org/?p=platform/hardware/ti/domx.git;a=shortlog;h=refs/heads/p-jb-mr1-release
>

thanks, Anna.

> regards
> Suman

-barry


-barry

-- 
You received this message because you are subscribed to the Google Groups "pandaboard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to pandaboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
